//
//  SuppliesViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "SuppliesViewController.h"
#import "Singleton.h"
#import "Network.h"
#import "constatns.h"
#import "Supply.h"
#import "SupplyCell.h"
#import "MCSwipeTableViewCell.h"
@interface SuppliesViewController () <MCSwipeTableViewCellDelegate>

@end

@implementation SuppliesViewController
@synthesize tView = _tView;
@synthesize supplies = _supplies;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshController = [[UIRefreshControl alloc] init];
    [refreshController addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tView addSubview:refreshController];
    
    
    //set up gesture recognizers
//    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
//    [recognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.tView addGestureRecognizer:recognizer];
//    
//    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
//    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.tView addGestureRecognizer:recognizer];
    
    self.supplies = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *getData = [[NSMutableDictionary alloc] init];
    NSString *houseId = ((Singleton *)[Singleton sharedInstance]).user.person.house_id;
    
    [getData setObject:houseId forKey:@"house_id"];
    
    NSArray *supplyDictionaries = [Network makeGetRequestForPosts:getData toURL:SUPPLY_URL];
    
    for (NSDictionary *dict in supplyDictionaries)
    {
        Supply *s = [[Supply alloc] initWithDictionary:dict];
        [self.supplies addObject:s];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"TabBarBackgroundBlank.png"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) refresh:(UIRefreshControl *)refreshControl
{
    [self performSelectorInBackground:@selector(reloadSupplies:) withObject:refreshControl];
}

- (void) reloadSupplies:(id)sender
{
    NSMutableDictionary *getData = [[NSMutableDictionary alloc] init];
    NSString *houseID = ((Singleton *)[Singleton sharedInstance]).user.person.house_id;
    [getData setObject:houseID forKey:@"house_id"];
    NSArray *supplyDictionaries = [Network makeGetRequestForPosts:getData toURL:SUPPLY_URL];
    
    if(supplyDictionaries != nil || supplyDictionaries.count <= 0)
    {
        [self.supplies removeAllObjects];
        for(NSDictionary *dict in supplyDictionaries)
        {
            Supply *s = [[Supply alloc] initWithDictionary:dict];
            [self.supplies addObject:s];
        }
    }
    
        [self performSelectorOnMainThread:@selector(doneReloadingSupplies:) withObject:sender waitUntilDone:NO];
}

- (void) doneReloadingSupplies:(id)sender
{
    UIRefreshControl *refreshController = (UIRefreshControl *)sender;
    [self.tView reloadData];
    [refreshController endRefreshing];
}

#pragma - mark gesture recognizers

- (void) handleSwipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.tView];
    
    NSIndexPath *indexPath = [self.tView indexPathForRowAtPoint:location];
    
    if(indexPath)
    {
        SupplyCell *cell = (SupplyCell *)[self.tView cellForRowAtIndexPath:indexPath];
        NSLog(@"%@ was swiped to the left", cell.supplyName.text);
    }
    
    
}

- (void) handleSwipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.tView];
    
    NSIndexPath *indexPath = [self.tView indexPathForRowAtPoint:location];
    
    if(indexPath)
    {
        SupplyCell *cell = (SupplyCell *)[self.tView cellForRowAtIndexPath:indexPath];
        NSLog(@"%@ was swiped to the right", cell.supplyName.text);
    }
    
}


#pragma - mark UITableViewDelegate

#pragma - mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.supplies.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Supply *supply = [self.supplies objectAtIndex:indexPath.row];
    
    if(!cell)
    {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.supply = supply;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setDelegate:self];
    [cell setFirstStateIconName:nil
                     firstColor:[UIColor colorWithRed:85.0/255.0 green:213.0/255.0 blue:80.0/255.0 alpha:1.0]
            secondStateIconName:nil
                    secondColor:nil
                  thirdIconName:nil
                     thirdColor:[UIColor colorWithRed:232.0/255.0 green:61.0/255.0 blue:14.0/255.0 alpha:1.0]
                 fourthIconName:nil
                    fourthColor:nil];
    
    if(supply.inStock == YES)
    {
        cell.outOfStockBanner.hidden = YES;
        cell.inStockBanner.hidden = NO;
    }
    else
    {
        cell.outOfStockBanner.hidden = NO;
        cell.inStockBanner.hidden = YES;
    }
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.text = supply.name;
    cell.detailTextLabel.text = @"place holder";
    cell.textLabel.frame = CGRectMake(100, 10, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height);
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

#pragma - mark MCSwipeTableCellDelegate

- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didTriggerState:(MCSwipeTableViewCellState)state withMode:(MCSwipeTableViewCellMode)mode
{
    NSLog(@"State changed for supply %@", cell.supply.name);
    NSNumber *inStock;
    
    if(cell.supply.inStock)
    {
        inStock = [NSNumber numberWithBool:NO];
        cell.supply.inStock = NO;
        [cell setStockTo:NO];
        //cell.outOfStockBanner.hidden = YES;
        //cell.inStockBanner.hidden = NO;
    }
    else
    {
        inStock = [NSNumber numberWithBool:YES];
        cell.supply.inStock = YES;
        [cell setStockTo:YES];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:inStock forKey:@"stocked"];
    [data setObject:cell.supply.objectId forKey:@"objectId"];
    

    [self performSelectorInBackground:@selector(updateSupply:) withObject:data];
 
}

- (void) updateSupply:(id)sender
{
    NSMutableDictionary *data = (NSMutableDictionary *)sender;
    NSString *objectId = [data objectForKey:@"objectId"];
    [data removeObjectForKey:@"objectId"];
    
    [Network updateObjectWithId:objectId withData:data toURL:SUPPLY_URL];
}
    
    //- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SupplyCell *cell;
//    Supply *supply = [self.supplies objectAtIndex:indexPath.row];
//    cell = [tableView dequeueReusableCellWithIdentifier:@"SupplyCell"];
//    if(cell == nil)
//    {
//        cell = [[SupplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SupplyCell"];
//    }
//    
//    cell.supplyName.text = supply.name;
//    if(supply.inStock == YES)
//    {
//        cell.banner.hidden = YES;
//    }
//    else
//    {
//        cell.banner.hidden = NO;
//    }
//    
//    return cell;
//}

@end
