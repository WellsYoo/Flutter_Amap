#import "CyAmapSearchPlugin.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "CYRouteModels.h"
@interface CyAmapSearchPlugin()<AMapSearchDelegate>
@property (strong, nonatomic) AMapSearchAPI *search;
@property (nonatomic, retain) FlutterMethodChannel* channel;
@property (nonatomic, strong) FlutterResult result;

@end

@implementation CyAmapSearchPlugin

NSString* _types = @"010000|010100|020000|030000|040000|050000|050100|060000|060100|060200|060300|060400|070000|080000|080100|080300|080500|080600|090000|090100|090200|090300|100000|100100|110000|110100|120000|120200|120300|130000|140000|141200|150000|150100|150200|160000|160100|170000|170100|170200|180000|190000|200000";

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"cy_amap_search"
                                     binaryMessenger:[registrar messenger]];
    CyAmapSearchPlugin* instance = [[CyAmapSearchPlugin alloc] init];
    instance.channel = channel;
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    _result = result;
    NSString* method = call.method;
    if ([@"search" isEqualToString:method]) {
        NSString *keywords            = [call arguments][@"keyWord"];
        NSString *city                = [call arguments][@"city"];
        [self search:keywords city:city];
        
    } else if([@"searchPOI" isEqualToString:method]){
        NSString* lat = [call arguments][@"lat"];
        NSString* lon = [call arguments][@"lon"];
        [self searchPOI:(CGFloat)[lat doubleValue] lon: [lon doubleValue]];
    } else if([@"getRidingRouteDistance" isEqualToString:method]){
//        NSLog(@"------------------>getRidingRouteDistance");
        [self getRidingRouteDistance:call.arguments];
    }
    else{
        result(FlutterMethodNotImplemented);
    }
}


- (AMapSearchAPI *)search{
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}


- (void)searchPOI:(CGFloat)lat lon:(CGFloat)lon{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.types               = _types;
    request.requireExtension    = YES;
    request.offset              = 50;
    request.location            = [AMapGeoPoint locationWithLatitude:lat longitude:lon];
    [self.search AMapPOIAroundSearch:request];
}

- (void)search:(NSString *)keyWord city:(NSString *)city{
    if([keyWord isEqual:[NSNull null]]){
        [_channel invokeMethod:@"onRouteSearchDone"
                     arguments:@{}
                        result:nil];
    } else {
        AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
        request.types               = _types;
        request.requireExtension    = YES;
        request.offset              = 50;
        request.keywords            = keyWord;
        request.city                = city;
        
        [self.search AMapPOIKeywordsSearch:request];
    }

}

- (void)getRidingRouteDistance:(NSDictionary*)args {
    AMapRidingRouteSearchRequest *navi = [[AMapRidingRouteSearchRequest alloc] init];
    if(args.count>0){
        
        if (args[@"startLatitude"] == [NSNull null]||args[@"startLongitude"] == [NSNull null]||args[@"destinationLatitude"] ==  [NSNull null]||args[@"destinationLongitude"]  ==[NSNull null]) {
            NSDictionary* arguments = @{@"didFailWithError" : @"argu is null"};
            [_channel invokeMethod:@"searchRequestDidFailWithError" arguments:arguments];
            
        } else {
            /* 出发点. */
            navi.origin = [AMapGeoPoint locationWithLatitude:[args[@"startLatitude"] doubleValue]
                                                   longitude:[args[@"startLongitude"] doubleValue]];
            /* 目的地. */
            navi.destination = [AMapGeoPoint locationWithLatitude:[args[@"destinationLatitude"] doubleValue]
                                                        longitude:[args[@"destinationLongitude"] doubleValue]];
            [self.search AMapRidingRouteSearch:navi];
        }
        
    }
    
}

#pragma mark -AMapSearchDelegate
/**
 * @brief 当请求发生错误时，会调用代理的此方法.
 * @param request 发生错误的请求.
 * @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSDictionary* arguments = @{@"didFailWithError" : error.description};
    [_channel invokeMethod:@"searchRequestDidFailWithError" arguments:arguments];
}

/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count == 0) {
        NSDictionary* arguments = @{@"poiSearchResult" : @"[]"};
        [_channel invokeMethod:@"poiSearchResult" arguments:arguments];
        return;
    }
    
    //1. 初始化可变字符串，存放最终生成json字串
    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:@"["];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *string  = [NSString stringWithFormat:@"{\"cityCode\":\"%@\",\"cityName\":\"%@\",\"address\":\"%@\",\"provinceName\":\"%@\",\"title\":\"%@\",\"adName\":\"%@\",\"adCode\":\"%@\",\"provinceCode\":\"%@\",\"latitude\":\"%f\",\"longitude\":\"%f\"},", obj.citycode, obj.city,obj.address, obj.province, obj.name, obj.district,obj.adcode, obj.pcode, obj.location.latitude, obj.location.longitude];
        [jsonString appendString:string];
        
    }];
    
    // 3. 获取末尾逗号所在位置
    NSUInteger location = [jsonString length] - 1;
    
    NSRange range = NSMakeRange(location, 1);
    
    // 4. 将末尾逗号换成结束的]
    [jsonString replaceCharactersInRange:range withString:@"]"];
    
    NSDictionary* arguments = @{
        @"poiSearchResult" : jsonString
    };
    [_channel invokeMethod:@"poiSearchResult" arguments:arguments];
}


//路径规划搜索完成回调.
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
//    if (response.route == nil){
//
//        [_channel invokeMethod:@"onRouteSearchDone" arguments:[NSNull null]];
//        return;
//    } else {
//        CYAMapRoute *cyAMapRoute = [CYAMapRoute fromAMapRoute:response.route];
//
//        NSString *string = [self dictionaryToJson: cyAMapRoute.cy_toDictionary];
//        [_channel invokeMethod:@"onRouteSearchDone" arguments:string];
//
//    }
    if (response.route == nil){

        [_channel invokeMethod:@"onRouteSearchDone"
                     arguments:@{}
                        result:nil];
        return;
    } else {
        CYAMapRoute *cyAMapRoute = [CYAMapRoute fromAMapRoute:response.route];
//        _result(@{@"route":cyAMapRoute.cy_toDictionary});
        
        [_channel invokeMethod:@"onRouteSearchDone"
                     arguments:@{@"route": [cyAMapRoute cy_toDictionary]}
                        result:nil];
    
    
//    [_channel invokeMethod:kBMFMapRegionDidChangeCallback
//                 arguments:@{@"mapStatus": [mapStatus cy_toDictionary]}
//                    result:nil];
    }
}


//dic -> json
- (NSString *)dictionaryToJson:(NSDictionary *)dic {
    NSError *error = nil;
     
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
     
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
