library cyamap_map.models.cy_map_options;

import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart';

/// mapView属性集合
class CYAMapOptions {
  static CYAMapOptions mapOptions() => CYAMapOptions();

  /// 当前地图类型，默认标准地图
  ///
  /// MapTypeNone = MapTypeNone
  ///
  /// 标准地图 = MapTypeStandard
  ///
  /// 卫星地图 = MapTypeSatellite
  CYAMapType mapType;

  /// 指南针的位置，设定坐标以BMKMapView左上角为原点，向右向下增长
  CYPoint compassOrigin;

  /// 当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
  CYCoordinate center;

  /// 缩放级别（默认3-19，有室内地图时为3-20）
  double zoomLevel;

  /// 最小缩放级别zzz
  int minZoomLevel;

  /// /最大缩放级别（有室内地图时最大为20，否则为19）
  int maxZoomLevel;

  /// 设置地图旋转角度(逆时针为正向)
  double rotationDegree;

  /// 设定地图View能否支持用户多点缩放(双指)
  bool zoomEnabled;

  //绘制规划路径
  CYAMapRoute aMapRoute;

  //android 路径规划路线
  Map androidRideRouteResult;

  /// CYAMapOptions构造方法
  CYAMapOptions(
      {this.mapType: CYAMapType.CYAMapTypeStandard,
      this.compassOrigin,
      this.center,
      this.zoomLevel,
      this.minZoomLevel,
      this.maxZoomLevel,
      this.zoomEnabled,
      this.aMapRoute,
      this.androidRideRouteResult});

  /// CyAMapOptions -> map
  Map<String, Object> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mapType'] = this.mapType?.index;
    data['compassPosition'] = this.compassOrigin?.toMap();
    data['center'] = this.center?.toMap();

    data['zoomLevel'] = this.zoomLevel;
    data['minZoomLevel'] = this.minZoomLevel;
    data['maxZoomLevel'] = this.maxZoomLevel;
    data['zoomEnabled'] = this.zoomEnabled;

    data['aMapRoute'] = this.aMapRoute?.toJson();
    data['androidRideRouteResult'] = this.androidRideRouteResult;
    return data;
  }
}
