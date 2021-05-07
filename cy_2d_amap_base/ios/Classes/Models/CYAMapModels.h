//
//  CYMapModels.h
//  flutter_bmfbase
//
//  Created by zbj on 2020/2/10.
//

#import "NSObject+CYVerify.h"
#import "CYModel.h"

#import <MAMapKit/MAMapKit.h>


NS_ASSUME_NONNULL_BEGIN
/// 经纬度
@interface CYCoordinate : CYModel

/// 纬度
@property(nonatomic, assign) double latitude;

/// 经度
@property(nonatomic, assign) double longitude;

/// 经纬度结构体数组
+ (CLLocationCoordinate2D *)fromData:(NSArray<NSDictionary *> *)data;

/// 释放经纬度结构体数组
+ (BOOL)freeCoords:(CLLocationCoordinate2D *_Nonnull*_Nullable)coords;

/// MAMapPoint结构体数组
+ (MAMapPoint *)fromPoints:(NSArray<NSDictionary *> *)data;

/// 释放MAMapPoint结构体数组
+ (BOOL)freePoints:(MAMapPoint *_Nonnull*_Nullable)points;

/// CYCoordinate对象数组
+ (NSArray<CYCoordinate *> *)coordinatesWith:(NSArray<NSDictionary *> *)data;

/// CYCoordinate  ->  CLLocationCoordinate2D
- (CLLocationCoordinate2D)toCLLocationCoordinate2D;

/// CYCoordinate ->  MAMapPoint
- (MAMapPoint)toMAMapPoint;

/// CLLocationCoordinate2D -> CYCoordinate
+ (CYCoordinate *)fromCLLocationCoordinate2D:(CLLocationCoordinate2D)coord;

+ (CYCoordinate *)fromMAMapPoint:(MAMapPoint)mapPoint;

@end

/// 地理坐标点，用直角地理坐标表示
@interface CYAMapPoint : CYModel

/// 横坐标
@property (nonatomic, assign) double x;

/// 纵坐标
@property (nonatomic, assign) double y;


/// CYMapPoint -> CGPoint
- (CGPoint)toCGPoint;

/// CGPoint -> CYMapPoint
+ (CYAMapPoint *)fromCGPoint:(CGPoint)point;

/// CYMapPoint -> MAMapPoint
- (MAMapPoint)toMAMapPoint;

/// MAMapPoint -> CYMapPoint
+ (CYAMapPoint *)fromMAMapPoint:(MAMapPoint)point;
@end

/// 矩形大小，用直角地理坐标表示
@interface CYAMapSize : CYModel

/// 宽度
@property (nonatomic, assign) CGFloat width;

/// 高度
@property (nonatomic, assign) CGFloat height;

/// CYMapSize -> MAMapSize
- (MAMapSize)toMAMapSize;

/// MAMapSize -> CYMapSizeMAMapSize
+ (CYAMapSize *)fromMAMapSize:(MAMapSize)mapSize;

@end

/// 表示一个经纬度范围
@interface CYCoordinateSpan : CYModel

/// 纬度范围
@property (nonatomic, assign) double latitudeDelta;

/// 经度范围
@property (nonatomic, assign) double longitudeDelta;

/// CYCoordinateSpan -> MACoordinateSpan
- (MACoordinateSpan)toMACoordinateSpan;

/// MACoordinateSpan -> CYCoordinateSpan
+ (CYCoordinateSpan *)fromMACoordinateSpan:(MACoordinateSpan)span;

@end

/// 表示一个经纬度区域
@interface CYCoordinateRegion : CYModel

/// 中心点经纬度坐标
@property (nonatomic, strong) CYCoordinate *center;

/// 经纬度范围
@property (nonatomic, strong) CYCoordinateSpan *span;

/// CYCoordinateRegion -> MACoordinateRegion
- (MACoordinateRegion)toCoordinateRegion;

/// MACoordinateBounds -> CYCoordinateRegion
+ (CYCoordinateRegion *)fromMACoordinateBounds:(MACoordinateBounds)bounds;
@end

/// 表示一个经纬度区域
@interface CYCoordinateBounds : CYModel

/// 东北角点经纬度坐标
@property (nonatomic, strong) CYCoordinate *northeast;

/// 西南角点经纬度坐标
@property (nonatomic, strong) CYCoordinate *southwest;

/// CYCoordinateBounds -->  MACoordinateBounds
- (MACoordinateBounds)toMACoordinateBounds;

/// CYCoordinateBounds -->  MAMapRect
- (MAMapRect)toMAMapRect;

/// CYCoordinateBounds -->  MACoordinateRegion
- (MACoordinateRegion)toCoordinateRegion;

@end

/// 矩形，用直角地理坐标表示
@interface CYAMapRect : CYModel

/// 屏幕左上点对应的直角地理坐标
@property (nonatomic, strong) CYAMapPoint *origin;

/// 坐标范围
@property (nonatomic, strong) CYAMapSize *size;

/// CYMapRect -> MAMapRect
- (MAMapRect)toMAMapRect;
/// CYMapRect -> CGRect
- (CGRect)toCGRect;
/// CYMapRect -> CYCoordinateBounds
- (CYCoordinateBounds *)toCYCoordinateBounds;

/// MAMapRect -> CYMapRect
+ (CYAMapRect *)fromMAMapRect:(MAMapRect)rect;
@end
NS_ASSUME_NONNULL_END
