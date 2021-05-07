library cymap_map.models.overlays.cy_overlay;

import 'package:flutter/services.dart';
import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart' show CYModel;

/// 地图覆盖物基类
class CYOverlay extends CYModel {
  /// overlay id
  String _id;

  /// overlay是否可见
  ///
  /// Android独有
  bool visible;

  /// 元素的堆叠顺序
  ///
  /// Android独有
  int zIndex;

  MethodChannel _methodChannel;

  CYOverlay({this.visible, this.zIndex}) {
    this._id = this.hashCode.toString();
  }

  CYOverlay.withMap(Map map) {
    if (null == map) {
      return;
    }

    this._id = map['id'];
    this.visible = map['visible'];
    this.zIndex = map['zIndex'];
  }

  String getId() {
    return _id;
  }

  void setMethodChannel(MethodChannel methodChannel) {
    this._methodChannel = methodChannel;
  }

  MethodChannel getMethodChannel() {
    return this._methodChannel;
  }

  @override
  fromMap(Map map) {
    if (null == map) {
      return null;
    }

    return CYOverlay.withMap(map);
  }

  @override
  Map<String, Object> toMap() {
    return {'id': this.getId(), 'visible': visible, 'zIndex': zIndex};
  }
}
