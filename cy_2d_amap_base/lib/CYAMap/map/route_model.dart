import 'package:cy_2d_amap_base/CYAMap/cy_amap_base.dart';

class CYAMapRoute {
  CYCoordinate origin;
  CYCoordinate destination;
  double taxiCost;
  List<CYAMapPath> paths;

  CYAMapRoute({
    this.origin,
    this.destination,
    this.taxiCost,
    this.paths,
  });

  CYAMapRoute.fromJsonMap(Map<String, dynamic> map) {
    origin = CYCoordinate.coordinate().fromMap(map['origin']);
    destination = CYCoordinate.coordinate().fromMap(map['destination']);
    taxiCost = map['taxiCost'];

    if (map['paths'] != null) {
      paths = new List<CYAMapPath>();
      map['paths'].forEach((v) {
        paths.add(new CYAMapPath.fromJsonMap(new Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['origin'] = this.origin?.toMap();
    data['destination'] = this.destination?.toMap();
    data['taxiCost'] = taxiCost;
    if (this.paths != null) {
      data['paths'] = this.paths.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CYAMapStep {
  String instruction;
  String orientation;
  String road;
  int distance;
  int duration;
  String polyline;
  String action;
  String assistantAction;
  double tolls;
  int tollDistance;
  String tollRoad;

  CYAMapStep(
      {this.instruction,
      this.orientation,
      this.road,
      this.distance,
      this.duration,
      this.polyline,
      this.action,
      this.assistantAction,
      this.tolls,
      this.tollDistance,
      this.tollRoad});

  CYAMapStep.fromJsonMap(Map<String, dynamic> map)
      : instruction = map['instruction'] as String,
        orientation = map['orientation'] as String,
        road = map['road'] as String,
        distance = map['distance'] as int,
        duration = map['duration'] as int,
        polyline = map['polyline'] as String,
        action = map['action'] as String,
        assistantAction = map['assistantAction'] as String,
        tolls = map['tolls'] as double,
        tollDistance = map['tollDistance'] as int,
        tollRoad = map['tollRoad'] as String;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instruction'] = instruction;
    data['orientation'] = orientation;
    data['road'] = road;
    data['distance'] = distance;
    data['duration'] = duration;
    data['polyline'] = polyline;
    data['action'] = action;
    data['assistantAction'] = assistantAction;
    data['tollRoad'] = tollRoad;

    return data;
  }
}

class CYAMapPath {
  int distance;
  int duration;
  String strategy;
  List<CYAMapStep> steps;
  double tolls;

  String tollDistance;
  int totalTrafficLights;

  CYAMapPath({
    this.distance,
    this.duration,
    this.strategy,
    this.steps,
    this.tolls,
    this.tollDistance,
    this.totalTrafficLights,
  });

  CYAMapPath.fromJsonMap(Map<String, dynamic> map) {
    distance = map['distance'] as int;
    duration = map['duration'] as int;
    strategy = map['strategy'] as String;
    if (map['steps'] != null) {
      steps = new List<CYAMapStep>();
      map['steps'].forEach((v) {
        steps.add(new CYAMapStep.fromJsonMap(new Map<String, dynamic>.from(v)));
      });
    }
    distance = map['distance'] as int;

    duration = map['tollDistance'] as int;

    totalTrafficLights = map['totalTrafficLights'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distance'] = distance;
    data['duration'] = duration;
    data['strategy'] = strategy;
    data['tolls'] = tolls;
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    data['tollDistance'] = tollDistance;
    data['totalTrafficLights'] = totalTrafficLights;

    return data;
  }
}
