//
//  NumericCell.h
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"

@interface NumericCell : UITableViewCell
{
    MyTextField *myTextField;
}

@property (nonatomic, strong)MyTextField *myTextField;

- (void)configure;

@end
