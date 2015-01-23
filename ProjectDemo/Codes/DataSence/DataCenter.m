//
//  DataCenter.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/21.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "DataCenter.h"

@interface DataCenter ()

@end

@implementation DataCenter

+ (instancetype)defaultCenter {
    static dispatch_once_t onceToken;
    static DataCenter *center = nil;
    dispatch_once(&onceToken, ^{
        center = [[self alloc] init];
    });
    return center;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [MagicalRecord setupCoreDataStack];
    }
    return self;
}

+ (NSManagedObjectContext *)defaultManagedObjectContext {
    return [[DataCenter defaultCenter] defaultManagedObjectContext];
}

- (NSManagedObjectContext *)defaultManagedObjectContext {
    return [NSManagedObjectContext MR_defaultContext];
}

@end
