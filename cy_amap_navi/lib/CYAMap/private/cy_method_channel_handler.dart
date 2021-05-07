import 'package:cy_2d_amap/CYAMap/models/cy_mapstatus.dart';
import 'package:cy_2d_amap/CYAMap/private/mapdispatcher/cy_amap_method_id.dart';
import 'package:flutter/services.dart';
import 'package:cy_2d_amap_base/CYAMap/map/cy_amap_models.dart';

/// 地图无参数回调
typedef CYAMapCallback = void Function();

/// 地图经纬度回调
typedef CYAMapCoordinateCallback = void Function(CYCoordinate coordinate);

/// 地图区域改变回调
typedef CYAMapRegionChangeCallback = void Function(CYAMapStatus mapStatus);

///处理native发送过来的消息
class CYMethodChannelHandler {
  static const sTag = 'CYMethodChannelHandler';

  /// 单击地图底图调用此接口
  CYAMapCoordinateCallback _mapViewDidSingleTappedCallback;

  /// 地图区域改变完成后会调用此接口
  CYAMapRegionChangeCallback _mapRegionDidChangeCallback;

  /// 加载完成回调
  CYAMapCallback _mapDidLoadCallback;

  dynamic handlerMethod(MethodCall call) async {
    switch (call.method) {
      case CYAMapCallbackMethodId.kMapDidLoadCallback:
        {
          if (this._mapDidLoadCallback != null) {
            this._mapDidLoadCallback();
          }
          break;
        }
      case CYAMapCallbackMethodId.kCYDidSingleTappedAtCoordinateCallback:
        {
          if (this._mapViewDidSingleTappedCallback != null) {
            CYCoordinate coordinate = CYCoordinate.coordinate().fromMap(call.arguments['coord']);
            this._mapViewDidSingleTappedCallback(coordinate);
          }
        }
        break;
      case CYAMapCallbackMethodId.kMapRegionDidChangeCallback:
        {
          if (this._mapRegionDidChangeCallback != null) {
            CYAMapStatus mapStatus = CYAMapStatus.mapStatus().fromMap(call.arguments['mapStatus']);
            this._mapRegionDidChangeCallback(mapStatus);
          }
          break;
        }
    }
  }

  /// 地图加载完成回调
  void setMapDidLoadCallback(CYAMapCallback block) {
    if (block == null) {
      return;
    }
    this._mapDidLoadCallback = block;
  }

  /// 单击地图底图调用此接口
  void setMapViewDidSingleTappedCallback(CYAMapCoordinateCallback block) {
    if (block == null) {
      return;
    }
    this._mapViewDidSingleTappedCallback = block;
  }

  /// 地图区域改变完成后会调用此接口
  void setMapRegionDidChangeCallback(CYAMapRegionChangeCallback block) {
    if (block == null) {
      return;
    }
    this._mapRegionDidChangeCallback = block;
  }
}
