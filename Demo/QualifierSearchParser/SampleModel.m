//
//  SampleModel.m
//  AttributedSearchFiltering
//
//  Created by Jesús on 22/4/15.
//  Copyright (c) 2015 Jesús. All rights reserved.
//

#import "SampleModel.h"
#import "SampleEntity.h"

@implementation SampleModel

+ (NSArray*)fetchResults
{
    NSArray *years = @[@"2012", @"2013", @"2014", @"2015"];
    NSArray *categories = @[@"Action adventure", @"Comedy", @"Drama", @"Sports"];
    
    NSInteger resultsToGenerate = 50;
    
    SampleEntity *entity;
    NSMutableArray *results = [NSMutableArray array];
    while ([results count] < resultsToGenerate) {
        entity = [SampleEntity new];
        entity.title = [NSString stringWithFormat:@"Entity title %lu", (unsigned long)[results count]];
        entity.year = [years objectAtIndex:arc4random_uniform((int)[years count])];
        entity.category = [categories objectAtIndex:arc4random_uniform((int)[categories count])];
        [results addObject:entity];
    }
    
    return results;
}

@end
