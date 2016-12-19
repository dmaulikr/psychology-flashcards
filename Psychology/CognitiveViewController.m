//
//  CognitiveViewController.m
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//

#import "CognitiveViewController.h"

@interface CognitiveViewController ()

@end

@implementation CognitiveViewController

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
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    
    backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 380)];
    [text setUserInteractionEnabled:NO];
    [text setText:@"Principles of the Cognitive Level of Analysis"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 400, 100, 40)];
    [button setTitle:@"Continue" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(mainPage) forControlEvents:UIControlEventTouchUpInside];
    
    principles = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [principles addSubview:text];
    [principles addSubview:button];
    [self.view addSubview:principles];
    
    //insert at index 0
    
    UIButton *study = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [study setFrame:CGRectMake(100, 200, 100, 40)];
    [study setTitle:@"Study" forState:UIControlStateNormal];
    [study addTarget:self action:@selector(beginStudying) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *quiz = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [quiz setFrame:CGRectMake(100, 300, 100, 40)];
    [quiz setTitle:@"Quiz" forState:UIControlStateNormal];
    [quiz addTarget:self action:@selector(beginQuiz) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:study atIndex:0];
    [self.view insertSubview:quiz atIndex:0];

}

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)mainPage{
    [principles removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)beginStudying{
    
}

-(void)beginQuiz{
    //ALLOW USER TO CHOOSE QUIZ SETTINGS.. IF CATEGORY = -1, THEN DO ALL!
    
    /*Categories
     -1 = all
     0 = people
     1 = theories
     2 = drugs
     3 = parts of the brain
     4 = disorders
     5 = vocab
     */
    
    QuizViewController *quizViewController = [[QuizViewController alloc]initWithLevelOfAnalysis:1];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:quizViewController];
    UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 436, 320, 44)];
    [bottomBar setBarStyle:UIBarStyleDefault];
    [navController.view addSubview:bottomBar];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
