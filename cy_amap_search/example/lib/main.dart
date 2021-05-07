import 'dart:io';

import 'package:cy_2d_amap_base/CYAMap/map/cy_amap_sdk.dart';
import 'package:cy_amap_search/cy_amap_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      CYAMapSDK.setAMapKey("f9ea65c746487ffcc27151f6e236bcfe");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text("搜索关键字"),
                onPressed: () {
                  CyAmapSearch.search("帝豪大厦");
                },
              ),
              RaisedButton(
                child: Text("POI搜索"),
                onPressed: () {
                  CyAmapSearch.searchPOI(lat: "118.10388605", lon: "24.48923061");
                },
              ),
              RaisedButton(
                child: Text("骑行路线距离"),
                onPressed: () {
                  CyAmapSearch.getRidingRouteDistance(
                      startLatitude: 118.10388605,
                      startLongitude: 24.48923061,
                      destinationLatitude: 118.18388605,
                      destinationLongitude: 24.49923061);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
