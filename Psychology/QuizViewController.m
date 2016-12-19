//
//  QuizViewController.m
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController
@synthesize textbox, answerField, skipButton, pauseButton, submitButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithLevelOfAnalysis:(int)l{
    levelOfAnalysis = l;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    textbox.layer.borderWidth = 1.0f;
    textbox.layer.borderColor = [[UIColor grayColor]CGColor];
    
    
    //load words into array from level of analysis and category
    
    /*
     Word *word1 = [[Word alloc]initWithTitle:@"Selye" definition:@"General Adaptation Syndrome"];
     Word *word2 = [[Word alloc]initWithTitle:@"Marmont" definition:@"Whitehall Study"];
     Word *word3 = [[Word alloc]initWithTitle:@"Taylor" definition:@"Oxytocin"];
     listOfWords = [[NSMutableArray alloc]initWithObjects:word1, word2, word3, nil];
     
     */
    
    listOfWords = [[NSMutableArray alloc]init];
    
    NSString *LOAPath;
    switch (levelOfAnalysis) {
        case 0:
            LOAPath = @"BioData";
            break;
        case 1:
            LOAPath = @"CogData";
            break;
        case 2:
            LOAPath = @"SocioData";
            break;
        default:
            break;
    }
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:LOAPath ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    //start parsing at start game aka after categories are chosen
    
    
    //STEP ONE: CHOOSE CATEGORIES
    
    //fill array appropriately based on LOA
    switch (levelOfAnalysis) {
        case 0:
            categoryArray = [[NSMutableArray alloc]initWithObjects:@"People", @"Drugs", nil];
            break;
        case 1:
            categoryArray = [[NSMutableArray alloc]initWithObjects:@"People", @"Behaviors", nil];
            break;
        case 2:
            categoryArray = [[NSMutableArray alloc]initWithObjects:@"People", @"Culture", nil];
            break;
        default:
            break;
    }
    
    NSArray *array = [self.navigationController.view subviews];
    UIToolbar *bottomBar;
    for (int i = 0; i < [array count]; i++) {
        if ([[array objectAtIndex:i] isKindOfClass:[UIToolbar class]]) {
            bottomBar = [array objectAtIndex:i];
        }
    }

    categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    categoryTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [categoryTable setDataSource:self];
    [categoryTable setDelegate:self];
    [categoryView addSubview:categoryTable];

     
    UIBarButtonItem *finished = [[UIBarButtonItem alloc]initWithTitle:@"Start" style:UIBarButtonItemStyleBordered target:self action:@selector(startGame)];
    NSArray *barItems = [[NSArray alloc]initWithObjects:finished, nil];
    [bottomBar setItems:barItems];
    
    //create select all option
    cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    [self.view addSubview:categoryView];
    
    UIBarButtonItem *startButtomItem = [[UIBarButtonItem alloc]initWithTitle:@"Select All" style:UIBarButtonItemStyleBordered target:self action:@selector(selectAll)];
    self.navigationItem.rightBarButtonItem = startButtomItem;
}

#pragma mark - PARSER

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
//    NSLog(@"PARSING LOA:%i", levelOfAnalysis);

    NSString *LOAString;
    switch (levelOfAnalysis) {
        case 0:
            LOAString = @"BIOLOGICAL";
            break;
        case 1:
            LOAString = @"COGNITIVE";
            break;
        case 2:
            LOAString = @"SOCIOCULTURAL";
            break;
        default:
            break;
    }
        //add for loop to add multiple categories
        for (int i = 0; i < [categoriesChosen count]; i++) {
            NSIndexPath *currentPath = [categoriesChosen objectAtIndex:i];
            if ([elementName isEqualToString:LOAString] && [[attributeDict valueForKey:@"categoryNumber"]isEqualToString:[NSString stringWithFormat:@"%i",currentPath.row]]){
                NSLog(@"Adding Item");
                NSString *itemTitle = [attributeDict valueForKey:@"title"];
                NSString *itemDescription = [attributeDict valueForKey:@"miniDescription"];
                //if mini description is not avaliable.. then it shows nothing
                Word *newWord = [[Word alloc]initWithTitle:itemTitle definition:itemDescription];
                [listOfWords addObject:newWord];
            }
        }
/*
 TO STUDY ALL!
        if ([elementName isEqualToString:LOAString]){
            NSString *itemTitle = [attributeDict valueForKey:@"title"];
            NSString *itemDescription = [attributeDict valueForKey:@"miniDescription"];
            //if mini description is not avaliable.. then it shows nothing
            Word *newWord = [[Word alloc]initWithTitle:itemTitle definition:itemDescription];
            [listOfWords addObject:newWord];
        }

    }
 */

}

#pragma mark TABLEVIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1; //number of sections in table
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [categoryArray count];//returns number of rows, usually number of items in an array
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [categoryArray objectAtIndex:indexPath.row];
    
    if (selectAll) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else if (!selectAll){
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else if ([selectedCell accessoryType] == UITableViewCellAccessoryCheckmark) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)selectAll{
    //set a boolean to true and reload data!
    if (selectAll) {
        selectAll = false;
        [selectAllButtonItem setStyle:UIBarButtonItemStyleBordered];
    } else if (!selectAll){
        selectAll = true;
        [selectAllButtonItem setStyle:UIBarButtonItemStyleDone];
    }
    [categoryTable reloadData];
    
    
}

#pragma mark START GAME

-(void)nextQuestion{
    //clear answerField
    //set up next question
    
    
    [answerField setText:@""];
    //randomize questions
    if (counter < [listOfWords count]) {
        ///////////        //////CHANGE THIS!!!!!!!!            /////////////
        Word *currentWord = [listOfWords objectAtIndex:counter];
        [textbox setText:currentWord.wordDefinition];
    } else
        [self showResults];
}


-(void)startGame{
    counter = 0;
    //remove category view, get selected categories, show keyboard, remove uinaviationbar
    [categoryView removeFromSuperview];
    
    categoriesChosen = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[categoryArray count]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *aCell = (UITableViewCell*) [categoryTable cellForRowAtIndexPath:indexPath];
        if (aCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            [categoriesChosen addObject:indexPath];
        }
    }
    
    //parse categories
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
    NSLog(@"List of Words Count: %i", [listOfWords count]);
    
    
    //show keyboard
    [answerField becomeFirstResponder];
    answerField.returnKeyType = UIReturnKeyGo;
    
    //remove UINavContoller
    [self.navigationController setNavigationBarHidden:YES];
    
    if ([listOfWords count] > 0) {
        Word *currentWord = [listOfWords objectAtIndex:counter];
        [textbox setText:currentWord.wordDefinition];
    } else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)submitAnswer:(id)sender {
    Word *currentWord = [listOfWords objectAtIndex:counter];
    NSLog(@"Answer Submitted");
    
    
    //check answer!
    if ([currentWord.wordTitle rangeOfString:answerField.text options:NSCaseInsensitiveSearch].location == NSNotFound) {
        NSLog(@"Wrong");
    } else {
        NSLog(@"Correct Answer");
        [currentWord setIsKnown:YES];
    }
    
/*
    if ([answerField.text isEqualToString:currentWord.wordTitle]) {
        //or caseInsensitiveCompare:
        NSLog(@"Correct Answer!");
        [currentWord setIsKnown:YES];
    }
 */
    counter ++;
    [self nextQuestion];
}

-(void)showResults{
    ResultsViewController *results = [[ResultsViewController alloc]initWithResultsArray:listOfWords];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:results];
    UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 436, 320, 44)];
    [bottomBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *finished = [[UIBarButtonItem alloc]initWithTitle:@"Finished" style:UIBarButtonItemStyleBordered target:self action:@selector(finished)];
    NSArray *barItems = [[NSArray alloc]initWithObjects:finished, nil];
    [bottomBar setItems:barItems];
    [navController.view addSubview:bottomBar];
    [self presentViewController:navController animated:YES completion:nil];

    /*
    [answerField resignFirstResponder];
    NSLog(@"Unknowns");
    for (int i = 0; i < [listOfWords count]-1; i++) {
    Word *currentWord = [listOfWords objectAtIndex:i];
        if (!currentWord.isKnown) {
            NSLog(@"%@", currentWord.wordTitle);
        }
    }
     */
}

-(void)finished{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField == answerField) {
        [self submitAnswer:submitButton];
    }
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
