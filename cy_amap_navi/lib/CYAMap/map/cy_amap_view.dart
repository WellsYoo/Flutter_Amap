library bmfmap_map.map.bmf_map_view;

import 'package:cy_2d_amap/CYAMap/models/cy_amap_options.dart';
import 'package:cy_2d_amap/CYAMap/private/mapdispatcher/cy_amap_dispatcher_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart';

import 'cy_amap_controller.dart';

/// 地图创建回调
typedef CYAMapCreatedCallback = void Function(CYAMapController controller);

/// 高德地图Widget
class CYAMapWidget extends StatefulWidget {
  const CYAMapWidget(
      {Key key,
      @required this.onCYAMapCreated,
      this.hitTestBehavior = PlatformViewHitTestBehavior.opaque,
      this.layoutDirection,
      this.mapOptions})
      : super(key: key);

  /// 创建mapView回调
  final CYAMapCreatedCallback onCYAMapCreated;

  /// 渗透点击事件，接收范围 opaque > translucent > transparent；
  final PlatformViewHitTestBehavior hitTestBehavior;

  /// 嵌入视图文本方向
  final TextDirection layoutDirection;

  /// map属性配置
  final CYAMapOptions mapOptions;
  @override
  _CYAMapWidgetState createState() => _CYAMapWidgetState();
}

class _CYAMapWidgetState extends State<CYAMapWidget> {
  final _gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>[
    Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
  ].toSet();

  int _widgetID;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // ios
      return UiKitView(
        viewType: CYNativeViewType.sMapView, //原生交互时唯一标识符
        onPlatformViewCreated: _onPlatformCreated, //创建视图后的回调
        gestureRecognizers: _gestureRecognizers, //透传手势，貌似不加也行
        hitTestBehavior: widget.hitTestBehavior, //渗透点击事件
        layoutDirection: widget.layoutDirection, //嵌入视图文本方向
        creationParams: widget.mapOptions.toMap() as dynamic, //向视图传递参数
        creationParamsCodec: new StandardMessageCodec(), //编解码器类型
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: CYNativeViewType.sMapView,
        onPlatformViewCreated: _onPlatformCreated,
        hitTestBehavior: widget.hitTestBehavior, //渗透点击事件
        layoutDirection: widget.layoutDirection, //嵌入视图文本方向
        creationParams: widget.mapOptions.toMap() as dynamic, //向视图传递参数
        creationParamsCodec: new StandardMessageCodec(), //编解码器类型
      );
    } else {
      return Text('flutter_bmfmap插件尚不支持$defaultTargetPlatform');
    }
  }

  void _onPlatformCreated(int id) {
    if (widget.onCYAMapCreated == null) {
      return;
    }

    _widgetID = id;
    CYAMapDispatcherFactory.instance.getMapWidgetStateDispatcher().initChannel(id);
    widget.onCYAMapCreated(CYAMapController.withId(id));
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print('implement dispose');
    CYAMapDispatcherFactory.instance.getMapWidgetStateDispatcher().unInit();
    super.dispose();
  }

  @override
  void didUpdateWidget(CYAMapWidget oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
    CYAMapDispatcherFactory.instance
        .getMapWidgetStateDispatcher()
        .sendMapWidgetDidUpdateMsg(_widgetID);
  }

  @override
  void reassemble() {
    print('reassemble');
    super.reassemble();
    CYAMapDispatcherFactory.instance
        .getMapWidgetStateDispatcher()
        .sendMapWidgetReassembleMsg(_widgetID);
  }
}
