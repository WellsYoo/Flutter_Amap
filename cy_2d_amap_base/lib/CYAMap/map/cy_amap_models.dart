library flutter_bmfbase.map.bmf_models;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 此文件定义flutter与native间的基础数据交互中间层model
//抽象类
abstract class CYModel {
  @required
  Map<String, Object> toMap();

  @required
  dynamic fromMap(Map map);
}

// 代表经纬度
class CYCoordinate implements CYModel {
  static CYCoordinate coordinate() => CYCoordinate(0, 0);

  // 纬度
  double latitude;

  // 经度
  double longitude;

  // BMFCoordinate构造方法
  CYCoordinate(this.latitude, this.longitude);

  @override
  Map<String, Object> toMap() {
    return {'latitude': this.latitude, 'longitude': this.longitude};
  }

  @override
  fromMap(Map map) {
    if (null == map) {
      return null;
    }
    return new CYCoordinate(map['latitude'], map['longitude']);
  }
}

// 屏幕坐标
class CYPoint implements CYModel {
  // 默认值 point =（0, 0）
  static CYPoint point() => CYPoint(0, 0);

  // 横坐标
  double x;

  // 纵坐标
  double y;

  // CYPoint
  CYPoint(this.x, this.y);

  // 屏幕坐标 -> map
  @override
  Map<String, Object> toMap() {
    return {'x': this.x, 'y': this.y};
  }

  // map ->屏幕坐标
  @override
  fromMap(Map map) {
    if (null == map) {
      return null;
    }

    return new CYPoint(map['x'], map['y']);
  }
}

// 矩形大小，用直角地理坐标表示
class CYAMapSize implements CYModel {
  // 默认值 size =（0，0）
  static CYAMapSize size() => CYAMapSize(0, 0);

  // 宽度
  double width;

  // 高度
  double height;

  // BMFSize构造方法
  CYAMapSize(this.width, this.height);

  // BMFSize -> map
  @override
  Map<String, Object> toMap() {
    return {'width': this.width, 'height': this.height};
  }

  // map -> BMFSize
  @override
  fromMap(Map map) {
    if (null == map) {
      return null;
    }

    return new CYAMapSize(map['width'], map['height']);
  }
}

// 矩形，用直角地理坐标表示
class CYAMapRect implements CYModel {
  // 默认值{origin =（0，0), size = (0, 0)}
  static CYAMapRect rect() => CYAMapRect(CYPoint(0, 0), CYAMapSize(0, 0));

  // 屏幕左上点对应的直角地理坐标
  CYPoint origin;

  // 坐标范围
  CYAMapSize size;

  // BMFMapRect构造方法
  CYAMapRect(this.origin, this.size);

  // map -> BMFMapRect
  @override
  fromMap(Map map) {
    if (null == map) {
      return null;
    }

    return new CYAMapRect(
        CYPoint.point().fromMap(map['origin']), CYAMapSize.size().fromMap(map['size']));
  }

  // BMFMapRect -> map
  @override
  Map<String, Object> toMap() {
    return {
      'origin': this.origin != null ? this.origin.toMap() : null,
      'size': this.size != null ? this.size.toMap() : null
    };
  }
}
