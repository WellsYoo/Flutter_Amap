library cyamap_map.models.cy_mapstatus;

import 'package:cy_2d_amap_base/CYAMap/map/cy_amap_models.dart';

/// 此类表示地图状态信息
class CYAMapStatus implements CYModel {
  static CYAMapStatus mapStatus() => CYAMapStatus();

  /// 缩放级别:(4-21)
  double zoomLevel;

  ///设置地图旋转角度(逆时针为正向), 单位度, [0,360)
  double rotationDegree;

  ///设置地图相机角度(范围为[0.f, 45.f])
  double cameraDegree;

  /// 屏幕中心点坐标:在屏幕内，超过无效
  CYCoordinate centerCoordinate;

  ///地图的视图锚点。坐标系归一化，(0, 0)为MAMapView左上角，(1, 1)为右下角。默认为(0.5, 0.5)，即当前地图的视图中心
  CYPoint screenAnchor;

  /// 当前屏幕显示范围内的地理范围
  // CYCoordinateBounds coordinateBounds;

  /// CYMapStatus构造方法
  CYAMapStatus({
    this.zoomLevel,
    this.rotationDegree,
    this.centerCoordinate,
    this.cameraDegree,
    this.screenAnchor,
    // this.coordinateBounds
  });

  @override
  fromMap(Map map) {
    if (map == null) {
      return null;
    }
    return new CYAMapStatus(
        zoomLevel: map['zoomLevel'],
        rotationDegree: map['rotationDegree'],
        cameraDegree: map['cameraDegree'],
        screenAnchor: CYPoint?.point()?.fromMap(map['screenAnchor'])?.fromMap(map['screenAnchor']),
        centerCoordinate: CYCoordinate?.coordinate()?.fromMap(map['centerCoordinate']));
  }

  @override
  Map<String, Object> toMap() {
    return {
      'zoomLevel': this.zoomLevel,
      'rotationDegree': this.rotationDegree,
      'cameraDegree': this.cameraDegree,
      'centerCoordinate': this.centerCoordinate?.toMap(),
      'screenAnchor': this.screenAnchor?.toMap(),
      // 'visibleMapBounds': this.coordinateBounds?.toMap()
    };
  }
}
