package com.chengyu.cy_amap_search;


import com.amap.api.services.core.LatLonPoint;
import com.amap.api.services.route.RidePath;
import com.amap.api.services.route.RideRouteResult;
import com.amap.api.services.route.RideStep;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FlutterDataConveter {

    /**
     * 将CameraPosition转换为map
     * @param rideRouteResult
     * @return
     */
    public static Map<String, Object> rideRouteResultToMap(RideRouteResult rideRouteResult){
        if(null == rideRouteResult){
            return null;
        }

        HashMap<String, Object> rideRouteResultMap = new HashMap<>();
        ArrayList<Map> ridePathsList = new ArrayList<>();
        List<RidePath> ridePaths = rideRouteResult.getPaths();
        for (RidePath ridePath : ridePaths){
            HashMap<String, Object> ridePathMap = new HashMap<>();
            ridePathMap.put("distance",ridePath.getDistance());
            ridePathMap.put("duration",ridePath.getDuration());

            HashMap<String, Object> rideStepsMap = new HashMap<>();
            ridePathMap.put("rideStepsMap",rideStepsMap);
            List<RideStep>  rideSteps = ridePath.getSteps();
            ArrayList<Map> rideStepList = new ArrayList<>();
            for (RideStep rideStep: rideSteps){
                HashMap<String, Object> rideStepMap = new HashMap<>();
                rideStepMap.put("action",rideStep.getAction());
                rideStepMap.put("assistantAction",rideStep.getAssistantAction());
                rideStepMap.put("distance",rideStep.getDistance());
                rideStepMap.put("duration",rideStep.getDuration());
                rideStepMap.put("instruction",rideStep.getInstruction());

                rideStepMap.put("orientation",rideStep.getOrientation());
                rideStepMap.put("road",rideStep.getRoad());

                List<LatLonPoint> latLonPoints = rideStep.getPolyline();
                ArrayList<Map> latLonPointList = new ArrayList<>();

                for (LatLonPoint latLonPoint:latLonPoints){
                    HashMap<String, Object> latLonPointMap = new HashMap<>();
                    latLonPointMap.put("latitude",latLonPoint.getLatitude());
                    latLonPointMap.put("longitude",latLonPoint.getLongitude());
                    latLonPointList.add(latLonPointMap);
                }
                rideStepMap.put("polyline",latLonPointList);
                rideStepList.add(rideStepMap);
            }
            ridePathMap.put("rideSteps",rideStepList);

            List<LatLonPoint> latLonPoints = ridePath.getPolyline();
            ArrayList<Map> latLonPointsList = new ArrayList<>();
            for (LatLonPoint latLonPoint:latLonPoints){
                HashMap<String, Object> latLonPointMap = new HashMap<>();
                latLonPointMap.put("latitude",latLonPoint.getLatitude());
                latLonPointMap.put("longitude",latLonPoint.getLongitude());
                latLonPointsList.add(latLonPointMap);
            }
            ridePathMap.put("polyline",latLonPointsList);
            ridePathsList.add(ridePathMap);
        }
        rideRouteResultMap.put("ridePaths",ridePathsList);

        HashMap<String, Object> startPosMap = new HashMap<>();
        startPosMap.put("longitude",rideRouteResult.getStartPos().getLongitude());
        startPosMap.put("latitude",rideRouteResult.getStartPos().getLatitude());
        rideRouteResultMap.put("startPos",startPosMap);

        HashMap<String, Object> targetPosMap = new HashMap<>();
        targetPosMap.put("longitude",rideRouteResult.getTargetPos().getLongitude());
        targetPosMap.put("latitude",rideRouteResult.getTargetPos().getLatitude());
        rideRouteResultMap.put("targetPos",targetPosMap);



        HashMap<String, Object> rideQueryMap = new HashMap<>();

        rideQueryMap.put("extensions",rideRouteResult.getRideQuery().getExtensions());

        HashMap<String, Object> fromAndToMap = new HashMap<>();
        fromAndToMap.put("destinationPoiID",rideRouteResult.getRideQuery().getFromAndTo().getDestinationPoiID());
        fromAndToMap.put("destinationType",rideRouteResult.getRideQuery().getFromAndTo().getDestinationType());
        fromAndToMap.put("originType",rideRouteResult.getRideQuery().getFromAndTo().getOriginType());
        fromAndToMap.put("plateNumber",rideRouteResult.getRideQuery().getFromAndTo().getPlateNumber());

        fromAndToMap.put("plateProvince",rideRouteResult.getRideQuery().getFromAndTo().getPlateProvince());

        fromAndToMap.put("startPoiID",rideRouteResult.getRideQuery().getFromAndTo().getStartPoiID());



        HashMap<String, Object> fromMap = new HashMap<>();
        fromMap.put("longitude",rideRouteResult.getRideQuery().getFromAndTo().getFrom().getLongitude());
        fromMap.put("latitude",rideRouteResult.getRideQuery().getFromAndTo().getFrom().getLatitude());
        fromAndToMap.put("from",fromMap);

        HashMap<String, Object> toMap = new HashMap<>();
        toMap.put("longitude",rideRouteResult.getRideQuery().getFromAndTo().getTo().getLongitude());
        toMap.put("latitude",rideRouteResult.getRideQuery().getFromAndTo().getTo().getLatitude());
        fromAndToMap.put("to",toMap);
        rideQueryMap.put("fromAndToMap",fromAndToMap);

        rideRouteResultMap.put("rideQuery",rideQueryMap);
        return rideRouteResultMap;
    }
}
