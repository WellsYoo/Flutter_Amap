package com.chengyu.cy_amap_search;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;

import androidx.annotation.MainThread;
import androidx.annotation.NonNull;

import com.amap.api.services.core.AMapException;
import com.amap.api.services.core.LatLonPoint;
import com.amap.api.services.core.PoiItem;
import com.amap.api.services.poisearch.PoiResult;
import com.amap.api.services.poisearch.PoiSearch;
import com.amap.api.services.route.BusRouteResult;
import com.amap.api.services.route.DriveRouteResult;
import com.amap.api.services.route.RidePath;
import com.amap.api.services.route.RideRouteResult;
import com.amap.api.services.route.RouteSearch;
import com.amap.api.services.route.WalkRouteResult;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** CyAmapSearchPlugin */
public class CyAmapSearchPlugin implements FlutterPlugin, MethodCallHandler, PoiSearch.OnPoiSearchListener, RouteSearch.OnRouteSearchListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private static  final String SEARCH_CONTENT = "010000|010100|020000|030000|040000|050000|050100|060000|060100|060200|060300|060400|070000|080000|080100|080300|080500|080600|090000|090100|090200|090300|100000|100100|110000|110100|120000|120200|120300|130000|140000|141200|150000|150100|150200|160000|160100|170000|170100|170200|180000|190000|200000";
  private static  final String TAG = "CyAmapSearchPlugin";
  private MethodChannel channel;
  private String keyWord = "";
  private String city = "";
  private PoiSearch.Query query;
  FlutterPluginBinding flutterPluginBinding;
  private Runnable postMessageRunnable;
  private  Handler platformThreadHandler;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

    platformThreadHandler = new Handler(flutterPluginBinding.getApplicationContext().getMainLooper());
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "cy_amap_search");
    channel.setMethodCallHandler(this);


    this.flutterPluginBinding = flutterPluginBinding;
  }


  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    String method = call.method;
    Map<String, Object> request = (Map<String, Object>) call.arguments;
    if (method.equals("search")) {
      keyWord = (String) request.get("keyWord");
      city = (String) request.get("city");
      search();
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(method.equals("searchPOI")){
      double latitude =   Double.valueOf(request.get("lat").toString());
      double longitude =  Double.valueOf(request.get("lon").toString());
      searchPOI(latitude,longitude);
    } else if(method.equals("getRidingRouteDistance")){
      LatLonPoint mStartPoint =  new LatLonPoint((Double) request.get("startLatitude"),(Double) request.get("startLongitude"));
      LatLonPoint mEndPoint =  new LatLonPoint((Double) request.get("destinationLatitude"),(Double) request.get("destinationLongitude"));
      getRidingRouteDistance(mStartPoint,mEndPoint);
      Log.e(TAG,"------------------------->getRidingRouteDistance");
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    platformThreadHandler.removeCallbacks(postMessageRunnable);


  }

  private void search() {
    query = new PoiSearch.Query(keyWord, SEARCH_CONTENT, city);
    // 设置每页最多返回多少条poiitem
    query.setPageSize(50);
    query.setPageNum(0);
    query.setExtensions(PoiSearch.EXTENSIONS_ALL);
    PoiSearch poiSearch = new PoiSearch(this.flutterPluginBinding.getApplicationContext(), query);
    poiSearch.setOnPoiSearchListener(this);
    poiSearch.searchPOIAsyn();
  }


  private void searchPOI(double latitude, double longitude) {
    query = new PoiSearch.Query("", SEARCH_CONTENT, "");
    // 设置每页最多返回多少条poiitem
    query.setPageSize(8);
    query.setPageNum(0);
    query.setExtensions(PoiSearch.EXTENSIONS_ALL);
    PoiSearch poiSearch = new PoiSearch(flutterPluginBinding.getApplicationContext(), query);
    poiSearch.setOnPoiSearchListener(this);
    LatLonPoint latLonPoint = new LatLonPoint(latitude, longitude);
    poiSearch.setBound(new PoiSearch.SearchBound(latLonPoint, 2000, true));
    poiSearch.searchPOIAsyn();
  }

  private void getRidingRouteDistance(LatLonPoint startPoint, LatLonPoint endPoint){
    RouteSearch mRouteSearch = new RouteSearch(flutterPluginBinding.getApplicationContext());
    mRouteSearch.setRouteSearchListener(this);
    final RouteSearch.FromAndTo fromAndTo = new RouteSearch.FromAndTo(
            startPoint, endPoint);
    RouteSearch.RideRouteQuery query = new RouteSearch.RideRouteQuery(fromAndTo, 4);
    mRouteSearch.calculateRideRouteAsyn(query);// 异步路径规划骑行模式查询
//    Map result = new HashMap();
//    result.put("12","32");
//    channel.invokeMethod("onRouteSearchDone", result);
  }

  private final StringBuilder builder = new StringBuilder();

  @Override
  public void onPoiSearched(PoiResult result, int code) {
    builder.delete(0, builder.length());
    // 拼接json（避免引用gson之类的库，小插件不必要。。。）
    builder.append("[");

    if (code == AMapException.CODE_AMAP_SUCCESS) {
      // 搜索poi的结果
      if (result != null && result.getQuery() != null) {
        // 是否是同一条
        if (result.getQuery().equals(query)) {
          final List<PoiItem> list = result.getPois();

          for (int i = 0; i < list.size(); i++) {
            PoiItem item = list.get(i);
            builder.append("{");


            builder.append("\"cityCode\": \"");builder.append(item.getCityCode());builder.append("\",");
            builder.append("\"cityName\": \"");builder.append(item.getCityName());builder.append("\",");
            builder.append("\"address\": \"");builder.append(item.getSnippet());builder.append("\",");
            builder.append("\"provinceName\": \"");builder.append(item.getProvinceName());builder.append("\",");
            builder.append("\"title\": \"");builder.append(item.getTitle());builder.append("\",");
            builder.append("\"adName\": \"");builder.append(item.getAdName());builder.append("\",");
            builder.append("\"adCode\": \"");builder.append(item.getAdCode());builder.append("\",");
            builder.append("\"provinceCode\": \"");builder.append(item.getProvinceCode());builder.append("\",");
            builder.append("\"latitude\": \"");builder.append(item.getLatLonPoint().getLatitude());builder.append("\",");
            builder.append("\"longitude\": \"");builder.append(item.getLatLonPoint().getLongitude());builder.append("\"");
            builder.append("},");
            if (i == list.size() - 1) {
              builder.deleteCharAt(builder.length() - 1);
            }
          }

        }
      }
    }
    builder.append("]");
    postMessageRunnable = new Runnable() {
      @Override
      public void run() {
        Map<String, String> map = new HashMap<>(2);
        map.put("poiSearchResult", builder.toString());
        channel.invokeMethod("poiSearchResult", map);
      }
    };
    if (platformThreadHandler.getLooper() == Looper.myLooper()) {
      postMessageRunnable.run();
    } else {
      platformThreadHandler.post(postMessageRunnable);
    }
  }

  @Override
  public void onPoiItemSearched(PoiItem poiItem, int i) {

  }

  @Override
  public void onBusRouteSearched(BusRouteResult busRouteResult, int i) {

  }

  @Override
  public void onDriveRouteSearched(DriveRouteResult driveRouteResult, int i) {

  }

  @Override
  public void onWalkRouteSearched(WalkRouteResult walkRouteResult, int i) {

  }

  @Override
  public void onRideRouteSearched(RideRouteResult rideRouteResult, int errorCode) {

    Map result = new HashMap();
    if (errorCode == AMapException.CODE_AMAP_SUCCESS) {
      if (rideRouteResult != null && rideRouteResult.getPaths() != null) {
        if (rideRouteResult.getPaths().size() > 0) {
          result.put("route",FlutterDataConveter.rideRouteResultToMap(rideRouteResult));
          channel.invokeMethod("onRouteSearchDone", result);
        } else if (rideRouteResult != null && rideRouteResult.getPaths() == null) {
          result.put("route",result);
          channel.invokeMethod("onRouteSearchDone", result);
        }
      } else {
        result.put("route",result);
        channel.invokeMethod("onRouteSearchDone", result);
      }
    } else {
      result.put("route",result);
      channel.invokeMethod("onRouteSearchDone", result);
    }
  }
}
