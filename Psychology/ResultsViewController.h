//
//  ResultsViewController.h
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@interface ResultsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    UITableView *resultsTable;
    NSMutableArray *resultsArray;
}

-(id)initWithResultsArray:(NSMutableArray*)r;

@end
