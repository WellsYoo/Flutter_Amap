library bmfmap_map.models.bmf_userlocation;

import 'package:cy_2d_amap_base/CYAMap/map/cy_amap_models.dart';
import 'package:cy_2d_amap_base/CYAMap/map/cy_amap_types.dart';
import 'package:cy_2d_amap_base/CYAMap/utils/cy_color.dart';
import 'package:flutter/material.dart';

/// 当前位置对象
class CYUserLocation implements CYModel {
  /// 位置更新状态，如果正在更新位置信息，则该值为YES
  ///
  /// Anroid没有该属性
  bool updating;

  /// 位置信息，尚未定位成功，则该值为null
  CYLocation location;

  /// heading信息，尚未定位成功，则该值为null
  ///
  /// Anroid没有该属性
  CYHeading heading;

  /// 定位标注点要显示的标题信息
  ///
  /// Anroid没有该属性
  String title;

  /// 定位标注点要显示的子标题信息
  ///
  /// Anroid没有该属性
  String subtitle;

  /// BMFUserLocation构造方法
  CYUserLocation({this.updating, @required this.location, this.heading, this.title, this.subtitle});

  @override
  fromMap(Map map) {
    return new CYUserLocation(
        updating: map['updating'],
        location: CYLocation.location().fromMap(map['location']),
        heading: CYHeading.heading().fromMap(map['heading']),
        title: map['title'],
        subtitle: map['subtitle']);
  }

  @override
  Map<String, Object> toMap() {
    return {
      'updating': this.updating,
      'location': this.location?.toMap(),
      'heading': this.heading?.toMap(),
      'title': this.title,
      'subtitle': this.subtitle
    };
  }
}

/// 定位信息
class CYLocation implements CYModel {
  static CYLocation location() => CYLocation(coordinate: null);

  /// 经纬度
  CYCoordinate coordinate;

  /// 海拔
  ///
  /// Android 没有该属性
  double altitude;

  /// 水平精确度
  ///
  /// Android没有该属性
  double horizontalAccuracy;

  /// 垂直精确度
  ///
  /// Android没有该属性
  double verticalAccuracy;

  /// 航向
  double course;

  /// 速度
  double speed;

  /// 定位精度
  ///
  /// IOS没有该属性
  double accuracy;

  /// GPS定位时卫星数目
  ///
  /// IOS没有该属性
  int satellitesNum;

  /// 时间 YYYY-MM-dd HH:mm:ss
  ///
  /// Android没有该属性
  String timestamp;

  CYLocation(
      {@required this.coordinate,
      this.altitude,
      this.horizontalAccuracy,
      this.verticalAccuracy,
      this.course,
      this.speed,
      this.accuracy,
      this.satellitesNum,
      this.timestamp});
  @override
  fromMap(Map map) {
    return new CYLocation(
        coordinate: CYCoordinate.coordinate().fromMap(map['coordinate']),
        altitude: map['altitude'],
        horizontalAccuracy: map['horizontalAccuracy'],
        verticalAccuracy: map['verticalAccuracy'],
        course: map['course'],
        speed: map['speed'],
        accuracy: map['accuracy'],
        satellitesNum: map['satellitesNum'],
        timestamp: map['timestamp']);
  }

  @override
  Map<String, Object> toMap() {
    return {
      'coordinate': this.coordinate?.toMap(),
      'altitude': this.altitude,
      'horizontalAccuracy': this.horizontalAccuracy,
      'verticalAccuracy': this.verticalAccuracy,
      'course': this.course,
      'speed': this.speed,
      'accuracy': this.accuracy,
      'satellitesNum': this.satellitesNum,
      'timestamp': this.timestamp
    };
  }
}

/// heading信息
class CYHeading implements CYModel {
  static CYHeading heading() => CYHeading();

  /// 磁头
  ///
  /// 表示度方向，其中0度为磁北。无论设备的方向以及用户界面的方向如何，方向都是从设备的顶部引用的。
  ///
  /// 范围: 0.0 - 359.9度，0度为地磁北极
  double magneticHeading;

  /// 表示角度方向，其中0度为真北。参考方向
  ///
  /// 不考虑设备的方向以及设备的方向
  ///
  /// 范围: 0.0 - 359.9度，0为正北
  double trueHeading;

  /// 航向精度
  ///
  /// 表示磁头可能与实际地磁头偏差的最大度数。负值表示无效的标题。
  double headingAccuracy;

  /// x轴测量的地磁的原始值
  double x;

  /// y轴测量的地磁的原始值
  double y;

  /// z轴测量的地磁的原始值
  double z;

  /// 时间戳
  String timestamp;

  CYHeading(
      {this.magneticHeading,
      this.trueHeading,
      this.headingAccuracy,
      this.x,
      this.y,
      this.z,
      this.timestamp});

  @override
  fromMap(Map map) {
    return new CYHeading(
        magneticHeading: map['magneticHeading'],
        trueHeading: map['trueHeading'],
        headingAccuracy: map['headingAccuracy'],
        x: map['x'],
        y: map['y'],
        z: map['z'],
        timestamp: map['timestamp']);
  }

  @override
  Map<String, Object> toMap() {
    return {
      'magneticHeading': this.magneticHeading,
      'trueHeading': this.trueHeading,
      'headingAccuracy': this.headingAccuracy,
      'x': this.x,
      'y': this.y,
      'z': this.z,
      'timestamp': this.timestamp
    };
  }
}

/// userlocationView在mapview上显示的层级
enum BMFLocationViewHierarchy {
  ///<locationView在最上层
  LOCATION_VIEW_HIERARCHY_TOP,

  ///<locationView在最下层
  LOCATION_VIEW_HIERARCHY_BOTTOM,
}

class BMFUserlocationDisplayParam implements CYModel {
  static BMFUserlocationDisplayParam userlocationOptions() => BMFUserlocationDisplayParam(
      locationViewOffsetX: 0,
      locationViewOffsetY: 0,
      userTrackingMode: CYUserTrackingMode.CYUserTrackingModeNone,
      enableDirection: false,
      accuracyCircleFillColor: Colors.blue,
      accuracyCircleStrokeColor: Colors.blue,
      locationViewImage: null,
      locationViewHierarchy: BMFLocationViewHierarchy.LOCATION_VIEW_HIERARCHY_TOP);

  /// 定位图标X轴偏移量(屏幕坐标)
  ///
  /// Android没有该属性
  double locationViewOffsetX;

  /// 定位图标Y轴偏移量(屏幕坐标)
  ///
  /// Android没有该属性
  double locationViewOffsetY;

  /// 定位模式
  ///
  /// IOS没有该属性
  CYUserTrackingMode userTrackingMode;

  /// 是否允许显示方向信息
  ///
  /// IOS没有该属性
  bool enableDirection;

  /// 精度圈是否显示，默认YES
  ///
  /// Android没有该属性
  bool isAccuracyCircleShow;

  /// 精度圈 填充颜色
  Color accuracyCircleFillColor;

  /// 精度圈 边框颜色
  Color accuracyCircleStrokeColor;

  /// 跟随态旋转角度是否生效，默认YES
  ///
  /// Android没有该属性
  bool isRotateAngleValid;

  /// 用户自定义定位图标
  String locationViewImage;

  /// 是否显示气泡，默认YES
  ///
  /// Android没有该属性
  bool canShowCallOut;

  /// locationView在mapview上的层级 默认值为LOCATION_VIEW_HIERARCHY_BOTTOM
  BMFLocationViewHierarchy locationViewHierarchy;

  BMFUserlocationDisplayParam(
      {this.locationViewOffsetX,
      this.locationViewOffsetY,
      this.userTrackingMode: CYUserTrackingMode.CYUserTrackingModeNone,
      this.enableDirection: true,
      this.isAccuracyCircleShow: true,
      this.accuracyCircleFillColor,
      this.accuracyCircleStrokeColor,
      this.isRotateAngleValid: true,
      this.locationViewImage,
      this.canShowCallOut: true,
      this.locationViewHierarchy});

  @override
  fromMap(Map map) {
    int userTrackingModeIndex = map['userTrackingMode'] as int;
    CYUserTrackingMode tmpUserTrackingMode;
    if (null != userTrackingModeIndex &&
        userTrackingModeIndex >= 0 &&
        userTrackingModeIndex < CYUserTrackingMode.values.length) {
      tmpUserTrackingMode = CYUserTrackingMode.values[userTrackingModeIndex];
    }

    int locationViewHierarchyIndex = map['locationViewHierarchy'] as int;
    BMFLocationViewHierarchy tmpLocationViewHierarchy;
    if (null != locationViewHierarchyIndex &&
        locationViewHierarchyIndex >= 0 &&
        locationViewHierarchyIndex < BMFLocationViewHierarchy.values.length) {
      tmpLocationViewHierarchy = BMFLocationViewHierarchy.values[locationViewHierarchyIndex];
    }

    return new BMFUserlocationDisplayParam(
        locationViewOffsetX: map['locationViewOffsetX'],
        locationViewOffsetY: map['locationViewOffsetY'],
        userTrackingMode: tmpUserTrackingMode,
        enableDirection: map['enableDirection'] as bool,
        isAccuracyCircleShow: map['isAccuracyCircleShow'] as bool,
        accuracyCircleFillColor: ColorUtil.hexToColor(map['accuracyCircleFillColor']),
        accuracyCircleStrokeColor: ColorUtil.hexToColor(map['accuracyCircleStrokeColor']),
        isRotateAngleValid: map['isRotateAngleValid'] as bool,
        locationViewImage: map['locationViewImage'],
        canShowCallOut: map['canShowCallOut'] as bool,
        locationViewHierarchy: tmpLocationViewHierarchy);
  }

  @override
  Map<String, Object> toMap() {
    return {
      'locationViewOffsetX': this.locationViewOffsetX,
      'locationViewOffsetY': this.locationViewOffsetY,
      'userTrackingMode': this.userTrackingMode.index,
      'enableDirection': this.enableDirection,
      'isAccuracyCircleShow': this.isAccuracyCircleShow,
      'accuracyCircleFillColor': this.accuracyCircleFillColor?.value?.toRadixString(16),
      'accuracyCircleStrokeColor': this.accuracyCircleStrokeColor?.value?.toRadixString(16),
      'isRotateAngleValid': this.isRotateAngleValid,
      'locationViewImage': this.locationViewImage,
      'canShowCallOut': this.canShowCallOut,
      'locationViewHierarchy': this.locationViewHierarchy.index
    };
  }
}
