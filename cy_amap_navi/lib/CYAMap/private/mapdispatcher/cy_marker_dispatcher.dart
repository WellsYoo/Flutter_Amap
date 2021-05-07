import 'package:cy_2d_amap/CYAMap/models/cy_infowindow.dart';
import 'package:cy_2d_amap/CYAMap/models/overlays/cy_marker.dart';
import 'package:flutter/services.dart';

import 'cy_amap_method_id.dart';

/// marker处理类
class CYMarkerDispatcher {
  /// 地图添加Marker
  Future<bool> addMarkerDispatch(MethodChannel _mapChannel, CYMarker marker) async {
    if (null == _mapChannel || null == marker) {
      return false;
    }

    marker.setMethodChannel(_mapChannel);

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYMarkerMethodId.kMapAddMarkerMethod, marker.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 批量添加markers
  Future<bool> addMarkersDispatch(MethodChannel _mapChannel, List<CYMarker> markers) async {
    if (null == _mapChannel || null == markers) {
      return false;
    }

    markers.forEach((marker) {
      marker.setMethodChannel(_mapChannel);
    });

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYMarkerMethodId.kMapAddMarkersMethod,
          markers?.map((marker) => marker.toMap())?.toList() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 添加infowindow
  Future<bool> addInfoWindowDispatch(MethodChannel _mapChannel, CYInfoWindow infoWindow) async {
    if (null == _mapChannel || null == infoWindow) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYInfoWindowMethodId.kMapAddInfoWindowMethod, infoWindow.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 批量添加infowindow
  Future<bool> addInfoWindowsDispatch(
      MethodChannel _mapChannel, List<CYInfoWindow> infoWindows) async {
    if (null == _mapChannel || null == infoWindows) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYInfoWindowMethodId.kMapAddInfoWindowsMethod,
          infoWindows?.map((infoWindow) => infoWindow.toMap())?.toList())) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 批量添加markers
  Future<bool> removeInfoWindowDispatch(MethodChannel _mapChannel, CYInfoWindow infoWindow) async {
    if (null == _mapChannel || null == infoWindow) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYInfoWindowMethodId.kMapRemoveInfoWindowMethod, infoWindow.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// map 指定删除marker
  Future<bool> removeMarkerDispatch(MethodChannel _mapChannel, CYMarker marker) async {
    if (null == _mapChannel || null == marker) {
      return false;
    }
    bool result = false;

    marker.setMethodChannel(null);

    try {
      result = (await _mapChannel.invokeMethod(
          CYMarkerMethodId.kMapRemoveMarkerMethod, marker.toMap())) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 批量删除markers
  Future<bool> removeMarkersDispatch(MethodChannel _mapChannel, List<CYMarker> markers) async {
    if (null == _mapChannel || null == markers) {
      return false;
    }

    markers.forEach((marker) {
      marker.setMethodChannel(null);
    });

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYMarkerMethodId.kMapRemoveMarkersMethod,
          markers?.map((marker) => marker.toMap())?.toList() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// map 清除所有的markers
  Future<bool> cleanAllMarkersDispatch(MethodChannel _mapChannel) async {
    if (null == _mapChannel) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYMarkerMethodId.kMapCleanAllMarkersMethod)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新marker属性
  Future<bool> updateMarkerMember(MethodChannel _mapChannel, Map map) async {
    if (null == _mapChannel || null == map) {
      return false;
    }
    bool result = false;
    try {
      result =
          (await _mapChannel.invokeMethod(CYMarkerMethodId.kMapUpdateMarkerMember, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
