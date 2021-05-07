//
//  CYSearchModels.m
//  cy_2d_amap_base
//
//  Created by Wells Ye on 2020/12/10.
//

#import "CYRouteModels.h"


@implementation CYAMapStep

- (AMapStep *)toAMapStep {
    AMapStep *aMapStep = [AMapStep new];
    aMapStep.instruction = self.instruction;
    aMapStep.orientation = self.orientation;
    aMapStep.road = self.road;
    aMapStep.distance = self.distance;
    aMapStep.duration = self.duration;
    aMapStep.polyline = self.polyline;
    aMapStep.action = self.action;
    aMapStep.assistantAction = self.assistantAction;
    aMapStep.tolls = self.tolls;
    aMapStep.tollDistance = self.tollDistance;
    aMapStep.tollRoad = self.tollRoad;


    return aMapStep;
}

+ (CYAMapStep *)fromAMapStep:(AMapStep *)aMapStep {
    CYAMapStep *cyAMapStep = [CYAMapStep new];
    
    cyAMapStep.instruction = aMapStep.instruction;
    cyAMapStep.orientation = aMapStep.orientation;
    cyAMapStep.road = aMapStep.road;
    cyAMapStep.distance = aMapStep.distance;
    cyAMapStep.duration = aMapStep.duration;
    cyAMapStep.polyline = aMapStep.polyline;
    cyAMapStep.action = aMapStep.action;
    cyAMapStep.assistantAction = aMapStep.assistantAction;
    cyAMapStep.tolls = aMapStep.tolls;
    cyAMapStep.tollDistance = aMapStep.tollDistance;
    cyAMapStep.tollRoad = aMapStep.tollRoad;
    return  cyAMapStep;
}


+ (NSDictionary *)cy_setupObjectClassInArray{
    return @{@"instruction" : @"NSString",
             @"orientation" : @"NSString",
             @"road" : @"NSString",
             @"distance" : @"NSArray",
             @"duration" : @"NSNumber",
             @"polyline" : @"NSString",
             @"action" : @"NSString",
             @"assistantAction" : @"NSString",
             @"tolls" : @"NSString",
             
             @"tollDistance" : @"NSNumber",
             @"tollRoad" : @"NSString",
    };
}
@end



@implementation CYAMapPath

- (AMapPath *)toAMapPath {
    
    AMapPath *aMapPath = [AMapPath new];
    aMapPath.distance = self.distance;
    aMapPath.duration = self.duration;
    aMapPath.strategy = self.strategy;
    NSMutableArray<AMapStep *> *steps = [NSMutableArray new];
    for (CYAMapStep *cyAMapStep  in self.steps) {
        AMapStep *aMapStep = [cyAMapStep toAMapStep];
        [steps addObject:aMapStep];
    }
    aMapPath.steps = steps;
    aMapPath.tolls = self.tolls;
    aMapPath.tollDistance = self.tollDistance;
    aMapPath.totalTrafficLights = self.totalTrafficLights;
    aMapPath.restriction = self.restriction;
    aMapPath.polyline = self.polyline;

    return aMapPath;
}

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"steps" : [CYAMapStep class], };
}

+ (CYAMapPath *)fromAMapPath:(AMapPath *)aMapPath {
    CYAMapPath *cyAMapPath = [CYAMapPath new];
    
    cyAMapPath.distance = aMapPath.distance;
    cyAMapPath.duration = aMapPath.duration;
    cyAMapPath.strategy = aMapPath.strategy;
    NSMutableArray<CYAMapStep *> *steps = [NSMutableArray new];
    for (AMapStep *aMapStep  in aMapPath.steps) {
        CYAMapStep *cyAMapStep  = [CYAMapStep fromAMapStep:aMapStep];
        [steps addObject:cyAMapStep];
    }
    cyAMapPath.steps = steps;
    cyAMapPath.tolls = aMapPath.tolls;
    cyAMapPath.tollDistance = aMapPath.tollDistance;
    cyAMapPath.totalTrafficLights = aMapPath.totalTrafficLights;
    cyAMapPath.restriction = aMapPath.restriction;
    cyAMapPath.polyline = aMapPath.polyline;

    return cyAMapPath;
}

+ (NSDictionary *)cy_setupObjectClassInArray{
    return @{@"distance" : @"NSNumber",
             @"duration" : @"NSNumber",
             @"strategy" : @"NSString",
             @"steps" : @"NSArray",
             @"tolls" : @"NSNumber",
             @"tollDistance" : @"NSNumber",
             @"totalTrafficLights" : @"NSNumber",
             @"restriction" : @"NSNumber",
             @"polyline" : @"NSString",
    };
}


@end



@implementation CYAMapRoute
/////起点坐标
//@property (nonatomic, copy) CYCoordinate *origin;
/////终点坐标
//@property (nonatomic, copy) CYCoordinate *destination;
/////出租车费用（单位：元）
//@property (nonatomic, assign) CGFloat  taxiCost;
/////步行、骑行、驾车方案列表 AMapPath 数组
//@property (nonatomic, strong) NSArray<CYAMapPath *> *paths;


- (AMapRoute *)toAMapRoute {
    AMapRoute *aMapRoute = [AMapRoute new];
    aMapRoute.origin = [AMapGeoPoint locationWithLatitude:self.origin.latitude longitude:self.origin.longitude];
    aMapRoute.destination = [AMapGeoPoint locationWithLatitude:self.destination.latitude longitude:self.destination.longitude];
    aMapRoute.taxiCost = self.taxiCost;
    NSMutableArray<AMapPath *> *paths = [NSMutableArray new];
    for (CYAMapPath *cyAMapPath in self.paths) {
        AMapPath *aMapPath = [cyAMapPath toAMapPath];
        [paths addObject:aMapPath];
    }
    aMapRoute.paths = paths;
    return aMapRoute;
}

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"paths" : [CYAMapPath class], };
}


+ (CYAMapRoute *)fromAMapRoute:(AMapRoute *)aMapRoute {
    CYAMapRoute *cyAMapRoute = [CYAMapRoute new];
    CYCoordinate *origin = [CYCoordinate new];
    origin.latitude = aMapRoute.origin.latitude;
    origin.longitude = aMapRoute.origin.longitude;
    cyAMapRoute.origin = origin;

    CYCoordinate *destination = [CYCoordinate new];
    destination.latitude = aMapRoute.destination.latitude;
    destination.longitude = aMapRoute.destination.longitude;
    cyAMapRoute.destination = destination;
    
    cyAMapRoute.taxiCost = aMapRoute.taxiCost;
    NSMutableArray<CYAMapPath *> *paths = [NSMutableArray new];
    for (AMapPath *aMapPath in aMapRoute.paths) {
        CYAMapPath *cyAMapPath = [CYAMapPath fromAMapPath:aMapPath];
        [paths addObject:cyAMapPath];
    }
    
    cyAMapRoute.paths = paths;

    return cyAMapRoute;
}

+ (NSDictionary *)cy_setupObjectClassInArray{
    return @{@"origin" : @"CYCoordinate",
             @"destination" : @"CYCoordinate",
             @"taxiCost" : @"NSNumber",
             @"paths" : @"NSArray",
          
    };
}

@end
