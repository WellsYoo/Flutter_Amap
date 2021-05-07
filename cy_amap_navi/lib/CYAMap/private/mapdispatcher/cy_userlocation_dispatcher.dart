import 'package:cy_2d_amap/CYAMap/models/cy_userlocation.dart';
import 'package:cy_2d_amap_base/CYAMap/map/cy_amap_types.dart';
import 'package:flutter/services.dart';

import 'cy_amap_method_id.dart';

/// 地图定位图层
class CYUserLocationDispatcher {
  /// 设定是否显示定位图层
  Future<bool> setShowUserLocationDispatch(MethodChannel _mapChannel, bool show) async {
    if (_mapChannel == null || show == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYUserlocationMethodId.kMapShowUserLocationMethod, {'show': show} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 设定定位模式，取值为：BMFUserTrackingMode
  ///
  /// enableDirection  是否允许显示方向信息 (Android) 生效
  /// customMarker  设置用户自定义定位图标，可以为 null (Android)生效
  Future<bool> setUserTrackingModeDispatch(
      MethodChannel _mapChannel, CYUserTrackingMode userTrackingMode, bool enableDirection,
      {String customMarker}) async {
    if (_mapChannel == null || userTrackingMode == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYUserlocationMethodId.kMapUserTrackingModeMethod,
          {
            'userTrackingMode': userTrackingMode.index,
            'enableDirection': enableDirection,
            'customMarker': customMarker
          } as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    print("------> $result");
    return result;
  }

  /// 定位坐标点是否在当前地图可视区域内
  Future<bool> setIsUserLocationVisibleDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return false;
    }
    bool result = false;
    try {
      Map map = (await _mapChannel.invokeMethod(CYUserlocationMethodId.kMapShowUserLocationMethod))
          as Map;
      result = map['userLocationVisible'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 动态更新我的位置数据
  ///
  /// userLocation	定位数据
  Future<bool> setUpdateLocationDataDispatch(
      MethodChannel _mapChannel, CYUserLocation userLocation) async {
    if (_mapChannel == null || userLocation == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYUserlocationMethodId.kMapUpdateLocationDataMethod,
          {'userLocation': userLocation.toMap()} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 动态定制我的位置样式
  ///
  /// userlocationDisplayParam	样式参数
  Future<bool> setUpdateLocationViewWithParamDispatch(
      MethodChannel _mapChannel, BMFUserlocationDisplayParam userlocationDisplayParam) async {
    if (_mapChannel == null || userlocationDisplayParam == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYUserlocationMethodId.kMapUpdateLocationDisplayParamMethod,
          {'userlocationDisplayParam': userlocationDisplayParam.toMap()} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
