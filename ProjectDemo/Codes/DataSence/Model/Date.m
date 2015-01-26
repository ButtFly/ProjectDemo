//
//  Date.m
//  ProjectDemo
//
//  Created by 余河川 on 15/1/26.
//  Copyright (c) 2015年 余河川. All rights reserved.
//

#import "Date.h"


@implementation Date

@dynamic date;
@dynamic minute;

- (NSNumber *)minute {
    return @([[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian] component:NSCalendarUnitMinute fromDate:self.date]);
}

@end
