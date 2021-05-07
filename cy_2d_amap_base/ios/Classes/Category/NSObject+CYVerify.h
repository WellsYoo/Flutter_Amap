//
//  NSObject+BMFVerify.h
//  flutter_bmfbase
//
//  Created by zbj on 2020/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(CYVerify)

/// null, nil检测
- (BOOL)isValidParam;

@end


@interface NSDictionary (safeObjectForKey)

/// 对 value进行  [NSNull null]判断  空值置为nil
- (id)safeObjectForKey:(NSString*)key;

/// 对 value进行  [NSNull null]判断  空值置为nil
- (id)safeValueForKey:(NSString*)key;

/// 对 value进行  [NSNull null]判断  空值置为nil
- (id)safeValueForKeyPath:(NSString*)keyPath;

@end
NS_ASSUME_NONNULL_END
