//
//  BMFModel.m
//  flutter_bmfbase
//
//  Created by zbj on 2020/2/10.
//  Copyright © 2020 zbj. All rights reserved.
//

#import "CYModel.h"
#import <objc/runtime.h>

@implementation CYModel

+ (nonnull instancetype)cy_modelWith:(nonnull NSDictionary *)dic {
    // 初始化
    id obj = [[self alloc] init];

    // 属性个数
    unsigned int outCount = 0;

    // 属性列表
    objc_property_t *propretyList = class_copyPropertyList([obj class], &outCount);

    // 遍历属性
    for (unsigned int i = 0; i < outCount; i++) {

        objc_property_t property = propretyList[i];
        // 属性名字
        NSString *propertyName = [NSString stringWithUTF8String: property_getName(property)];
        
        // 属性类型
        const char *cType = property_copyAttributeValue(property, "T");
        NSString *propertyType = [NSString stringWithUTF8String:cType];
        propertyType = [propertyType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        propertyType = [propertyType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        delete []cType;
        cType = NULL;
        // 检测忽略的propertyName
        NSArray *ignoreArray;
        if ([[obj class] respondsToSelector:@selector(cy_setupIgnorePropertyNames)]) {
           ignoreArray = [[obj class] cy_setupIgnorePropertyNames].copy;
        }
        if ([ignoreArray containsObject:propertyName]) continue;
        
         // 检测有没有需要替换的propertyName
        NSDictionary *replaceDic;
         if ([[obj class] respondsToSelector:@selector(cy_setupReplacedKeyFromPropertyName)]) {
             replaceDic = [[obj class] cy_setupReplacedKeyFromPropertyName];
         }
         // 根据propertyName值，从dic中获取value
        id value = (replaceDic && replaceDic[propertyName]) ? dic[replaceDic[propertyName]] : dic[propertyName];
        // 如果模型属性数量大于字典键值对数，模型属性会被赋值为nil而报错
        if (value == nil || value == [NSNull null]) continue;

        // 处理value为数组的情况
        if ([value isKindOfClass:[NSArray class]]) {
            if ([[obj class] respondsToSelector:@selector(cy_setupObjectClassInArray)]) {

                NSString *type = [[obj class] cy_setupObjectClassInArray][propertyName];
                Class cls = objc_getClass(type.UTF8String);
                if (cls && ![type hasPrefix:@"NS"]) { //自定义model
                    NSMutableArray *models = [NSMutableArray array];
                    for (NSDictionary *_dic in value) {
                        id model = [cls cy_modelWith:_dic];
                        [models addObject:model];
                    }
                    value = models.copy;
                    if (value) {
                        [obj setValue:value forKey:propertyName];
                    }
//                    !value ? : [obj setValue:value forKey:propertyName];
                } else if ([type hasPrefix:@"NS"] && ![type isEqualToString:@"NSArray"]){
                    [obj setValue:value forKey:propertyName];
                } else if ([type isEqualToString:@"NSArray"]){ // 数组存放数组
//                    NSMutableArray *valueArray = [NSMutableArray array];
//
//                    for (NSArray *obj in value) {
//                        NSMutableArray *valueChild = [NSMutableArray array];
//                        for (id objChild in obj) {
//                          id model = [[objChild class] bmf]
//                        }
//                    }
                }
            } else {
                //TODO:未指定数组model类型
                NSLog(@"dic -> model 未指定数组model类型");
            }
        } else if ([value isKindOfClass:[NSDictionary class]]) {

            if (![propertyType hasPrefix:@"NS"]) { //propertyType = model;
                Class cls = objc_getClass(propertyType.UTF8String);
                id obj = [cls cy_modelWith:(NSDictionary *)value];
                value = obj ? obj : nil;
            }
            if (value) {
                [obj setValue:value forKey:propertyName];
            }
                        
//            !value ? : [obj setValue:value forKey:propertyName];

        } else {
            if (value) {
                [obj setValue:value forKey:propertyName];
            }
//            !value ? : [obj setValue:value forKey:propertyName];
        }
    }
    free(propretyList);
    return obj;
}
/// 基础数据类型判断
+ (BOOL)isBaseType:(NSString *)type{
    return [@[@"c", @"i", @"s", @"l", @"q",
              @"C", @"I", @"S", @"L", @"Q",
              @"f", @"d", @"B"] containsObject:type];
}

+ (NSDictionary *)cy_dicFrom:(id)model{
    // key = propertyName
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    // 属性个数
    unsigned int count;
    // 属性列表
    objc_property_t *propretyList = class_copyPropertyList([model class], &count);
    // 遍历列表
    for (unsigned int i = 0; i < count; i++) {
         
        objc_property_t property = propretyList[i];
        // 属性名字
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        // 属性类型
        const char *cType = property_copyAttributeValue(property, "T");
        NSString *propertyType = [NSString stringWithUTF8String:cType];
        delete []cType;
        cType = NULL;
        
        // 属性值
        id value = [model valueForKey:propertyName];
        
        // 查看propertyName是否需要替换
        NSDictionary *replaceDic;
        if ([[model class] respondsToSelector:@selector(cy_setupReplacedKeyFromPropertyName)]) {
            replaceDic = [[model class] cy_setupReplacedKeyFromPropertyName];
        }
        // 替换propertyName
        propertyName = (replaceDic && replaceDic[propertyName]) ? replaceDic[propertyName] : propertyName;
        
        // value为nil null
        if (value == nil || value == [NSNull null]) {
            [dic setObject:[NSNull null] forKey:propertyName];
            continue;
        }
        
        // value为基础数据类型
        if (model && model != [NSNull null]) {
            if ([[model class] isBaseType:propertyType]) {
                [dic setObject:(NSNumber *)value forKey:propertyName];
                continue;
            }
        }
       
        // value为对象
        if ([value isKindOfClass:[NSArray class]]) {
            if ([[model class] respondsToSelector:@selector(cy_setupObjectClassInArray)]) {
                // 获取数组model对应的类型
                NSString *type = [[model class] cy_setupObjectClassInArray][propertyName];
                Class cls = objc_getClass(type.UTF8String);

                if (cls && ![type hasPrefix:@"NS"]) { //自定义model
                    NSMutableArray *models = [NSMutableArray array];
                    for (id obj in value) {
                        id m = [cls cy_dicFrom:obj];
                        if (m) {
                            [models addObject:m];
                        }
//                        !m ? : [models addObject:m];
                    }
                    value = models.copy;
                    [dic setObject:value forKey:propertyName];
                } else if ([type hasPrefix:@"NS"] && ![type isEqualToString:@"NSArray"]) { //oc的NS对象
                      [dic setObject:value forKey:propertyName];
                } else if ([type isEqualToString:@"NSArray"]) { // 数组存放数组
                    NSMutableArray *models = [NSMutableArray array];
                    for (id obj in value) {
                        id m = [[obj class] cy_dicFrom:obj];
                        if (m) {
                            [models addObject:m];
                        }
//                        NSMutableArray *modelC = [NSMutableArray array];
//                        for (id obj in model) {
//                            id m = [[obj class] cy_dicFrom:obj];
//                            if (m) {
//                                [models addObject:m];
//                            }
////                            !m ? : [modelC addObject:m];
//                        }
//                        [models addObject:modelC];
                     
                    }
                    value = models.copy;
                    [dic setObject:value forKey:propertyName];
                }
            } else {
                  //TODO:未指定数组model类型
                [dic setObject:value forKey:propertyName];
            }
            
        } else if ([value isKindOfClass:[NSDictionary class]]) { //value为字典
            NSMutableDictionary *vDic = [NSMutableDictionary dictionary];
            // 遍历字典
            for (NSString *key in [(NSDictionary *)value allKeys]) {
                id obj = value[key];
                Class cls = [obj class];
                // key:model
                if (cls && ![NSStringFromClass(cls) hasSuffix:@"NS"]) {
                    id m = [cls cy_dicFrom:obj];
                    [vDic setObject:m forKey:key];
                } else if ([NSStringFromClass(cls) hasSuffix:@"NS"]) { //key:NSObject
                    [vDic setObject:obj forKey:key];
                }
            }
            if (vDic) {
               [dic setObject:vDic forKey:propertyName];
            }
//            !vDic ? : [dic setObject:vDic forKey:propertyName];
            
        } else if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]){
            [dic setObject:value forKey:propertyName];
        } else if (![propertyType hasPrefix:@"NS"]) {
            if (model && model !=[NSNull null]) {
                id m = [[model class] cy_dicFrom:value];
                if (m) {
                    [dic setObject:m forKey:propertyName];
                }
//                !m ? : [dic setObject:m forKey:propertyName];
            }
            
        }
        
    }
    free(propretyList);
    return dic;
}
- (NSDictionary *)cy_toDictionary{
    return [[self class] cy_dicFrom:self];
}
@end
