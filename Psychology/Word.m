//
//  Word.m
//  Psychology
//
//  Created by Kyla Bouldin on 4/23/13.
//  Copyright (c) 2013 Kyla Bouldin. All rights reserved.
//

#import "Word.h"

@implementation Word
@synthesize wordTitle, wordDefinition, isKnown;

-(id)initWithTitle:(NSString*)t definition:(NSString*)d{
    wordTitle = t;
    wordDefinition = d;
    isKnown = NO;
    return self;
}

@end
