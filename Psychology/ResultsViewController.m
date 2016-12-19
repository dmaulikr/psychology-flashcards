//
//  ResultsViewController.m
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//


#import "ResultsViewController.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithResultsArray:(NSMutableArray*)r{
    resultsArray = r;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    resultsTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 380)]; //fix this!
    [resultsTable setDelegate:self];
    [resultsTable setDataSource:self];
    [self.view addSubview:resultsTable];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1; //number of sections in table
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [resultsArray count];//returns number of rows, usually number of items in an array
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Word *currentWord = [resultsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = currentWord.wordTitle;
    //then allow user to click on unknown items and show detailed view!
    if (!currentWord.isKnown) {
        cell.textLabel.textColor = [UIColor redColor];
    } else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //send user to item detail controller to see specific information
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
