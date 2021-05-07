import 'package:cy_2d_amap/CYAMap/models/overlays/cy_circle.dart';
import 'package:cy_2d_amap/CYAMap/private/mapdispatcher/cy_amap_method_id.dart'
    show CYOverlayMethodId;
import 'package:flutter/services.dart';

/// polyline, arcline, polygon, circle
/// Dot Text (Android)
class CYOverlayDispatcher {
  static const _tag = 'CYOverlayDispatcher';

  // /// 地图添加Polyline
  // Future<bool> addPolylineDispatch(MethodChannel _mapChannel, CYPolyline polyline) async {
  //   if (null == _mapChannel || null == polyline) {
  //     return false;
  //   }

  //   polyline.setMethodChannel(_mapChannel);

  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYOverlayMethodId.kMapAddPolylineMethod, polyline.toMap() as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  // /// 地图添加arcline
  // Future<bool> addArclineDispatch(MethodChannel _mapChannel, CYArcline arcline) async {
  //   if (null == _mapChannel || null == arcline) {
  //     return false;
  //   }

  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYOverlayMethodId.kMapAddArclinelineMethod, arcline.toMap() as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  // /// 地图添加polygon
  // Future<bool> addPolygonDispatch(MethodChannel _mapChannel, CYPolygon polygon) async {
  //   if (null == _mapChannel || null == polygon) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYOverlayMethodId.kMapAddPolygonMethod, polygon.toMap() as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  /// 地图添加circle
  Future<bool> addCircleDispatch(MethodChannel _mapChannel, CYCircle circle) async {
    if (null == _mapChannel || null == circle) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYOverlayMethodId.kMapAddCircleMethod, circle.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  // /// 地图添加Dot
  // Future<bool> addDotDispatch(MethodChannel _mapChannel, CYDot dot) async {
  //   if (null == _mapChannel || null == dot) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYOverlayMethodId.kMapAddDotMethod, dot?.toMap() as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  // /// 地图添加Text
  // Future<bool> addTextDispatch(MethodChannel _mapChannel, CYText text) async {
  //   if (null == _mapChannel || null == text) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYOverlayMethodId.kMapAddTextMethod, text.toMap() as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  // /// 地图添加Ground
  // Future<bool> addGroundDispatch(MethodChannel _mapChannel, CYGround ground) async {
  //   if (null == _mapChannel || null == ground) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYOverlayMethodId.kMapAddGroundMethod, ground.toMap() as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  // /// 添加瓦片图
  // Future<bool> addTileDispatch(MethodChannel _mapChannel, CYTile tile) async {
  //   if (tile == null || _mapChannel == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYOverlayMethodId.kMapAddTileMethod, tile?.toMap() as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     CYLog.e(e.toString(), tag: _tag);
  //   }
  //   return result;
  // }

  // /// 移除瓦片图
  // Future<bool> removeTileDispatch(MethodChannel _mapChannel, CYTile tile) async {
  //   if (tile == null || _mapChannel == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYOverlayMethodId.kMapRemoveTileMethod, tile?.toMap() as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     CYLog.e(e.toString(), tag: _tag);
  //   }
  //   return result;
  // }

  /// 指定id删除overlay
  Future<bool> removeOverlayDispatch(MethodChannel _mapChannel, String overlayId) async {
    if (null == _mapChannel || null == overlayId) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYOverlayMethodId.kMapRemoveOverlayMethod, {'id': overlayId} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新overlay属性
  Future<bool> updateOverlayMemberDispatch(MethodChannel _mapChannel, Map map) async {
    if (null == _mapChannel || null == map) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYOverlayMethodId.kMapUpdatePolylineMemberMethod, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
