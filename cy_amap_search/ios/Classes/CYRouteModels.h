//
//  CYSearchModels.h
//  cy_2d_amap_base
//
//  Created by Wells Ye on 2020/12/10.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "CYModel.h"
#import "CYAMapModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface CYAMapStep : CYModel
///行走指示
@property (nonatomic, copy)   NSString  *instruction;
///方向
@property (nonatomic, copy)   NSString  *orientation;
///道路名称
@property (nonatomic, copy)   NSString  *road;
///此路段长度（单位：米）
@property (nonatomic, assign) NSInteger  distance;
///此路段预计耗时（单位：秒）
@property (nonatomic, assign) NSInteger  duration;
///此路段坐标点串
@property (nonatomic, copy)   NSString  *polyline;
///导航主要动作
@property (nonatomic, copy)   NSString  *action;
///导航辅助动作
@property (nonatomic, copy)   NSString  *assistantAction;
///此段收费（单位：元）
@property (nonatomic, assign) CGFloat    tolls;
///收费路段长度（单位：米）
@property (nonatomic, assign) NSInteger  tollDistance;
///主要收费路段
@property (nonatomic, copy)   NSString  *tollRoad;

- (AMapStep *)toAMapStep;
+ (CYAMapStep *)fromAMapStep:(AMapStep *)aMapStep;
@end



@interface CYAMapPath : CYModel
///起点和终点的距离
@property (nonatomic, assign) NSInteger  distance;
///预计耗时（单位：秒）
@property (nonatomic, assign) NSInteger  duration;
///导航策略
@property (nonatomic, copy)   NSString  *strategy;
///导航路段 AMapStep 数组
@property (nonatomic, strong) NSArray<CYAMapStep *> *steps;
///此方案费用（单位：元）
@property (nonatomic, assign) CGFloat    tolls;
///此方案收费路段长度（单位：米）
@property (nonatomic, assign) NSInteger  tollDistance;
///此方案交通信号灯个数
@property (nonatomic, assign) NSInteger  totalTrafficLights;

/**
 限行信息，仅在驾车和货车路径规划时有效。（since 6.0.0）
 驾车路径规划时：
 0 代表限行已规避或未限行; 1 代表限行无法规避。
 货车路径规划时：
 0，未知（未输入完整/正确车牌号信息时候显示）
 1，已规避限行
 2，起点限行
 3，途径点在限行区域内（设置途径点才出现此报错）
 4，途径限行区域
 5，终点限行
 */
@property (nonatomic, assign) NSInteger restriction;
///规划路径完整坐标点串集合（since 7.4.0）
@property (nonatomic, copy)   NSString  *polyline;
- (AMapPath *)toAMapPath;
+ (CYAMapPath *)fromAMapPath:(AMapPath *)aMapPath;
@end

@interface CYAMapRoute : CYModel
///起点坐标
@property (nonatomic, strong) CYCoordinate *origin;
///终点坐标
@property (nonatomic, strong) CYCoordinate *destination;
///出租车费用（单位：元）
@property (nonatomic, assign) CGFloat  taxiCost;
///步行、骑行、驾车方案列表 AMapPath 数组
@property (nonatomic, strong) NSArray<CYAMapPath *> *paths;

- (AMapRoute *)toAMapRoute;
+ (CYAMapRoute *)fromAMapRoute:(AMapRoute *)aMapRoute;
@end
NS_ASSUME_NONNULL_END
