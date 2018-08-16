//
//  OCTestClass.m
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

#import "OCTestClass.h"

@implementation OCTestClass

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.text = [coder decodeObjectForKey:@"text"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.text forKey:@"text"];
}

@end
