//
//  NSString+AttributedSearch.m
//  AttributedSearchFiltering
//
//  Created by Jesús on 22/4/15.
//  Copyright (c) 2015 Jesús. All rights reserved.
//

#import "NSString+QualifierSearchParser.h"

@implementation NSString (QualifierSearchParser)

- (NSDictionary*)qualifierSearchParser_parseFromString:(NSString *)queryString qualifiers:(NSArray*)queryParameters
{
    NSMutableDictionary *matches = [NSMutableDictionary new];
    NSString *paramRegexTemplate = @"%@:(\\\"[\\w\\s]+\\\"|\\w+)\\s*";
    
    __block NSString *remainingQueryString = [NSMutableString stringWithString:queryString];
    __block NSError *error = nil;
    [queryParameters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *parameter = (NSString*)obj;
        NSString *parameterRegex = [NSString stringWithFormat:paramRegexTemplate, parameter];
        NSRegularExpression *regEx = [NSRegularExpression
                                      regularExpressionWithPattern:parameterRegex
                                      options:NSRegularExpressionCaseInsensitive
                                      error:&error];
        
        [regEx enumerateMatchesInString:queryString
                                options:kNilOptions
                                  range:NSMakeRange(0, queryString.length)
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                 
                                 NSString *resultString = [queryString substringWithRange:result.range];
                                 NSString *cleanResult = [resultString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@:", parameter]
                                                                                      withString:@""];
                                 cleanResult = [cleanResult stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                                 cleanResult = [cleanResult stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                 matches[parameter] = cleanResult;
                                 
                                 remainingQueryString = [remainingQueryString stringByReplacingOccurrencesOfString:resultString withString:@""];
        }];
    }];

    matches[@"_query"] = [remainingQueryString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [NSDictionary dictionaryWithDictionary:matches];
}

@end