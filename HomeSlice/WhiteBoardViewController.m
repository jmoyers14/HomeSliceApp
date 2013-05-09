//
//  WhiteBoardViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//
#import "constatns.h"
#import "WhiteBoardViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Post.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 210.0f
#define CELL_CONTENT_LEFT_MARGIN 60.0f
#define CELL_CONTENT_MARGIN 60.0f

#define LABEL_TOP_TAG 1
#define LABEL_MIDDLE_TAG 2
#define LABEL_BOTTOM_TAG 3
#define PIC_TAG 4
#define CELL_MARGIN 20

#define SINGLE_LINE_HEIGHT 14.0f

@interface WhiteBoardViewController ()

@end

@implementation WhiteBoardViewController
@synthesize tView     = _tView;
@synthesize posts     = _posts;
@synthesize roommates = _roommates;

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
    
    self.posts = [[NSMutableArray alloc] init];
    self.roommates = ((Singleton *)[Singleton sharedInstance]).roommatesDict;

    
    NSMutableDictionary *getData = [[NSMutableDictionary alloc] init];
    NSString *houseID = ((Singleton *)[Singleton sharedInstance]).user.person.house_id;
    [getData setObject:houseID forKey:@"house_id"];
    NSArray *postDictionaries = [Network makeGetRequestForPosts:getData toURL:POST_URL];
    
    for (NSDictionary *dict in postDictionaries)
    {
        Post *p = [[Post alloc] initWithDictionary:dict];
        [self.posts addObject:p];
    }
    
    [self.tView reloadData];
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

- (void)refresh:(UIRefreshControl *)refreshControl {
    NSLog(@"When does this happen??");
    
    [self performSelectorInBackground:@selector(reloadPosts:) withObject:refreshControl];
    //[refreshControl endRefreshing];
}

- (void) reloadPosts:(id)sender
{
    
    NSMutableDictionary *getData = [[NSMutableDictionary alloc] init];
    NSString *houseID = ((Singleton *)[Singleton sharedInstance]).user.person.house_id;
    [getData setObject:houseID forKey:@"house_id"];
    NSArray *postDictionaries = [Network makeGetRequestForPosts:getData toURL:POST_URL];
    
    if(postDictionaries != nil || postDictionaries.count <= 0 )
    {
        [self.posts removeAllObjects];
        for (NSDictionary *dict in postDictionaries)
        {
            Post *p = [[Post alloc] initWithDictionary:dict];
            [self.posts addObject:p];
        }
    }
    
    [self performSelectorOnMainThread:@selector(doneReloadingPosts:) withObject:sender waitUntilDone:NO];
}

- (void) doneReloadingPosts:(id)sender
{
    UIRefreshControl *refreshController = (UIRefreshControl *)sender;
    [self.tView reloadData];
    [refreshController endRefreshing];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Post *post = [self.posts objectAtIndex:[indexPath row]];
    NSString *text = post.message;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH , 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
    
    
    CGFloat height = MAX(size.height, 25.0f);
    
    return height + (SINGLE_LINE_HEIGHT * 2) + (CELL_MARGIN) + 5;
}


#pragma mark UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    UILabel *topLabel = nil;
    UILabel *middleLabel = nil;
    UILabel *bottomLabel = nil;
    
    FBProfilePictureView *picView = nil;
    Post *post = [self.posts objectAtIndex:indexPath.row];
    Person *poster = (Person *)[self.roommates objectForKey:post.posterId];
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        topLabel    = [self createLabelWithTag:LABEL_TOP_TAG];
        middleLabel = [self createLabelWithTag:LABEL_MIDDLE_TAG];
        bottomLabel = [self createLabelWithTag:LABEL_BOTTOM_TAG];
        
        [[cell contentView] addSubview:topLabel];
        [[cell contentView] addSubview:middleLabel];
        [[cell contentView] addSubview:bottomLabel];
        
         picView = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [picView setTag:PIC_TAG];
        [[cell contentView] addSubview:picView];
        
    }
    
    NSString *text = post.message;
    
    //Not what we want, need uneven margins
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_LEFT_MARGIN), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    if(!topLabel)
        topLabel    = (UILabel*)[cell viewWithTag:LABEL_TOP_TAG];
    
    if(!middleLabel)
        middleLabel = (UILabel*)[cell viewWithTag:LABEL_MIDDLE_TAG];
    
    if(!bottomLabel)
        bottomLabel = (UILabel*)[cell viewWithTag:LABEL_BOTTOM_TAG];
    
    if(!picView)
        picView = (FBProfilePictureView*)[cell viewWithTag:PIC_TAG];
    
    NSString *topLabelText = [post formatTopLabel];
    [topLabel setText:topLabelText];
    [topLabel setFrame:CGRectMake(CELL_CONTENT_LEFT_MARGIN, 10, CELL_CONTENT_WIDTH, SINGLE_LINE_HEIGHT)];
    [topLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    //[topLabel sizeToFit];
    
    
    [middleLabel setText:text];
    [middleLabel setFrame:CGRectMake(CELL_CONTENT_LEFT_MARGIN, 29, CELL_CONTENT_WIDTH, MAX(size.height, 44.0f))];
    [middleLabel sizeToFit];
    
    [bottomLabel setText:[post formatDate]];
    [bottomLabel setTextColor:[UIColor grayColor]];
    [bottomLabel setFrame:CGRectMake(CELL_CONTENT_LEFT_MARGIN, (34 + middleLabel.frame.size.height), CELL_CONTENT_WIDTH, SINGLE_LINE_HEIGHT)];
    //[bottomLabel sizeToFit];
    
    picView.profileID = poster.fb_id;
    
    return cell;
}

- (UILabel *) createLabelWithTag:(NSInteger)tag
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [label setMinimumScaleFactor:0];
    [label setNumberOfLines:0];
    
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [label setTag:tag];
    [label setBackgroundColor:[UIColor clearColor]];
    
//    label.layer.borderColor = [UIColor greenColor].CGColor;
//    label.layer.borderWidth = 1.0;
    
    return label;
}



@end
