//
//  HomeViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "HomeViewController.h"
#import "Singleton.h"
#import "Network.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize roommates = _roommates;
@synthesize tView = _tView;
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
    //((Singleton *)[Singleton sharedInstance]).roommates = [[NSMutableDictionary alloc] init];
    //NSString *houseID = ((Singleton *)[Singleton sharedInstance]).user.person.house.house_id;
    NSString *houseID = ((Singleton *)[Singleton sharedInstance]).user.person.house_id;
    NSArray *roommateData = [[NSArray alloc] init];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:houseID forKey:@"house_id"];
    roommateData = [Network makeGetRequestWithData:parameters toURL:PERSON_URL];
    
    [((Singleton *)[Singleton sharedInstance]) createRoomatesWithData:roommateData];
    self.roommates = ((Singleton *)[Singleton sharedInstance]).roommates;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{

    //[self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"TabBarBackgroundSelected.png"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBarTrim"] forBarMetrics:UIBarMetricsDefault];

//    NSString *houseID = ((Singleton *)[Singleton sharedInstance]).user.person.house_id;
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:houseID forKey:@"house_id"];
//    [self makeGetRequestInBackgroundWithData:parameters toURL:PERSON_URL];

}

#pragma - mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma - mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.roommates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"GraphCell";
    GraphCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[GraphCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Person *p = (Person *)[self.roommates objectAtIndex:indexPath.row];
    [cell.roommateName setFont:[UIFont fontWithName:@"Marmellata(Jam)_demo.ttf" size:10]];
    cell.roommateName.text = p.name;
    cell.delegate = self;
    cell.expenses.userInteractionEnabled = YES;
    cell.index= indexPath.row;
    cell.rent.text = [NSString stringWithFormat:@"%3.2f", [p.rent floatValue]];
    [cell setUpLabel];
    
    cell.expenses.text = [NSString stringWithFormat:@"%3.2f", p.debt];
    
    if((indexPath.row % 2) == 1)
    {
        cell.cellBackground.image = [UIImage imageNamed:@"TanishGraphCell"];
        cell.rent.textColor         = [UIColor blackColor];
        cell.expenses.textColor     = [UIColor blackColor];
        cell.roommateName.textColor = [UIColor blackColor];
        cell.total.textColor        = [UIColor blackColor];
    }
    else
    {
        cell.cellBackground.image = [UIImage imageNamed:@"BlueGraphCell"];
        cell.rent.textColor         = [UIColor whiteColor];
        cell.expenses.textColor     = [UIColor whiteColor];
        cell.roommateName.textColor = [UIColor whiteColor];
        cell.total.textColor        = [UIColor whiteColor];
    }
    
    return cell;
}

-(void)updateRentForPerson:(NSInteger)index byAmount:(float)rent
{
    Person *p = [self.roommates objectAtIndex:index];
    [p updateRentToAmount:rent];
}

-(void)showExpensesFor:(NSInteger)index
{
    NSLog(@"show shit for %d", index);
    [self performSegueWithIdentifier:@"ExpensePush" sender:[NSNumber numberWithInt:index]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[NSNumber class]]) {
        NSNumber *num = (NSNumber *)sender;
        NSInteger i = [num intValue];
        
        ((ExpensesViewController *)segue.destinationViewController).displayPerson = [self.roommates objectAtIndex:i];
    }
}

#pragma -mark Network functions
- (void) makeGetRequestInBackgroundWithData:(NSDictionary *)getDict toURL:(NSString *)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *queryString = [Network urlEncodeDictionary:getDict];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", url, queryString]]];
    [request addValue:HTTP_APPID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request addValue:HTTP_API_KEY forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request setValue:HTTP_CONT_TYPE forHTTPHeaderField:@"Content-Type"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
         {
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             NSArray *array = [dict objectForKey:@"results"];
             [self refreshRoommates:array];
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"error refreshing");
         }
         else if (error != nil)
         {
             NSLog(@"error refreshing nil");             
         }
     }];
    
}

- (void) refreshRoommates:(NSArray *)roommateData
{
    [((Singleton *)[Singleton sharedInstance]) createRoomatesWithData:roommateData];
    self.roommates = ((Singleton *)[Singleton sharedInstance]).roommates;
    [self.tView reloadData];

}

@end
