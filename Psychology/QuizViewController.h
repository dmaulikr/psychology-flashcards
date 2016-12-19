//
//  QuizViewController.h
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Word.h"
#import "ResultsViewController.h"


//Begin With Category...
//Beware this can be bio, cog, or soocio..

//allow user to pick categories they want to be tested on...

@interface QuizViewController : UIViewController<UITextFieldDelegate, NSXMLParserDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listOfWords;
    int counter;
    int levelOfAnalysis;
    
    NSXMLParser *xmlParser;
    
    
    //UIView With List of Categories based on LOA chosen
    UIView *categoryView;
    UITableView *categoryTable;
    NSMutableArray *categoryArray;
    NSMutableArray *categoriesChosen;
    
    UIBarButtonItem *selectAllButtonItem;
    UIBarButtonItem *cancelButton;
    BOOL selectAll;
    
}
@property (weak, nonatomic) IBOutlet UITextView *textbox;
@property (weak, nonatomic) IBOutlet UITextField *answerField;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

-(id)initWithLevelOfAnalysis:(int)l;

@end
