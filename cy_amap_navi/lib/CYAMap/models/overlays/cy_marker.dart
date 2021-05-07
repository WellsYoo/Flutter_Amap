library cymap_map.models.overlays.cy_marker;

import 'package:cy_2d_amap/CYAMap/private/mapdispatcher/cy_amap_dispatcher_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart' show CYCoordinate, CYPoint;
import 'cy_overlay.dart';

/// 大头针
class CYMarker extends CYOverlay {
  static CYMarker marker() => CYMarker(position: CYCoordinate.coordinate(), icon: null);

  /// 标题
  String title;

  /// 子标题
  ///
  /// Android没有该属性
  String subtitle;

  /// marker位置经纬度
  CYCoordinate position;

  /// 标注固定在指定屏幕位置,  必须与screenPointToLock一起使用。
  ///
  /// 注意：拖动Annotation isLockedToScreen会被设置为false。
  /// 若isLockedToScreen为true，拖动地图时annotaion不会跟随移动；
  /// 若isLockedToScreen为false，拖动地图时annotation会跟随移动。
  bool isLockedToScreen;

  /// 标注锁定在屏幕上的位置，
  ///
  /// 注意：地图初始化后才能设置screenPointToLock。可以在地图加载完成的回调方法：mapViewDidFinishLoading中使用此属性。
  CYPoint screenPointToLock;

  /// markerView的复用标识符
  String identifier;

  /// markView显示的图片
  String icon;

  /// 默认情况下, annotation view的中心位于annotation的坐标位置，
  ///
  /// 可以设置centerOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
  ///
  /// 目前Android只支持Y轴设置偏移量对应SDK的 yOffset(int yOffset) 方法
  CYPoint centerOffset;

  /// 默认情况下,标注没有3D效果，可以设置enabled3D改变使用3D效果，
  ///
  /// 使得标注在地图旋转和俯视时跟随旋转、俯视
  ///
  /// iOS独有
  bool enabled3D;

  /// 默认为true,当为false时view忽略触摸事件
  bool enabled;

  /// 当设为true支持将view在地图上拖动
  bool draggable;

  /// x方向缩放倍数
  ///
  /// Android独有
  double scaleX;

  /// y方向缩放倍数
  ///
  /// Android独有
  double scaleY;

  /// 透明度
  ///
  /// Android独有
  double alpha;

  /// 在有俯仰角的情况下，是否近大远小
  ///
  /// Android独有
  bool isPerspective;

  CYMarker.withMap(Map map) {
    if (null == map) {
      return;
    }

    super.fromMap(map);

    this.position = CYCoordinate.coordinate().fromMap(map['position']);
    this.title = map['title'];
    this.subtitle = map["subtitle"];
    this.isLockedToScreen = map['isLockedToScreen'];
    this.screenPointToLock = CYPoint.point().fromMap(map['screenPointToLock']);
    this.identifier = map['identifier'];
    this.icon = map['icon'];
    this.centerOffset = map['centerOffset'];
    this.enabled3D = map['enabled3D'];
    this.enabled = map['enabled'];
    this.draggable = map['draggable'];
    this.scaleX = map['scaleX'];
    this.scaleY = map['scaleY'];
    this.alpha = map['alpha'];
    this.isPerspective = map['isPerspective'];
  }

  /// CYMarker构造方法
  CYMarker({
    @required this.position,
    @required this.icon,
    this.title,
    this.subtitle,
    this.isLockedToScreen: false,
    this.screenPointToLock,
    this.identifier,
    this.centerOffset,
    this.enabled3D,
    this.enabled: true,
    this.draggable: false,
    this.scaleX: 1.0,
    this.scaleY: 1.0,
    this.alpha: 1.0,
    this.isPerspective,
    int zIndex: 0,
    bool visible: true,
  }) : super(zIndex: zIndex, visible: visible);

  @override
  fromMap(Map map) {
    if (null == map) {
      return null;
    }

    return CYMarker.withMap(map);
  }

  @override
  Map<String, Object> toMap() {
    return {
      'id': this.getId(),
      'position': this.position?.toMap(),
      'title': this.title,
      'subtitle': this.subtitle,
      'isLockedToScreen': this.isLockedToScreen,
      'screenPointToLock': this.screenPointToLock?.toMap(),
      'identifier': this.identifier,
      'icon': this.icon,
      'centerOffset': this.centerOffset?.toMap(),
      'enabled3D': this.enabled3D,
      'enabled': this.enabled,
      'draggable': this.draggable,
      'scaleX': this.scaleX,
      'scaleY': this.scaleY,
      'alpha': this.alpha,
      'isPerspective': this.isPerspective,
      'zIndex': this.zIndex,
      'visible': this.visible,
    };
  }

  /// 更新title
  Future<bool> updateTitle(String title) async {
    if (null == title) {
      return false;
    }

    this.title = title;

    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'title',
      'value': title,
    });
  }

  /// 更新subTitle
  Future<bool> updateSubTitle(String subtitle) async {
    if (null == subtitle) {
      return false;
    }

    this.subtitle = subtitle;

    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'subtitle',
      'value': subtitle,
    });
  }

  /// 更新位置经纬度
  Future<bool> updatePosition(CYCoordinate position) async {
    if (null == position) {
      return false;
    }

    this.position = position;

    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'position',
      'value': position?.toMap(),
    });
  }

  /// 更新是否锁定在屏幕上的位置
  ///
  /// 如果isLockedToScreen为false,screenPointToLock需要传null
  Future<bool> updateIsLockedToScreen(bool isLockedToScreen, CYPoint screenPointToLock) async {
    this.isLockedToScreen = isLockedToScreen;
    this.screenPointToLock = screenPointToLock;

    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'isLockedToScreen',
      'value': isLockedToScreen,
      'screenPointToLock': screenPointToLock?.toMap()
    });
  }

  /// 更新显示的图片
  Future<bool> updateIcon(String icon) async {
    if (null == icon || icon.isEmpty) {
      return false;
    }

    this.icon = icon;

    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'icon',
      'value': icon,
    });
  }

  /// 更新marker centerOffset信息
  Future<bool> updateCenterOffset(CYPoint centerOffset) async {
    if (null == centerOffset) {
      return false;
    }

    this.centerOffset = centerOffset;

    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'centerOffset',
      'value': centerOffset?.toMap(),
    });
  }

  /// 更新marker是否显示3D效果
  Future<bool> updateEnabled3D(bool enabled3D) async {
    this.enabled3D = enabled3D;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'enabled3D',
      'value': enabled3D,
    });
  }

  /// 更新marker是否响应触摸事件, true则响应,false则不响应
  Future<bool> updateEnabled(bool enabled) async {
    this.enabled = enabled;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'enabled',
      'value': enabled,
    });
  }

  /// 更新是否可拖拽
  Future<bool> updateDraggable(bool draggable) async {
    this.draggable = draggable;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'draggable',
      'value': draggable,
    });
  }

  /// 更新x方向缩放倍数
  ///
  /// Android独有
  Future<bool> updateScaleX(double scaleX) async {
    this.scaleX = scaleX;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'scaleX',
      'value': scaleX,
    });
  }

  /// 更新y方向缩放倍数
  ///
  /// Android独有
  Future<bool> updateScaleY(double scaleY) async {
    this.scaleY = scaleY;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'scaleY',
      'value': scaleY,
    });
  }

  /// 更新透明度
  ///
  /// Android独有
  Future<bool> updateAlpha(double alpha) async {
    this.alpha = alpha;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'alpha',
      'value': alpha,
    });
  }

  /// 更新近大远小的开关
  ///
  /// Android独有
  Future<bool> updateIsPerspective(bool isPerspective) async {
    this.isPerspective = isPerspective;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'isPerspective',
      'value': isPerspective,
    });
  }

  /// 更新marker是否显示
  ///
  /// Android独有
  Future<bool> updateVisible(bool visible) async {
    this.visible = visible;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'visible',
      'value': visible,
    });
  }

  /// 更新z轴方向上的堆叠顺序
  ///
  /// Android独有
  Future<bool> updateZIndex(int zIndex) async {
    this.zIndex = zIndex;
    return await CYAMapDispatcherFactory.instance
        .getMarkerDispatcher()
        .updateMarkerMember(this.getMethodChannel(), {
      'id': this.getId(),
      'member': 'zIndex',
      'value': zIndex,
    });
  }
}
