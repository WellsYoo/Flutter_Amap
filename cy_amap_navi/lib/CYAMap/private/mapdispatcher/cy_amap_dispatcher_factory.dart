import 'cy_map_state_dispacther.dart';
import 'cy_amap_get_state_dispacther.dart';
import 'cy_amap_widget_state_dispather.dart';
import 'cy_marker_dispatcher.dart';
import 'cy_overlay_dispatcher.dart';
import 'cy_userlocation_dispatcher.dart';

class CYAMapDispatcherFactory {
  // 工厂模式
  factory CYAMapDispatcherFactory() => _getInstance();
  static CYAMapDispatcherFactory get instance => _getInstance();
  static CYAMapDispatcherFactory _instance;

  CYAMapStateDispatcher _mapStateDispatcher;
  CYAMapGetStateDispatcher _mapGetStateDispatcher;
  CYUserLocationDispatcher _userLocationDispatcher;
  CYMarkerDispatcher _markerDispatcher;
  CYOverlayDispatcher _overlayDispatcher;
  // BMFOfflineMapDispatcher _offlineMapDispatcher;
  CYAMapWidgetStateDispatcher _mapWidgetStateDispatcher;

  CYAMapDispatcherFactory._internal() {
    _mapStateDispatcher = new CYAMapStateDispatcher();
    _mapGetStateDispatcher = CYAMapGetStateDispatcher();
    _userLocationDispatcher = new CYUserLocationDispatcher();
    _markerDispatcher = new CYMarkerDispatcher();
    _overlayDispatcher = new CYOverlayDispatcher();
    // _offlineMapDispatcher = new BMFOfflineMapDispatcher();
    _mapWidgetStateDispatcher = CYAMapWidgetStateDispatcher();
  }
  static CYAMapDispatcherFactory _getInstance() {
    if (_instance == null) {
      _instance = new CYAMapDispatcherFactory._internal();
    }
    return _instance;
  }

  // /// mapStateDispatcher
  CYAMapStateDispatcher getMapStateDispatcher() => _mapStateDispatcher;

  // mapGetStateDispatcher
  CYAMapGetStateDispatcher getMapGetStateDispatcher() => _mapGetStateDispatcher;

  /// mapUserLocationDispatcher
  CYUserLocationDispatcher getMapUserLocationDispatcher() => _userLocationDispatcher;

  /// markerDispatcher
  CYMarkerDispatcher getMarkerDispatcher() => _markerDispatcher;

  // /// overlayDispatcher
  CYOverlayDispatcher getOverlayDispatcher() => _overlayDispatcher;

  // /// offlineMapDispatcher
  // BMFOfflineMapDispatcher getOfflineMapDispatcher() => _offlineMapDispatcher;

  /// widgetStateDispatcher
  CYAMapWidgetStateDispatcher getMapWidgetStateDispatcher() => _mapWidgetStateDispatcher;
}
