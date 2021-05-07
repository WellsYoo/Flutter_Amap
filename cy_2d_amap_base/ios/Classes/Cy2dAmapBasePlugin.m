#import "Cy2dAmapBasePlugin.h"
#import "AMapFoundationKit/AMapFoundationKit.h"

static NSString *kCYAMapSDKChannelName = @"cy_flutter_amap_base";
static NSString *kCYAMapSDKSetApiMethod = @"cy_flutter_amap_base/sdk/setApiKey";

@implementation Cy2dAmapBasePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:kCYAMapSDKChannelName
            binaryMessenger:[registrar messenger]];
  Cy2dAmapBasePlugin* instance = [[Cy2dAmapBasePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([kCYAMapSDKSetApiMethod isEqualToString:call.method]) {
      NSString *key = call.arguments;
      [AMapServices sharedServices].enableHTTPS = YES;
      // 配置高德地图的key
      [AMapServices sharedServices].apiKey = key;
      result(@YES);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
