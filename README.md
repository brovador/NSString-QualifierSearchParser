# NSString+QualifierSearchParser

NSString category for parsing search queries using qualifiers like github code search or gmail filtering

From a ```NSString``` will create a ```NSDictionary``` containing the found values for the given qualifiers.

![generated sample](http://brovador.github.io/NSString-QualifierSearchParser/Demo.gif)

## Code example

Using the following query string:

```
NSString searchQuery = @"The avengers year:2015 genre:action";
NSDictionary *result = [searchQuery qualifierSearchParser_parseQualifiers:@[@"year", @"genre"]];

//Result will contain:
//@{
//	@"year" : @"2015",
//	@"genre" : @"action",
// @"_query" : @"The avengers"
//}

```

# License 

MIT

