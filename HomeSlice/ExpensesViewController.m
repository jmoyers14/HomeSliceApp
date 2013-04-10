//
//  ExpensesViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "ExpensesViewController.h"

@interface ExpensesViewController ()

@end

@implementation ExpensesViewController
@synthesize tView = _tView;
@synthesize expenses = _expenses;
@synthesize nameTitle = _nameTitle;

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
    self.expenses = [[NSMutableArray alloc] init];
    self.title = [NSString stringWithFormat:@"%@'s Expenses", self.displayPerson.name];
    
    
    NSString *personId = self.displayPerson.person_id;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:personId forKey:@"person_id"];
    NSArray *expenseData = [Network makeGetRequestWithData:parameters toURL:EXPENSE_URL];
    [self refreshExpenses:expenseData];
    
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{

    NSString *personId = self.displayPerson.person_id;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:personId forKey:@"person_id"];
    [self makeGetRequestInBackgroundWithData:parameters toURL:EXPENSE_URL];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BlankNavBar"] forBarMetrics:UIBarMetricsDefault];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expenses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"ExpenseCell";
    ExpenseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ExpenseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Expense *e = (Expense *)[self.expenses objectAtIndex:indexPath.row];
    cell.amount.text = e.amount;
    cell.name.text = e.name;

    return cell;
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
             [self refreshExpenses:array];
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

- (void) refreshExpenses:(NSArray *)expenseData
{
    [self.expenses removeAllObjects];
    
    for(NSDictionary *dict in expenseData)
    {
        NSString *pID = (NSString *)[dict objectForKey:@"person_id"];
        if([pID isEqualToString:self.displayPerson.person_id])
        {
            Expense *e = [[Expense alloc] initWithDict:dict];
            [self.expenses addObject:e];
        }
    }
    
    [self.tView reloadData];
}

@end
