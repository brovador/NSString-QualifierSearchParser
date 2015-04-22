//
//  ViewController.m
//  AttributedSearchFiltering
//
//  Created by Jesús on 22/4/15.
//  Copyright (c) 2015 Jesús. All rights reserved.
//

#import "SampleEntity.h"
#import "SampleModel.h"
#import "SampleCell.h"
#import "ViewController.h"
#import "NSString+QualifierSearchParser.h"

@interface ViewController ()<UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, assign) IBOutlet UITableView *tblResults;
@property (nonatomic, assign) IBOutlet UISearchBar *sbSearchQuery;
@property (nonatomic, assign) IBOutlet UILabel *lbDebug;

@property (nonatomic, strong) NSArray *elements;
@property (nonatomic, strong) NSArray *filteredElements;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tblResults registerClass:[SampleCell class] forCellReuseIdentifier:@"cellIdentifier"];
    
    self.elements = [SampleModel fetchResults];
    self.filteredElements = _elements;
}

#pragma mark Public

- (void)setFilteredElements:(NSArray *)filteredElements
{
    if (filteredElements != _filteredElements) {
        _filteredElements = filteredElements;
        [_tblResults reloadData];
    }
}

#pragma mark Private

- (void)_updateFilteredElements:(NSString*)searchFilter
{
    NSDictionary *filter = [searchFilter qualifierSearchParser_parseFromString:searchFilter qualifiers:@[@"year", @"category"]];
    NSString *yearFilter = filter[@"year"];
    NSString *categoryFilter = filter[@"category"];
    NSString *query = filter[@"_query"];
    
    NSMutableArray *filteredElements = [NSMutableArray new];
    [_elements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SampleEntity *entity = (SampleEntity*)obj;
        
        if (yearFilter != nil && ![[entity.year lowercaseString] isEqualToString:[yearFilter lowercaseString]]) {
            return;
        }
        
        if (categoryFilter != nil && ![[entity.category lowercaseString] isEqualToString:[categoryFilter lowercaseString]]) {
            return;
        }
        
        if (query != nil && ![query isEqualToString:@""] && ![[entity.title lowercaseString] containsString:[query lowercaseString]]) {
            return;
        }
        
        [filteredElements addObject:entity];
    }];
    
    self.filteredElements = filteredElements;
    
    NSMutableArray *debugTextParts = [NSMutableArray array];
    [filter enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [debugTextParts addObject:[NSString stringWithFormat:@"%@:\"%@\"", key, obj]];
    }];
    _lbDebug.text = [debugTextParts componentsJoinedByString:@", "];
}


#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self _updateFilteredElements:searchText];
}

#pragma mark UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleEntity *entity = [_filteredElements objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = entity.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%@) %@", entity.year, entity.category];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filteredElements count];
}



@end
