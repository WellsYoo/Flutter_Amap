//
//  CYMapModels.m
//  flutter_bmfbase
//
//  Created by zbj on 2020/2/10.
//

#import "CYAMapModels.h"


@implementation CYCoordinate

+ (BOOL)freeCoords:(CLLocationCoordinate2D *_Nonnull*_Nullable)coords{
    if (*coords) {
        free(*coords);
        return YES;
    }
    return NO;
}

+ (CLLocationCoordinate2D *)fromData:(NSArray<NSDictionary *> *)data {
    NSUInteger count = [data count];
    CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[count];
    for (int i = 0; i < count; i++) {
        coords[i] = [[CYCoordinate cy_modelWith:data[i]] toCLLocationCoordinate2D];
    }
    return coords;
}
/// MAMapPoint结构体数组
+ (MAMapPoint *)fromPoints:(NSArray<NSDictionary *> *)data{
    NSUInteger count = [data count];
    MAMapPoint *points = new MAMapPoint[count];
    for (int i = 0; i < count; i++) {
        points[i] = MAMapPointForCoordinate([[CYCoordinate cy_modelWith:data[i]] toCLLocationCoordinate2D]);
    }
    return points;
}

/// 释放MAMapPoint结构体数组
+ (BOOL)freePoints:(MAMapPoint *_Nonnull*_Nullable)points{
    if (*points) {
        free(*points);
        return YES;
    }
    return NO;
}
+ (NSArray<CYCoordinate *> *)coordinatesWith:(NSArray<NSDictionary *> *)data {
    NSMutableArray<CYCoordinate *> *mut = [NSMutableArray array];
    if (data.count > 0) {
        for (NSDictionary *dic in data) {
            CYCoordinate *coord = [CYCoordinate cy_modelWith:dic];
            [mut addObject:coord];
        }
    }
    return mut;
}

- (CLLocationCoordinate2D)toCLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (MAMapPoint)toMAMapPoint{
    CLLocationCoordinate2D coord = [self toCLLocationCoordinate2D];
    return MAMapPointForCoordinate(coord);
}

+ (CYCoordinate *)fromCLLocationCoordinate2D:(CLLocationCoordinate2D)coord {
    CYCoordinate *coordinate = [CYCoordinate new];
    coordinate.latitude = coord.latitude;
    coordinate.longitude = coord.longitude;
    return coordinate;
}

+ (CYCoordinate *)fromMAMapPoint:(MAMapPoint)mapPoint{
    CLLocationCoordinate2D coord = MACoordinateForMapPoint(mapPoint);
    return [CYCoordinate fromCLLocationCoordinate2D:coord];
}
@end

@implementation CYAMapPoint

- (MAMapPoint)toMAMapPoint {
    return MAMapPointMake(self.x, self.y);
}
- (CGPoint)toCGPoint{
    return CGPointMake(self.x, self.y);
}
+ (CYAMapPoint *)fromCGPoint:(CGPoint)point{
    CYAMapPoint *pt = [CYAMapPoint new];
    pt.x = point.x;
    pt.y = point.y;
    return pt;
}
+ (CYAMapPoint *)fromMAMapPoint:(MAMapPoint)point{
    CYAMapPoint *pt =[CYAMapPoint new];
    pt.x = point.x;
    pt.y = point.y;
    return pt;
}
@end

@implementation CYCoordinateSpan

- (MACoordinateSpan)toMACoordinateSpan {
    return MACoordinateSpanMake(self.latitudeDelta, self.longitudeDelta);
}
+ (CYCoordinateSpan *)fromMACoordinateSpan:(MACoordinateSpan)span{
    CYCoordinateSpan *sp = [CYCoordinateSpan new];
    sp.latitudeDelta = span.latitudeDelta;
    span.longitudeDelta = span.longitudeDelta;
    return sp;
}
@end

@implementation CYCoordinateRegion

- (MACoordinateRegion)toCoordinateRegion {
  return MACoordinateRegionMake([self.center toCLLocationCoordinate2D], [self.span toMACoordinateSpan]);
}

/// MACoordinateBounds -> CYCoordinateRegion
+ (CYCoordinateRegion *)fromMACoordinateBounds:(MACoordinateBounds)bounds {
    CYCoordinateRegion *region = [CYCoordinateRegion new];
    CYCoordinate *center = [CYCoordinate new];
    center.latitude = (bounds.northEast.latitude +  bounds.southWest.latitude) / 2;
    center.longitude = (bounds.northEast.longitude +  bounds.southWest.longitude) / 2;
    region.center = center;
    CYCoordinateSpan *span = [CYCoordinateSpan new];
    span.latitudeDelta = bounds.northEast.latitude - center.latitude;
    span.longitudeDelta = bounds.northEast.longitude - center.longitude;
    region.span = span;
    return region;

}
@end

@implementation CYCoordinateBounds

/// CYCoordinateBounds -->  MACoordinateBounds
- (MACoordinateBounds)toMACoordinateBounds{
    MACoordinateBounds bounds;
    bounds.northEast = [self.northeast toCLLocationCoordinate2D];
    bounds.southWest = [self.southwest toCLLocationCoordinate2D];
    return bounds;
}

- (MAMapRect)toMAMapRect {
    CLLocationCoordinate2D northEast; /// 东北角点经纬度坐标
    northEast = [self.northeast toCLLocationCoordinate2D];
    CLLocationCoordinate2D southWest; /// 西南角点经纬度坐标
    southWest = [self.southwest toCLLocationCoordinate2D];

    CLLocationCoordinate2D northWest; /// 西北角点经纬度坐标
    northWest.latitude = northEast.latitude;
    northWest.longitude = southWest.longitude;
    CLLocationCoordinate2D southEast; /// 东南角点经纬度坐标
    southEast.latitude = southWest.latitude;
    southEast.longitude = northEast.longitude;

    MAMapPoint point = MAMapPointForCoordinate(northWest);
    MAMapPoint point2 = MAMapPointForCoordinate(southEast);

    return MAMapRectMake(point.x, point.y, point2.x - point.x, point2.y - point.y);
}

- (MACoordinateRegion)toCoordinateRegion {
    MACoordinateBounds bounds;
    bounds.northEast = [self.northeast toCLLocationCoordinate2D];
    bounds.southWest = [self.southwest toCLLocationCoordinate2D];
    double latitudeCenter = (bounds.northEast.latitude + bounds.southWest.latitude) / 2;
    double longitudeCenter = (bounds.northEast.longitude + bounds.southWest.longitude) / 2;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitudeCenter, longitudeCenter);
    double latitudeSpan = bounds.northEast.latitude - latitudeCenter;
    double longitudeSpan = bounds.northEast.longitude - longitudeCenter;
    MACoordinateSpan span = MACoordinateSpanMake(latitudeSpan, longitudeSpan);
    return MACoordinateRegionMake(center, span);
}
@end

@implementation CYAMapSize

- (MAMapSize)toMAMapSize {
    return MAMapSizeMake(self.width, self.height);
}
+ (CYAMapSize *)fromMAMapSize:(MAMapSize)mapSize{
    CYAMapSize *size = [CYAMapSize new];
    size.width = mapSize.width;
    size.height = mapSize.height;
    return size;
}
@end


@implementation CYAMapRect

- (MAMapRect)toMAMapRect {
    return MAMapRectMake(self.origin.x, self.origin.y, self.size.width, self.size.height);
}

- (CGRect)toCGRect{
    return CGRectMake(self.origin.x, self.origin.y, self.size.width, self.size.height);
}

- (CYCoordinateBounds *)toCYCoordinateBounds {
    CYCoordinateBounds *bounds = [CYCoordinateBounds new];
    MAMapPoint point = MAMapPointMake(self.origin.x, self.origin.y); /// 西北角直角坐标
    CLLocationCoordinate2D northWest = MACoordinateForMapPoint(point);
    MAMapPoint point2 = MAMapPointMake(self.origin.x + self.size.width, self.origin.y + self.size.height); /// 东南角点经纬度坐标
    CLLocationCoordinate2D southEast = MACoordinateForMapPoint(point2);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(southEast.latitude, northWest.longitude); /// 东北角点经纬度坐标
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(northWest.latitude, southEast.longitude); /// 西南角点经纬度坐标
    bounds.northeast = [CYCoordinate fromCLLocationCoordinate2D:northEast];
    bounds.southwest = [CYCoordinate fromCLLocationCoordinate2D:southWest];
    return bounds;
}

+ (CYAMapRect *)fromMAMapRect:(MAMapRect)mapRect{
    CYAMapRect *rect = [CYAMapRect new];
    rect.origin = [CYAMapPoint fromMAMapPoint:mapRect.origin];
    rect.size = [CYAMapSize fromMAMapSize:mapRect.size];
    return rect;
}
@end
