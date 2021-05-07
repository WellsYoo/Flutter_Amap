library cyamap_base.map.cy_types;

//地图类型 底图展示的地图类型
enum CYAMapType {
  // 普通地图
  CYAMapTypeStandard,
  // 卫星地图
  CYAMapTypeSatellite,
  // 夜间视图
  CYAMapTypeStandardNight,
  // 导航视图
  CYMapTypeNavi,
  //公交视图
  CYMapTypeBus
}

//用户跟踪模式
enum CYUserTrackingMode {
  //<不追踪用户的location更新
  CYUserTrackingModeNone,
  //<追踪用户的location更新
  CYUserTrackingModeFollow,
  //<追踪用户的location与heading更新
  CYUserTrackingModeFollowWithHeading,
}

// 交通拥堵状态
enum CYTrafficStatus {
  //无意义，占位
  None,

  //<通畅
  CYTrafficStatusSmooth,

  //<缓行
  CYTrafficStatusSlow,

  //<阻塞
  CYTrafficStatusJam,

  //<严重阻塞
  CYTrafficStatusSeriousJam,
}

// 绘制overlay的层级
enum CYOverlayLevel {
  ///<在地图底图标注和兴趣点图标之下绘制overlay
  MAOverlayLevelAboveRoads,

  ///<在地图底图标注和兴趣点图标之上绘制overlay
  MAOverlayLevelAboveLabels,
}

/// native view类型,android独有
class CYNativeViewType {
  /// 对应native端的MapView
  static const sMapView = 'flutter_cyamap/map/CYMapView';

  /// 对应native端的TextureMapView
  static const sTextureMapView = 'flutter_cyamap/CYMap/TextureMapView';
}
