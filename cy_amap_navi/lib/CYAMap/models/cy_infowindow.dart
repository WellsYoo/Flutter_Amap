library cyamap_map.models.cy_infowindow;

import 'package:flutter/cupertino.dart';
import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart' show CYModel, CYCoordinate;

/// infoWindow
class CYInfoWindow extends CYModel {
  /// infoWindow唯一id
  String _id;

  /// infowWindow图片名
  String image;

  /// infoWindow显示位置
  CYCoordinate coordinate;

  /// infoWindow y轴方向偏移
  double yOffset;

  /// 是否以bitmap形式添加
  bool isAddWithBitmap;

  /// BMFInfoWindow构造方法
  CYInfoWindow(
      {@required this.image, @required this.coordinate, this.yOffset, this.isAddWithBitmap}) {
    this._id = this.hashCode.toString();
  }

  CYInfoWindow.withMap(Map map) {
    if (null == map) {
      return;
    }

    this._id = map['id'];
    this.image = map['image'];
    this.coordinate = CYCoordinate.coordinate().fromMap(map['coordinate']);
    this.yOffset = map['yOffset'];
    this.isAddWithBitmap = map['isAddWithBitmapDescriptor'];
  }

  String getId() {
    return _id;
  }

  @override
  fromMap(Map map) {
    if (null == map) {
      return null;
    }

    return CYInfoWindow.withMap(map);
  }

  @override
  Map<String, Object> toMap() {
    return {
      "id": this.getId(),
      'image': this.image,
      'coordinate': this.coordinate.toMap(),
      'yOffset': this.yOffset,
      'isAddWithBitmapDescriptor': this.isAddWithBitmap
    };
  }
}
