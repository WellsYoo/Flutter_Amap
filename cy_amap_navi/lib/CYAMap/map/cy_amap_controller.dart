library bmfmap_map.map.bmf_map_controller;

import 'package:cy_2d_amap/CYAMap/models/cy_amap_options.dart';
import 'package:cy_2d_amap/CYAMap/models/cy_mapstatus.dart';
import 'package:cy_2d_amap/CYAMap/models/overlays/cy_circle.dart';
import 'package:cy_2d_amap/CYAMap/models/overlays/cy_marker.dart';
import 'package:cy_2d_amap/CYAMap/private/mapdispatcher/cy_amap_dispatcher_factory.dart';
import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart';
import 'package:cy_2d_amap/CYAMap/private/cy_method_channel_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cy_projection.dart';

/// 地图通信中心
class CYAMapController {
  // static const _tag = "BMFMapController";

  /// 通信
  MethodChannel _mapChannel;

  CYMethodChannelHandler _methodChannelHandler;

  CYAMapController.withId(int id) {
    _init(id);
  }

  void _init(int id) {
    _initMethodChannel(id);
    CYProjection.instance.init(_mapChannel);
  }

  void _initMethodChannel(int id) {
    _mapChannel = MethodChannel('flutter_bmfmap/map_' + String.fromCharCode(id + 97));
    _methodChannelHandler = CYMethodChannelHandler();
    _mapChannel.setMethodCallHandler(_handlerMethod);
  }

  /// 更新地图新状态
  ///
  /// [BMFMapStatus] mapStatus 地图新状态
  ///
  /// animateDurationMs 动画更新时间
  ///
  /// bool 成功返回true 失败false
  Future<bool> setNewMapStatus({@required CYAMapStatus mapStatus, int animateDurationMs}) async {
    return await CYAMapDispatcherFactory.instance.getMapStateDispatcher().setNewMapStatusDispatch(
        _mapChannel,
        mapStatus: mapStatus,
        animateDurationMs: animateDurationMs);
  }

  /// flutter -> native
  ///
  /// 更新地图属性
  ///
  /// [BMFMapOptions] change 地图参数集合
  ///
  /// bool 更新成功返回true 失败false
  Future<bool> updateMapOptions(CYAMapOptions change) async {
    return await CYAMapDispatcherFactory.instance
        .getMapStateDispatcher()
        .updateMapOptionsDispatch(_mapChannel, change);
  }

  // 地图代理回调
  //
  // native -> flutter
  Future<dynamic> _handlerMethod(MethodCall call) async {
    CYAMapLog.d("_handlerMethod====>method: ${call.method} arguments: ${call.arguments}");
    if (_methodChannelHandler != null) {
      return await _methodChannelHandler.handlerMethod(call);
    }
  }

  //地图添加Marker
  // [CYMarker] marker 大头针
  //
  // bool 成功返回true 失败false
  Future<bool> addMarker(CYMarker marker) async {
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .addMarkerDispatch(_mapChannel, marker);
  }

  // 地图指定删除Marker
  //
  // [BMFMarker] marker 要移除的大头针
  //
  // bool 成功返回true 失败false
  Future<bool> removeMarker(CYMarker marker) async {
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .removeMarkerDispatch(_mapChannel, marker);
  }

  // 地图添加Circle
  //
  // [BMFCircle] circle 圆
  //
  // bool 成功返回true 失败false
  Future<bool> addCircle(CYCircle circle) async {
    return await CYAMapDispatcherFactory.instance
        .getOverlayDispatcher()
        .addCircleDispatch(_mapChannel, circle);
  }

  // 地图指定删除overlay
  //
  // overlayId 要删除overlay的id
  //
  // bool 成功返回true 失败false
  Future<bool> removeOverlay(String overlayId) async {
    return await CYAMapDispatcherFactory.instance
        .getOverlayDispatcher()
        .removeOverlayDispatch(_mapChannel, overlayId);
  }

  /// 设置点中底图空白处会回调接口
  ///
  /// [BMFMapCoordinateCallback] callback 回调接口
  void setMapViewDidSingleTappedCallback({@required CYAMapCoordinateCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapViewDidSingleTappedCallback(callback);
    }
  }

  /// 设置地图区域改变完成后会调用接口
  ///
  /// [BMFMapRegionChangeCallback] callback 回调接口
  void setMapRegionDidChangeCallback({@required CYAMapRegionChangeCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapRegionDidChangeCallback(callback);
    }
  }

  /// 设置地图加载完成回调
  ///
  /// [BMFMapCallback] callback 回调接口
  void setMapDidLoadCallback({@required CYAMapCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapDidLoadCallback(callback);
    }
  }

  /// 地图设定是否显示定位图层
  ///
  /// show 展示ture 隐藏false
  ///
  /// bool 成功返回true 失败false
  Future<bool> showUserLocation(bool show) async {
    return await CYAMapDispatcherFactory.instance
        .getMapUserLocationDispatcher()
        .setShowUserLocationDispatch(_mapChannel, show);
  }

  /// 设定定位模式
  ///
  /// [BMFUserTrackingMode]userTrackingMode 定位模式
  ///
  /// enableDirection  是否允许显示方向信息 (Android 独有）
  ///
  /// customMarker  设置用户自定义定位图标，可以为 null (Android  独有)
  ///
  /// bool 成功返回true 失败false
  Future<bool> setUserTrackingMode(CYUserTrackingMode userTrackingMode,
      {bool enableDirection = true, String customMarker}) async {
    return await CYAMapDispatcherFactory.instance
        .getMapUserLocationDispatcher()
        .setUserTrackingModeDispatch(_mapChannel, userTrackingMode, enableDirection,
            customMarker: customMarker);
  }
}
