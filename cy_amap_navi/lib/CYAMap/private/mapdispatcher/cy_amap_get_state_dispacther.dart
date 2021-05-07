import 'package:flutter/services.dart';
import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart';

import 'cy_amap_method_id.dart';

/// 获取地图状态
class CYAMapGetStateDispatcher {
  /// 获取map的展示类型
  Future<CYAMapType> getMapTypeDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    CYAMapType mapType;
    try {
      Map result = await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetMapTypeMethod);
      mapType = CYAMapType.values[result['mapType'] as int];
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return mapType;
  }

  /// 获取map的比例尺级别
  Future<int> getZoomLevelDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    int zoomLevel;
    try {
      Map result = await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetZoomLevelMethod);
      zoomLevel = result['zoomLevel'] as int;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return zoomLevel;
  }

  /// 获取map的自定义最小比例尺级别
  Future<int> getMinZoomLevelDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    int minZoomLevel;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetMinZoomLevelMethod);
      minZoomLevel = result['minZoomLevel'] as int;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return minZoomLevel;
  }

  /// 获取map的自定义最大比例尺级别
  Future<int> getMaxZoomLevelDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    int maxZoomLevel;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetMaxZoomLevelMethod);
      maxZoomLevel = result['maxZoomLevel'] as int;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return maxZoomLevel;
  }

  /// 获取map的旋转角度
  Future<double> getRotationDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    double rotation;
    try {
      Map result = await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetRotationMethod);
      rotation = result['rotation'] as double;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return rotation;
  }

  /// 获取map的地图俯视角度
  Future<double> getOverlookingDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    double overlooking;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetOverlookingMethod);
      overlooking = result['overlooking'] as double;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return overlooking;
  }

  /// 获取map的俯视角度最小值
  ///
  ///  ios 独有
  Future<int> getMinOverlookingDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    int minOverlooking;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetMinOverlookingMethod);
      minOverlooking = result['minOverlooking'] as int;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return minOverlooking;
  }

  /// 获取map的是否现显示3D楼块效果
  Future<bool> getBuildingsEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool buildingsEnabled;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetBuildingsEnabledMethod);
      buildingsEnabled = result['buildingsEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return buildingsEnabled;
  }

  /// 获取map的是否显示底图poi标注
  ///
  /// ios 独有
  Future<bool> getShowMapPoiDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool showMapPoi;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetShowMapPoiMethod);
      showMapPoi = result['showMapPoi'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return showMapPoi;
  }

  /// 获取map的是否打开路况图层
  Future<bool> getTrafficEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool trafficEnabled;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetTrafficEnabledMethod);
      trafficEnabled = result['trafficEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return trafficEnabled;
  }

  /// 获取map的是否打开百度城市热力图图层
  Future<bool> getBaiduHeatMapEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool baiduHeatMapEnabled;
    try {
      Map result = await _mapChannel
          .invokeMethod(CYAMapGetPropertyMethodId.kMapGetBaiduHeatMapEnabledMethod);
      baiduHeatMapEnabled = result['baiduHeatMapEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return baiduHeatMapEnabled;
  }

  /// 获取map的是否支持所有手势操作
  Future<bool> getGesturesEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool gesturesEnabled;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetGesturesEnabledMethod);
      gesturesEnabled = result['gesturesEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return gesturesEnabled;
  }

  /// 获取map的是否支持用户多点缩放(双指)
  ///
  /// android 中效果是否允许缩放手势包括（双击,双指单击,双指缩放）
  Future<bool> getZoomEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool zoomEnabled;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetZoomEnabledMethod);
      zoomEnabled = result['zoomEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return zoomEnabled;
  }

  /// 获取map的是否支持用户缩放(双击或双指单击)
  ///
  /// ios 独有
  Future<bool> getZoomEnabledWithTapDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool zoomEnabledWithTap;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetZoomEnabledWithTapMethod);
      zoomEnabledWithTap = result['zoomEnabledWithTap'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return zoomEnabledWithTap;
  }

  /// 获取map的是否支持用户移动地图
  Future<bool> getScrollEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool scrollEnabled;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetScrollEnabledMethod);
      scrollEnabled = result['scrollEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return scrollEnabled;
  }

  /// 获取map的是否支持俯仰角
  Future<bool> getOverlookEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool overlookEnabled;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetOverlookEnabledMethod);
      overlookEnabled = result['overlookEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return overlookEnabled;
  }

  /// 获取map的是否支持旋转
  Future<bool> getRotateEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool rotateEnabled;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetRotateEnabledMethod);
      rotateEnabled = result['rotateEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return rotateEnabled;
  }

  /// 获取map的是否支持3Dtouch
  ///
  /// ios 独有
  Future<bool> getForceTouchEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool forceTouchEnabled;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetForceTouchEnabledMethod);
      forceTouchEnabled = result['forceTouchEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return forceTouchEnabled;
  }

  /// 获取map的是否显式比例尺
  ///
  /// ios 独有
  Future<bool> getShowMapScaleBarDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool showMapScaleBar;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetShowMapScaleBarMethod);
      showMapScaleBar = result['showMapScaleBar'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return showMapScaleBar;
  }

  // /// 获取map的比例尺的位置
  // Future<CYAMapPCYAMapPointint> getMapScaleBarPositionDispatch(MethodChannel _mapChannel) async {
  //   if (_mapChannel == null) {
  //     return null;
  //   }
  //   CYAMapPoint mapScaleBarPosition;
  //   try {
  //     Map result = await _mapChannel
  //         .invokeMethod(CYAMapGetPropertyMethodId.kMapGetMapScaleBarPositionMethod);
  //     if (null == result) {
  //       return null;
  //     }
  //     mapScaleBarPosition =
  //         CYAMapPoint.point().fromMap(result['mapScaleBarPosition']) as CYAMapPoint;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return mapScaleBarPosition;
  // }

  // /// 获取map的logo位置
  // Future<CYAMapLogoPosition> getLogoPositionDispatch(MethodChannel _mapChannel) async {
  //   if (_mapChannel == null) {
  //     return null;
  //   }
  //   CYALogoPosition logoPosition;
  //   try {
  //     Map result =
  //         await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetLogoPositionMethod);
  //     if (null == result) {
  //       return null;
  //     }
  //     logoPosition = CYALogoPosition.values[result['logoPosition'] as int];
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return logoPosition;
  // }

  // /// 获取map的可视范围
  // Future<CYACoordinateBounds> getVisibleMapBoundsDispatch(MethodChannel _mapChannel) async {
  //   if (_mapChannel == null) {
  //     return null;
  //   }
  //   CYACoordinateBounds visibleMapBounds;
  //   try {
  //     Map result =
  //         await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetVisibleMapBoundsMethod);
  //     visibleMapBounds = CYACoordinateBounds.coordinateBounds().fromMap(result['visibleMapBounds'])
  //         as CYACoordinateBounds;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return visibleMapBounds;
  // }

  /// 获取map的显示室内图
  Future<bool> getBaseIndoorMapEnabledDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool baseIndoorMapEnabled;
    try {
      Map result = await _mapChannel
          .invokeMethod(CYAMapGetPropertyMethodId.kMapGetBaseIndoorMapEnabledMethod);
      baseIndoorMapEnabled = result['baseIndoorMapEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return baseIndoorMapEnabled;
  }

  /// 获取map的室内图标注是否显示
  ///
  /// ios 独有
  Future<bool> getShowIndoorMapPoiDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool showIndoorMapPoi;
    try {
      Map result =
          await _mapChannel.invokeMethod(CYAMapGetPropertyMethodId.kMapGetShowIndoorMapPoiMethod);
      showIndoorMapPoi = result['showIndoorMapPoi'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return showIndoorMapPoi;
  }
}
