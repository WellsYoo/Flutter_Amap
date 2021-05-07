import 'dart:typed_data';
import 'package:cy_2d_amap/CYAMap/models/cy_amap_options.dart';
import 'package:cy_2d_amap/CYAMap/models/cy_mapstatus.dart';
import 'package:cy_2d_amap_base/CYAMap/map/cy_amap_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cy_amap_method_id.dart';

class CYAMapStateDispatcher {
  static const _tag = 'CYAMapStateDispatcher';

  /// 更新地图属性
  Future<bool> updateMapOptionsDispatch(MethodChannel _mapChannel, CYAMapOptions change) async {
    if (change == null || _mapChannel == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYAMapStateMethodId.kMapUpdateMethod, change.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// map放大一级比例尺
  Future<bool> zoomInDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYAMapStateMethodId.kMapZoomInMethod)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// map缩小一级比例尺
  Future<bool> zoomOutDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYAMapStateMethodId.kMapZoomOutMethod)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 自定义路况颜色。
  ///
  /// 注意：如果需要自定义路况颜色，必须4种路况全都设置。4个参数全部合法时，自定义颜色才有效；否则全部使用默认的。
  /// smooth 路况畅通对应的颜色
  /// slow 路况缓行对应的颜色
  /// congestion 路况拥堵对应的颜色
  /// severeCongestion 路况严重拥堵对应的颜色
  Future<bool> setCustomTrafficColorDispatch(MethodChannel _mapChannel, Color smooth, Color slow,
      Color congestion, Color severeCongestion) async {
    if (_mapChannel == null ||
        smooth == null ||
        slow == null ||
        congestion == null ||
        severeCongestion == null) {
      return false;
    }
    bool result = false;
    try {
      Map<String, String> colorMap = {
        'smooth': smooth.value?.toRadixString(16),
        'slow': slow.value?.toRadixString(16),
        'congestion': congestion.value?.toRadixString(16),
        'severeCongestion': severeCongestion.value?.toRadixString(16)
      };
      result = (await _mapChannel.invokeMethod(
          CYAMapStateMethodId.kMapSetCustomTrafficColorMethod, colorMap as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新地图新状态
  ///
  /// mapStatus 地图新状态
  /// animateDurationMs 动画更新时间
  ///
  /// （注意：animateDurationMs该字段仅对android生效，若animateDurationMs !=0 ，iOS则启动默认动画设置mapStatus，反之不开启动画设置mapStatus）
  Future<bool> setNewMapStatusDispatch(MethodChannel _mapChannel,
      {@required CYAMapStatus mapStatus, int animateDurationMs}) async {
    if (_mapChannel == null || mapStatus == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYAMapStateMethodId.kMapSetMapStatusMethod,
              {'mapStatus': mapStatus.toMap(), 'animateDurationMs': animateDurationMs} as dynamic))
          as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 获取地图新状态
  Future<CYAMapStatus> getMapStatusDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    dynamic result;
    try {
      result = await _mapChannel.invokeMethod(CYAMapStateMethodId.kMapGetMapStatusMethod);
    } on PlatformException catch (e) {
      print(e.toString());
    }

    CYAMapStatus mapStatus;
    if (null != result) {
      mapStatus = CYAMapStatus.mapStatus().fromMap(result['mapStatus']);
    }
    return mapStatus;
  }

  /// 按像素移动地图中心点
  ///
  /// xPixel 水平方向移动像素数
  /// yPixel 垂直方向移动像素数
  /// animateDurationMs 动画更新时间
  Future<bool> setScrollByDispatch(MethodChannel _mapChannel, int xPixel, int yPixel,
      {int animateDurationMs}) async {
    if (_mapChannel == null || xPixel == null || yPixel == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYAMapStateMethodId.kMapSetScrollByMethod,
          {'xPixel': xPixel, 'yPixel': yPixel, 'animateDurationMs': animateDurationMs}
              as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 根据定增量缩放给地图级别
  ///
  /// amount 地图缩放级别增量
  /// animateDurationMs 动画更新时间
  Future<bool> setZoomByDispatch(MethodChannel _mapChannel, double amount,
      {int animateDurationMs}) async {
    if (_mapChannel == null || amount == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYAMapStateMethodId.kMapSetZoomByMethod,
          {'amount': amount, 'animateDurationMs': animateDurationMs} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 设置地图缩放级别
  ///
  /// zoom 设置地图缩放级别
  /// animateDurationMs 动画更新时间
  Future<bool> setZoomToDispatch(MethodChannel _mapChannel, double zoom,
      {int animateDurationMs}) async {
    if (_mapChannel == null || zoom == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(CYAMapStateMethodId.kMapSetZoomToMethod,
          {'zoom': zoom, 'animateDurationMs': animateDurationMs} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 根据给定增量以及给定的屏幕坐标缩放地图级别
  ///
  /// amount 地图缩放级别增量
  /// focus  地图缩放中心点屏幕坐标, 若为 null 则返回 null
  /// animateDurationMs 动画更新时间
  Future<bool> setZoomPointByDispatch(MethodChannel _mapChannel, double amount, CYPoint focus,
      {int animateDurationMs}) async {
    if (_mapChannel == null || amount == null || focus == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYAMapStateMethodId.kMapSetZoomByMethod,
          {'amount': amount, 'focus': focus.toMap(), 'animateDurationMs': animateDurationMs}
              as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 设定地图中心点坐标
  ///
  /// coordinate 要设定的地图中心点坐标，用经纬度表示
  /// animated 是否采用动画效果
  /// animateDurationMs 动画更新时间[android]支持
  Future<bool> setCenterCoordinateDispatch(
      MethodChannel _mapChannel, CYCoordinate coordinate, bool animated,
      {int animateDurationMs}) async {
    if (_mapChannel == null || coordinate == null || animated == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYAMapStateMethodId.kMapSetCenterCoordinateMethod,
          {
            'coordinate': coordinate.toMap(),
            'animated': animated,
            'animateDurationMs': animateDurationMs
          } as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// [Android]设置地图中心点以及缩放级别
  ///
  /// coordinate 要设定的地图中心点坐标，用经纬度表示
  /// zoom 缩放级别
  /// animateDurationMs 动画时间
  Future<bool> setNewLatLngZoomDispatcher(MethodChannel _mapChannel,
      {@required CYCoordinate coordinate, @required double zoom, int animateDurationMs}) async {
    if (_mapChannel == null || coordinate == null || zoom == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYAMapStateMethodId.kMapSetCenterZoomMethod,
          {'coordinate': coordinate.toMap(), 'zoom': zoom, 'animateDurationMs': animateDurationMs}
              as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 获得地图当前可视区域截图
  ///
  /// 范围内的截取的Images
  Future<Uint8List> takeSnapshotDispatch(MethodChannel _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    List<dynamic> result;
    try {
      result = (await _mapChannel.invokeMethod(CYAMapStateMethodId.kMapTakeSnapshotMethod))
          as List<dynamic>;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return Uint8List.fromList(result?.map((i) => i as int)?.toList());
  }

  /// 获得地图指定区域截图
  ///
  /// 指定区域的截取的Image
  Future<Uint8List> takeSnapshotWithRectDispatch(MethodChannel _mapChannel, CYAMapRect rect) async {
    if (_mapChannel == null || rect == null) {
      return null;
    }
    List<dynamic> result;
    try {
      result = (await _mapChannel.invokeMethod(
              CYAMapStateMethodId.kMapTakeSnapshotWithRectMethod, {'rect': rect.toMap()}))
          as List<dynamic>;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return Uint8List.fromList(result?.map((i) => i as int)?.toList());
  }

  /// 设置罗盘的图片
  Future<bool> setCompassImageDispatch(MethodChannel _mapChannel, String imagePath) async {
    if (_mapChannel == null || imagePath == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
              CYAMapStateMethodId.kMapSetCompassImageMethod, {'imagePath': imagePath} as dynamic))
          as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 设置显示在屏幕中的地图地理范围
  ///
  /// coordinateBounds 要设定的地图范围(东北，西南)角坐标
  /// animated 是否采用动画效果
  // Future<bool> setVisibleMapBoundsDispatch(MethodChannel _mapChannel,
  //     CYACoordinateBounds visibleMapBounds, bool animated) async {
  //   if (_mapChannel == null || visibleMapBounds == null || animated == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYAMapStateMethodId.kMapSetVisibleMapBoundsMethod,
  //         {'visibleMapBounds': visibleMapBounds.toMap(), 'animated': animated}
  //             as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  /// 设置显示在指定相对于MapView的padding中的地图地理范围
  ///
  /// visibleMapBounds 要设定的地图范围(东北，西南)角坐标
  /// insets 指定的四周边界大小
  /// animated 是否采用动画效果
  // Future<bool> setVisibleMapRectWithPaddingDispatch(
  //     MethodChannel _mapChannel,
  //     CYACoordinateBounds visibleMapBounds,
  //     EdgeInsets insets,
  //     bool animated) async {
  //   if (_mapChannel == null ||
  //       visibleMapBounds == null ||
  //       insets == null ||
  //       animated == null) {
  //     return false;
  //   }

  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYAMapStateMethodId.kMapSetVisibleMapBoundsWithPaddingMethod,
  //         {
  //           'visibleMapBounds': visibleMapBounds.toMap(),
  //           'insets':
  //               CYAEdgeInsets.edgeInsets().fromEdgeInsets(insets)?.toMap(),
  //           'animated': animated
  //         } as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  // /// 添加热力图
  // Future<bool> addHeatMapDispatch(
  //     MethodChannel _mapChannel, CYAHeatMap heapMap) async {
  //   if (heapMap == null || _mapChannel == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(CYAHeapMapMethodId.kAddMapMethod,
  //         {'heatMap': heapMap?.toMap()} as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     CYALog.e(e.toString(), tag: _tag);
  //   }
  //   return result;
  // }

  /// 删除热力图
  // Future<bool> removeHeatMapDispatch(MethodChannel _mapChannel) async {
  //   if (_mapChannel == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel
  //         .invokeMethod(CYAHeapMapMethodId.kRemoveHeatMapMethod) as bool);
  //   } on PlatformException catch (e) {
  //     CYALog.e(e.toString(), tag: _tag);
  //   }
  //   return result;
  // }

  /// 是否展示热力图
  // Future<bool> showHeatMapDispatch(MethodChannel _mapChannel, bool show) async {
  //   if (show == null || _mapChannel == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //             CYAHeapMapMethodId.kShowHeatMapMethod, {'show': show} as dynamic))
  //         as bool;
  //   } on PlatformException catch (e) {
  //     CYALog.e(e.toString(), tag: _tag);
  //   }
  //   return result;
  // }

  /// 是否展示室内地图
  // Future<bool> showBaseIndoorMapDispatch(
  //     MethodChannel _mapChannel, bool show) async {
  //   if (show == null || _mapChannel == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYABaseIndoorMapMethodId.kShowBaseIndoorMapMethod,
  //         {'show': show} as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  /// 室内图标注是否显示
  // Future<bool> showBaseIndoorMapPoiDispatch(
  //     MethodChannel _mapChannel, bool showPoi) async {
  //   if (showPoi == null || _mapChannel == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYABaseIndoorMapMethodId.kShowBaseIndoorMapPoiMethod,
  //         {'showIndoorPoi': showPoi} as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  /// 设置室内图楼层
  ///
  /// floorId 楼层id
  /// indoorId 室内图ID
  // Future<CYASwitchIndoorFloorError> switchBaseIndoorMapFloorDispatch(
  //     MethodChannel _mapChannel, String floorId, String indoorId) async {
  //   if (floorId == null || indoorId == null || _mapChannel == null) {
  //     return CYASwitchIndoorFloorError.Failed;
  //   }
  //   CYASwitchIndoorFloorError result;
  //   try {
  //     Map map = (await _mapChannel.invokeMethod(
  //         CYABaseIndoorMapMethodId.kSwitchBaseIndoorMapFloorMethod,
  //         {'floorId': floorId, 'indoorId': indoorId} as dynamic)) as Map;
  //     result = CYASwitchIndoorFloorError.values[map['result'] as int];
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  /// 获取当前聚焦的室内图信息
  ///
  /// 当前聚焦的室内图信息。没有聚焦的室内图，返回nil
  // Future<CYABaseIndoorMapInfo> getFocusedBaseIndoorMapInfoDispatch(
  //     MethodChannel _mapChannel) async {
  //   if (_mapChannel == null) {
  //     return null;
  //   }
  //   CYABaseIndoorMapInfo result;
  //   try {
  //     Map map = (await _mapChannel.invokeMethod(
  //         CYABaseIndoorMapMethodId.kGetFocusedBaseIndoorMapInfo)) as Map;
  //     result = CYABaseIndoorMapInfo.baseIndoorMapInfo().fromMap(map);
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }

  //   return result;
  // }

  /// 个性化地图样式开关，仅影响当前mapView对象，需���对象创建后调用
  ///
  /// enable 当前自定义地图样式是否生效
  Future<bool> setCustomMapStyleEnableDispatch(MethodChannel _mapChannel, bool enable) async {
    if (_mapChannel == null) {
      return false;
    }
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          CYCustomMapStyleMethodId.kSetCustomMapStyleEnableMethod,
          {'enable': enable} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 设置个性化地图样式路径，仅影响当前mapView对象，需在���象创建后调用
  /// customMapStyleJsonFilePath 本地个性化样式文件所在路径，包含文件名
  /// mode 加载模式，0:加载本地文件 1:加载在线文件或在线缓存文件
  // Future<bool> setCustomMapStylePathDispatch(
  //     MethodChannel _mapChannel, String path, int mode) async {
  //   if (_mapChannel == null) {
  //     return false;
  //   }
  //   bool result = false;
  //   try {
  //     result = (await _mapChannel.invokeMethod(
  //         CYACustomMapStyleMethodId.kSetCustomMapStylePathMethod,
  //         {'path': path, 'mode': mode} as dynamic)) as bool;
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  ///  在线个性化样式加载接口。
  /// option 在线个性化样式配置选项
//   Future<bool> setCustomMapStyleWithOptionDispatch(
//       MethodChannel _mapChannel,
//       CYACustomMapStyleOption customMapStyleOption,
//       void Function(String path) preload,
//       void Function(String path) success,
//       void Function(int errorCode, String path) error) async {
//     if (_mapChannel == null || customMapStyleOption == null) {
//       return false;
//     }
//     bool result;
//     try {
//       Map map = (await _mapChannel.invokeMethod(
//           CYACustomMapStyleMethodId.kSetCustomMapStyleWithOptionMethod,
//           {'customMapStyleOption': customMapStyleOption.toMap()}
//               as dynamic)) as Map;
//       result = map != null;
//       if (preload != null && map['preloadPath'] != null) {
//         preload(map['preloadPath']);
//       }
//       if (success != null && map['successPath'] != null) {
//         success(map['successPath']);
//       }
//       if (error != null) {
//         error(map['errorCode'] as int, map['errorPath']);
//       }
//     } on PlatformException catch (e) {
//       print(e.toString());
//     }
//     return result;
//   }
}
