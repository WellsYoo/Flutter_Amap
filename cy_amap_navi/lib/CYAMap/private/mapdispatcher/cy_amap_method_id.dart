/// 用于methodChannel合native的方法id约定

/// 地图状态方法ID集合
class CYAMapStateMethodId {
  /// 更新地图参数
  static const kMapUpdateMethod = 'flutter_bmfmap/map/updateMapOptions';

  /// map放大一级比例尺
  static const kMapZoomInMethod = 'flutter_bmfmap/map/zoomIn';

  /// map缩小一级比例尺
  static const kMapZoomOutMethod = 'flutter_bmfmap/map/zoomOut';

  /// 设置路况颜色
  static const kMapSetCustomTrafficColorMethod = 'flutter_bmfmap/map/setCustomTrafficColor';

  /// 更新地图状态
  static const kMapSetMapStatusMethod = 'flutter_bmfmap/map/setMapStatus';

  /// 获取地图状态
  static const kMapGetMapStatusMethod = 'flutter_bmfmap/map/getMapStatus';

  /// 按像素移动地图中心点
  static const kMapSetScrollByMethod = 'flutter_bmfmap/map/setScrollBy';

  /// 根据给定增量缩放地图级别
  static const kMapSetZoomByMethod = 'flutter_bmfmap/map/setZoomBy';

  /// 设置地图缩放级别
  static const kMapSetZoomToMethod = 'flutter_bmfmap/map/setZoomTo';

  /// 根据给定增量以及给定的屏幕坐标缩放地图级别
  static const kMapSetZoomPointByMethod = 'flutter_bmfmap/map/setZoomPointBy';

  /// 设定地图中心点坐标
  static const kMapSetCenterCoordinateMethod = 'flutter_bmfmap/map/setCenterCoordinate';

  /// 设置地图中心点以及缩放级别
  static const kMapSetCenterZoomMethod = 'flutter_bmfmap/map/setMapCenterZoom';

  /// 获得地图当前可视区域截图
  static const kMapTakeSnapshotMethod = 'flutter_bmfmap/map/takeSnapshot';

  /// 获得地图指定区域截图
  static const kMapTakeSnapshotWithRectMethod = 'flutter_bmfmap/map/takeSnapshotWithRect';

  /// 设置罗盘的图片
  static const kMapSetCompassImageMethod = 'flutter_bmfmap/map/setCompassImage';

  /// 设置显示在屏幕中的地图地理范围
  static const kMapSetVisibleMapBoundsMethod = 'flutter_bmfmap/map/setVisibleMapBounds';

  /// 设定地图的显示范围,并使mapRect四周保留insets指定的边界区域
  static const kMapSetVisibleMapBoundsWithPaddingMethod =
      'flutter_bmfmap/map/setVisibleMapBoundsWithPadding';
}

/// 地图获取属性方法id集合
class CYAMapGetPropertyMethodId {
  /// 获取map的展示类型
  static const kMapGetMapTypeMethod = 'flutter_bmfmap/map/getMapType';

  /// 获取map的比例尺级别
  static const kMapGetZoomLevelMethod = 'flutter_bmfmap/map/getZoomLevel';

  /// 获取map的自定义最小比例尺级别
  static const kMapGetMinZoomLevelMethod = 'flutter_bmfmap/map/getMinZoomLevel';

  /// 获取map的自定义最大比例尺级别
  static const kMapGetMaxZoomLevelMethod = 'flutter_bmfmap/map/getMaxZoomLevel';

  /// 获取map的旋转角度
  static const kMapGetRotationMethod = 'flutter_bmfmap/map/getRotation';

  /// 获取map的地图俯视角度
  static const kMapGetOverlookingMethod = 'flutter_bmfmap/map/getOverlooking';

  /// 获取map的俯视角度最小值
  static const kMapGetMinOverlookingMethod = 'flutter_bmfmap/map/getMinOverlooking';

  /// 获取map的是否现显示3D楼块效果
  static const kMapGetBuildingsEnabledMethod = 'flutter_bmfmap/map/getBuildingsEnabled';

  /// 获取map的是否显示底图poi标注
  static const kMapGetShowMapPoiMethod = 'flutter_bmfmap/map/getShowMapPoi';

  /// 获取map的是否打开路况图层
  static const kMapGetTrafficEnabledMethod = 'flutter_bmfmap/map/getTrafficEnabled';

  /// 获取map的是否打开百度城市热力图图层
  static const kMapGetBaiduHeatMapEnabledMethod = 'flutter_bmfmap/map/getBaiduHeatMapEnabled';

  /// 获取map的是否支持所有手势操作
  static const kMapGetGesturesEnabledMethod = 'flutter_bmfmap/map/getGesturesEnabled';

  /// 获取map的是否支持用户多点缩放(双指)
  static const kMapGetZoomEnabledMethod = 'flutter_bmfmap/map/getZoomEnabled';

  /// 获取map的是否支持用户缩放(双击或双指单击)
  static const kMapGetZoomEnabledWithTapMethod = 'flutter_bmfmap/map/getZoomEnabledWithTap';

  /// 获取map的是否支持用户移动地图
  static const kMapGetScrollEnabledMethod = 'flutter_bmfmap/map/getScrollEnabled';

  /// 获取map的是否支持俯仰角
  static const kMapGetOverlookEnabledMethod = 'flutter_bmfmap/map/getOverlookEnabled';

  /// 获取map的是否支持旋转
  static const kMapGetRotateEnabledMethod = 'flutter_bmfmap/map/getRotateEnabled';

  /// 获取map的是否支持3Dtouch
  static const kMapGetForceTouchEnabledMethod = 'flutter_bmfmap/map/getForceTouchEnabled';

  /// 获取map的是否显式比例尺
  static const kMapGetShowMapScaleBarMethod = 'flutter_bmfmap/map/getShowMapScaleBar';

  /// 获取map的比例尺的位置
  static const kMapGetMapScaleBarPositionMethod = 'flutter_bmfmap/map/getMapScaleBarPosition';

  /// 获取map的logo位置
  static const kMapGetLogoPositionMethod = 'flutter_bmfmap/map/getLogoPosition';

  /// 获取map的可视范围
  static const kMapGetVisibleMapBoundsMethod = 'flutter_bmfmap/map/getVisibleMapBounds';

  /// 获取map的显示室内图
  static const kMapGetBaseIndoorMapEnabledMethod = 'flutter_bmfmap/map/getBaseIndoorMapEnabled';

  /// 获取map的室内图标注是否显示
  static const kMapGetShowIndoorMapPoiMethod = 'flutter_bmfmap/map/getShowIndoorMapPoi';
}

/// 地图代理回调方法ID集合
class CYAMapCallbackMethodId {
  /// map加载完成
  static const kMapDidLoadCallback = 'flutter_bmfmap/map/mapViewDidFinishLoad';

  /// map渲染完成
  static const kMapDidFinishRenderCallback = 'flutter_bmfmap/map/mapViewDidFinishRender';

  /// 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
  static const kMapOnDrawMapFrameCallback = 'flutter_bmfmap/map/mapViewOnDrawMapFrame';

  /// 地图区域即将改变时会调用此接口
  static const kMapRegionWillChangeCallback = 'flutter_bmfmap/map/mapViewRegionWillChange';

  /// 地图区域即将改变时会调用此接口reason
  static const kMapRegionWillChangeWithReasonCallback =
      'flutter_bmfmap/map/mapViewRegionWillChangeWithReason';

  /// 地图区域改变完成后会调用此接口
  static const kMapRegionDidChangeCallback = 'flutter_bmfmap/map/mapViewRegionDidChange';

  /// 地图区域改变完成后会调用此接口reason
  static const kMapRegionDidChangeWithReasonCallback =
      'flutter_bmfmap/map/mapViewRegionDidChangeWithReason';

  /// 点中底图标注后会回调此接口
  static const kMapOnClickedMapPoiCallback = 'flutter_bmfmap/map/mapViewonClickedMapPoi';

  /// 单击地图底图调用此接口
  static const kCYDidSingleTappedAtCoordinateCallback =
      'flutter_cyamap/map/mapViewDidSingleTappedAtCoordinate';

  /// 双击地图时会回调此接口
  static const kMapOnDoubleClickCallback = 'flutter_bmfmap/map/mapViewOnDoubleClick';

  /// 长按地图时会回调此接口
  static const kMapOnLongClickCallback = 'flutter_bmfmap/map/mapViewOnLongClick';

  /// 3DTouch 按地图时会回调此接口
  ///（仅在支持3D Touch，且fouchTouchEnabled属性为true时，会回调此接口）
  static const kMapOnForceTouchCallback = 'flutter_bmfmap/map/mapViewOnForceTouch';

  /// 地图状态改变完成后会调用此接口
  static const kMapStatusDidChangedCallback = 'flutter_bmfmap/map/mapViewStatusDidChanged';

  /// 地图View进入/移出室内图
  static const kMapInOrOutBaseIndoorMapCallback = 'flutter_bmfmap/map/mapViewInOrOutBaseIndoorMap';

  /// 地图绘制出有效数据的监听
  static const kMapRenderValidDataCallback = 'flutter_bmfmap/map/mapRenderValidDataCallback';
}

/// 个性化地图方法ID集合
class CYCustomMapStyleMethodId {
  /// 开启个性化地图
  static const kSetCustomMapStyleEnableMethod = 'flutter_bmfmap/map/setCustomMapStyleEnable';

  /// 设置个性化地图样式路径
  static const kSetCustomMapStylePathMethod = 'flutter_bmfmap/map/setCustomMapStylePath';

  /// 在线个性化样式加载状态回调接口
  static const kSetCustomMapStyleWithOptionMethod =
      'flutter_bmfmap/map/setCustomMapStyleWithOption';
}

/// 室内地图方法ID集合
class BMFBaseIndoorMapMethodId {
  /// 展示室内地图
  static const kShowBaseIndoorMapMethod = 'flutter_bmfmap/map/showBaseIndoorMap';

  /// 室内图标注是否显示
  static const kShowBaseIndoorMapPoiMethod = 'flutter_bmfmap/map/showBaseIndoorMapPoi';

  /// 设置室内图楼层
  static const kSwitchBaseIndoorMapFloorMethod = 'flutter_bmfmap/map/switchBaseIndoorMapFloor';

  /// 获取当前聚焦的室内图信息
  static const kGetFocusedBaseIndoorMapInfo = 'flutter_bmfmap/map/getFocusedBaseIndoorMapInfo';
}

/// marker方法ID集合
class CYMarkerMethodId {
  /// 添加marker
  static const kMapAddMarkerMethod = 'flutter_bmfmap/marker/addMarker';

  /// 添加markers
  static const kMapAddMarkersMethod = 'flutter_bmfmap/marker/addMarkers';

  /// 删除marker
  static const kMapRemoveMarkerMethod = 'flutter_bmfmap/marker/removeMarker';

  /// 删除markers
  static const kMapRemoveMarkersMethod = 'flutter_bmfmap/marker/removeMarkers';

  /// 清除所有的markers
  static const kMapCleanAllMarkersMethod = 'flutter_bmfmap/marker/cleanAllMarkers';

  /// 更新marker属性
  static const kMapUpdateMarkerMember = 'flutter_bmfmap/marker/updateMarkerMember';
}

/// marker事件回调方法ID集合
class CYAMarkerCallbackMethodId {
  /// marker点击回调
  static const kMapClickedmarkedCallback = 'flutter_bmfmap/marker/clickedMarker';

  /// marker选中回调
  static const kMapDidSelectMarkerCallback = 'flutter_bmfmap/marker/didSelectedMarker';

  /// marker点击回调
  static const kMapDidDeselectMarkerCallback = 'flutter_bmfmap/marker/didDeselectMarker';

  /// marker拖拽回调
  static const kMapDragMarkerCallback = 'flutter_bmfmap/marker/dragMarker';
}

/// infoWindow方法ID集合
class CYInfoWindowMethodId {
  /// marker的infoWindow（iOS paopaoView）点击回调
  static const kMapDidClickedInfoWindowMethod = 'flutter_bmfmap/map/didClickedInfoWindow';

  /// 添加infoWindow
  static const kMapAddInfoWindowMethod = 'flutter_bmfmap/map/addInfoWindow';

  /// 批量添加infoWindow
  static const kMapAddInfoWindowsMethod = 'flutter_bmfmap/map/addInfoWindows';

  /// 删除infoWindow
  static const kMapRemoveInfoWindowMethod = 'flutter_bmfmap/map/removeInfoWindow';

  /// 清除所有的infowWindow
  static const kMapCleanAllInfoWindowsMethod = 'flutter_bmfmap/map/cleanAllInfoWindows';
}

/// overlay方法id集合
class CYOverlayMethodId {
  /// 添加polyline
  static const kMapAddPolylineMethod = 'flutter_bmfmap/overlay/addPolyline';

  /// 添加arcline
  static const kMapAddArclinelineMethod = 'flutter_bmfmap/overlay/addArcline';

  /// 添加polygon
  static const kMapAddPolygonMethod = 'flutter_bmfmap/overlay/addPolygon';

  /// 添加circle
  static const kMapAddCircleMethod = 'flutter_bmfmap/overlay/addCircle';

  /// 添加dot
  static const kMapAddDotMethod = 'flutter_bmfmap/overlay/addDot';

  /// 添加dot
  static const kMapAddTextMethod = 'flutter_bmfmap/overlay/addText';

  /// 添加ground
  static const kMapAddGroundMethod = 'flutter_bmfmap/overlay/addGround';

  /// 添加tile
  static const kMapAddTileMethod = 'flutter_bmfmap/overlay/addTile';

  /// 删除tile
  static const kMapRemoveTileMethod = 'flutter_bmfmap/overlay/removeTile';

  /// 删除overlay
  static const kMapRemoveOverlayMethod = 'flutter_bmfmap/overlay/removeOverlay';

  /// 更新overlay属性
  // static const kMapUpdateOverlayMemberMethod = 'flutter_bmfmap/overlay/updateOverlayMember';
  /// 更新polyline属性
  static const kMapUpdatePolylineMemberMethod = 'flutter_bmfmap/overlay/updatePolylineMember';
}

/// overlay回调方法id集合
class CYOverlayCallbackMethodId {
  /// 当mapView新添加overlay 时，调用此接口
  static const kMapDidAddOverlayCallback = 'flutter_bmfmap/overlay/didAddOverlay';

  /// 点中覆盖物后会回调此接口，目前只支持点中Polyline时回调
  static const kMapOnClickedOverlayCallback = 'flutter_bmfmap/overlay/onClickedOverlay';
}

/// 定位图层集合
class CYUserlocationMethodId {
  /// 设定是否显示定位图层
  static const kMapShowUserLocationMethod = 'flutter_bmfmap/userLocation/showUserLocation';

  /// 设定定位模式，取值为：BMFUserTrackingMode
  static const kMapUserTrackingModeMethod = 'flutter_bmfmap/userLocation/userTrackingMode';

  /// 返回定位坐标点是否在当前地图可视区域内
  static const kMapIsUserLocationVisibleMethod =
      'flutter_bmfmap/userLocation/isUserLocationVisible';

  /// 动态定制我的位置样式
  static const kMapUpdateLocationDisplayParamMethod =
      'flutter_bmfmap/userLocation/updateLocationDisplayParam';

  /// 动态更新我的位置数据
  static const kMapUpdateLocationDataMethod = 'flutter_bmfmap/userLocation/updateLocationData';
}

/// 离线地图方法id集合
class CYOfflineMethodId {
  /// 初使化
  static const kMapInitOfflineMethod = 'flutter_bmfmap/offlineMap/initOfflineMap';

  /// 状态回调
  static const kMapOfflineCallBackMethod = 'flutter_bmfmap/offlineMap/offlineCallBack';

  /// 启动下载指定城市ID的离线地图，或在暂停更新某城市后继续更新下载某城市离线地图
  static const kMapStartOfflineMethod = 'flutter_bmfmap/offlineMap/startOfflineMap';

  /// 启动更新指定城市ID的离线地图
  static const kMapUpdateOfflineMethod = 'flutter_bmfmap/offlineMap/updateOfflineMap';

  /// 暂停下载或更新指定城市ID的离线地图
  static const kMapPauseOfflineMethod = 'flutter_bmfmap/offlineMap/pauseOfflineMap';

  /// 删除指定城市ID的离线地图
  static const kMapRemoveOfflineMethod = 'flutter_bmfmap/offlineMap/removeOfflineMap';

  /// 销毁离线地图管理模块，不用时调用
  static const kMapDestroyOfflineMethod = 'flutter_bmfmap/offlineMap/destroyOfflineMap';

  /// 返回热门城市列表
  static const kMapGetHotCityListMethod = 'flutter_bmfmap/offlineMap/getHotCityList';

  /// 返回支持离线地图城市列表
  static const kMapGetOfflineCityListMethod = 'flutter_bmfmap/offlineMap/getOfflineCityList';

  /// 根据城市名搜索该城市离线地图记录
  static const kMapSearchCityMethod = 'flutter_bmfmap/offlineMap/searchCityList';

  /// 返回各城市离线地图更新信息
  static const kMapGetAllUpdateInfoMethod = 'flutter_bmfmap/offlineMap/getAllUpdateInfo';

  /// 返回指定城市ID离线地图更新信息
  static const kMapGetUpdateInfoMethod = 'flutter_bmfmap/offlineMap/getUpdateInfo';
}

/// 热力图地图方法ID集合
class CYHeapMapMethodId {
  /// 添加热力图
  static const kAddMapMethod = 'flutter_bmfmap/heatMap/addHeatMap';

  /// 删除热力图
  static const kRemoveHeatMapMethod = 'flutter_bmfmap/heatMap/removeHeatMap';

  /// 是否展示热力图
  static const kShowHeatMapMethod = 'flutter_bmfmap/heatMap/showHeatMap';
}

/// 数据转换方法Id集合
class CYProjectionMethodId {
  /// 屏幕坐标转地理坐标
  static const kCoordinateFromScreenPointMethod =
      'flutter_bmfmap/projection/screenPointfromCoordinate';

  /// 将地理坐标转换成屏幕坐标
  static const kScreenPointFromCoordinateMethod =
      'flutter_bmfmap/projection/coordinateFromScreenPoint';

//通过圆心，半径，获取圆周上的地理坐标（上下左右）
  static const kCYCoordinateFromDistanceHandleMethod =
      "flutter_bmfmap/projection/coordinateFromDistanceHandleMethod";

  /// 米为计量单位的距离（沿赤道）在当前缩放水平下转换到一个以像素（水平）为计量单位的距离
  static const kMetersToEquatorPixels = 'flutter_bmfmap/projection/metersToEquatorPixels';
}

/// MapWidget 状态更新方法Id集合
class CYAMapWidgetMethodId {
  /// widget 状态更新
  static const kMapDidUpdateWidget = 'flutter_bmfmap/map/didUpdateWidget';

  /// widget 热重载
  static const kMapReassemble = 'flutter_bmfmap/map/reassemble';
}
