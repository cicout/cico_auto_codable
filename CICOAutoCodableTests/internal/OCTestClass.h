//
//  OCTestClass.h
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ENUM(NSInteger, OCTestIntEnum) {
    one = 1,
    two = 2
};

NS_ENUM(NSInteger, OCTestIntEnumX) {
    onex = 100,
    twox = 200
};

@interface OCTestClass : NSObject <NSCoding>

@property (nonatomic, strong) NSString *text;

@end

@interface OCTestClassX : NSObject <NSCoding>

@property (nonatomic, strong) NSString *textx;

@end
