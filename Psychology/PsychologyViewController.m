//
//  PsychologyViewController.m
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//

#import "PsychologyViewController.h"

@interface PsychologyViewController ()

@end

@implementation PsychologyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loadBioLOA:(id)sender {
    bioViewController = [[BiologicalViewController alloc]initWithNibName:@"BiologicalViewController" bundle:nil];
    UINavigationController *bioNavBar = [[UINavigationController alloc]initWithRootViewController:bioViewController];
    [self presentViewController:bioNavBar animated:YES completion:nil];
}


- (IBAction)loadCogLOA:(id)sender {
    cogViewController = [[CognitiveViewController alloc]initWithNibName:@"CognitiveViewController" bundle:nil];
    UINavigationController *cogNavBar = [[UINavigationController alloc]initWithRootViewController:cogViewController];
    [self presentViewController:cogNavBar animated:YES completion:nil];
}


- (IBAction)loadSocioLOA:(id)sender {
    socioViewController = [[SocioCulturalViewController alloc]initWithNibName:@"SocioCulturalViewController" bundle:nil];
    UINavigationController *socioNavBar = [[UINavigationController alloc]initWithRootViewController:socioViewController];
    [self presentViewController:socioNavBar animated:YES completion:nil];
}

- (IBAction)loadAboutScreen:(id)sender {
    NSLog(@"Flip to show about information");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
