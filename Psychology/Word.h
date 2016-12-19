//
//  Word.h
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

@property (nonatomic) NSString *wordTitle;
@property (nonatomic) NSString *wordDefinition;
@property (nonatomic) BOOL isKnown;

-(id)initWithTitle:(NSString*)t definition:(NSString*)d;
@end
