library bmfmap_map.models.overlays.bmf_circle;

import 'package:flutter/material.dart';

import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart' show CYCoordinate, ColorUtil;

import 'cy_overlay.dart';

/// 圆
class CYCircle extends CYOverlay {
  /// 圆心点经纬度
  CYCoordinate center;

  /// 圆的半径(单位米)
  double radius;

  /// 设置circleView的线宽度
  int width;

  /// 设置circleView的边框颜色
  Color strokeColor;

  /// 设置circleView的填充色
  Color fillColor;

  /// 设置circleView为虚线样式
// CYMLineDashType lineDashType;

  /// BMFCircle构造方法
  CYCircle(
      {@required this.center,
      @required this.radius,
      this.width: 5,
      this.strokeColor: Colors.blue,
      this.fillColor: Colors.red,
      // this.lineDashType: BMFLineDashType.LineDashTypeNone,
      int zIndex: 0,
      bool visible: true})
      : super(zIndex: zIndex, visible: visible);

  CYCircle.withMap(Map map) {
    if (null == map) {
      return;
    }

    super.fromMap(map);

    this.center = CYCoordinate.coordinate().fromMap(map['center']);
    this.radius = map['radius'];
    this.width = map['width'];
    this.strokeColor = ColorUtil.hexToColor(map['strokeColor']);
    this.fillColor = ColorUtil.hexToColor(map['fillColor']);

    int lineType = map['lineDashType'] as int;
    // if (null != lineType && lineType >= 0 && lineType < BMFLineDashType.values.length) {
    // this.lineDashType = BMFLineDashType.values[lineType];
    // }
  }

  @override
  fromMap(Map map) {
    if (null == map) {
      return;
    }

    return CYCircle.withMap(map);
  }

  @override
  Map<String, Object> toMap() {
    return {
      'id': this.getId(),
      'center': this.center?.toMap(),
      'radius': this.radius,
      'width': this.width,
      'strokeColor': this.strokeColor?.value?.toRadixString(16),
      'fillColor': this.fillColor?.value?.toRadixString(16),
      // 'lineDashType': this.lineDashType?.index,
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }
}
