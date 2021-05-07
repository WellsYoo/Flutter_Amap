//
//  NSObject+BMFVerify.m
//  flutter_bmfbase
//
//  Created by zbj on 2020/2/10.
//

#import "NSObject+CYVerify.h"

@implementation NSObject (CYVerify)
/// null, nil检测
- (BOOL)isValidParam{
    return self != [NSNull null] && self;
}
@end

#define CheckNull(value) value == [NSNull null] ? nil : value
/// 对 value进行  [NSNull null]判断  空值置为nil
@implementation NSDictionary (safeObjectForKey)

- (id)safeObjectForKey:(NSString*)key{
    return CheckNull([self objectForKey:key]);
}
- (id)safeValueForKey:(NSString*)key{
    return CheckNull([self valueForKey:key]);
}

- (id)safeValueForKeyPath:(NSString *)keyPath{
    return CheckNull([self valueForKeyPath:keyPath]);
}
@end
