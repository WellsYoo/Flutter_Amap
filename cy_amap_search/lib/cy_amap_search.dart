import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef CYSearchMethodChannelHandler = Future<dynamic> Function(MethodCall call);

class CyAmapSearch {
  static const MethodChannel _channel = const MethodChannel('cy_amap_search');
  static CYSearchMethodChannelHandler _searchMethodChannelHandler;

  static Future<void> search(String keyWord, {String city = ''}) async {
    _channel.setMethodCallHandler(_searchMethodChannelHandler);
    return await _channel.invokeMethod('search', <String, dynamic>{
      'keyWord': keyWord,
      'city': city,
    });
  }

  static Future<void> searchPOI({String lat, String lon}) async {
    _channel.setMethodCallHandler(_searchMethodChannelHandler);
    return await _channel.invokeMethod('searchPOI', <String, dynamic>{
      'lat': lat,
      'lon': lon,
    });
  }

  static void setSearchMethodChannelHandler(CYSearchMethodChannelHandler block) {
    if (block == null) {
      return;
    }
    _searchMethodChannelHandler = block;
  }

  /// 获取骑行距离
  static Future getRidingRouteDistance(
      {@required double startLatitude,
      @required double startLongitude,
      @required double destinationLatitude,
      @required double destinationLongitude}) async {
    // print("----------------------------------------->getRidingRouteDistance");
    _channel.setMethodCallHandler(_searchMethodChannelHandler);

    return await _channel.invokeMethod('getRidingRouteDistance', {
      "startLatitude": startLatitude,
      "startLongitude": startLongitude,
      "destinationLatitude": destinationLatitude,
      "destinationLongitude": destinationLongitude
    });
  }
}
