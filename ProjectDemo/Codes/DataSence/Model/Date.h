//
//  Date.h
//  ProjectDemo
//
//  Created by 余河川 on 15/1/26.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Date : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * minute;

@end
