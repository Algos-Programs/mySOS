//
//  NumericCell.m
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import "NumericCell.h"

@implementation NumericCell
@synthesize myTextField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureMyTextField {
    self.myTextField = [[MyTextField alloc] initWithFrame:CGRectMake(10, 2, 300, 40)];
    [self.myTextField setTextAlignment:NSTextAlignmentCenter];
    [self.myTextField setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.myTextField];
}

- (void)configure {
    [self configureMyTextField];
}


@end
