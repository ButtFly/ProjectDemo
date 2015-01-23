//
//  DataCenter.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/21.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface DataCenter : NSObject

+ (instancetype)defaultCenter;

+ (NSManagedObjectContext *)defaultManagedObjectContext;

@end
