
import 'dart:async';

import 'package:flutter/services.dart';

class CyAmapNavi {
  static const MethodChannel _channel =
      const MethodChannel('cy_amap_navi');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
