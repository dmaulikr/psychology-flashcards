//
//  PsychologyViewController.h
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiologicalViewController.h"
#import "CognitiveViewController.h"
#import "SocioCulturalViewController.h"

@interface PsychologyViewController : UIViewController{
    BiologicalViewController *bioViewController;
    CognitiveViewController *cogViewController;
    SocioCulturalViewController *socioViewController;
}
@property (weak, nonatomic) IBOutlet UIButton *biologicalButton;

@property (weak, nonatomic) IBOutlet UIButton *cognitiveButton;

@property (weak, nonatomic) IBOutlet UIButton *socioculturalButton;

@property (weak, nonatomic) IBOutlet UIButton *aboutButton;

@end
