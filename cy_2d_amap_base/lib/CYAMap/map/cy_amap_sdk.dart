library cyamap_base.map.cy_amap_sdk;

import 'package:flutter/services.dart';

/// 鉴权方法名
const kSetAPIKey = 'cy_flutter_amap_base/sdk/setApiKey';

/// 地图sdk初始化鉴权
class CYAMapSDK {
  /// 鉴权通信
  static const MethodChannel _channel = const MethodChannel('cy_flutter_amap_base');

  static void setAMapKey(String aMapKey) async {
    await _channel.invokeMethod(kSetAPIKey, aMapKey);
  }
}
