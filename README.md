# NSString+QualifierSearchParser

NSString category for parsing search queries using qualifiers like github code search or gmail filtering.

From a ```NSString``` will create a ```NSDictionary``` containing the found values for the given qualifiers.

Accepts queries of form: ```qualifier1:value qualifier2:value search query```.

## Usage

```
#import "NSString+QualifierSearchParser.h"
...
NSString searchQuery = @"The avengers year:2015 genre:action";
NSDictionary *result = [searchQuery qualifierSearchParser_parseQualifiers:@[@"year", @"genre"]];
```

Result will contain:
```
{
	"year" : "2015",
	"genre" : "action",
	"_query" : "The avengers"
}
```


## Demo

![generated sample](http://brovador.github.io/NSString-QualifierSearchParser/Demo.gif)



## License 

MIT

