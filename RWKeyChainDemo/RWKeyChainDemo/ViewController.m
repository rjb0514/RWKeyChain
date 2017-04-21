//
//  ViewController.m
//  RWKeyChainDemo
//
//  Created by ru on 2017/4/21.
//  Copyright © 2017年 GMJK. All rights reserved.
//

#import "ViewController.h"
#import "RWKeyChain.h"

#define saveKey @"rwPassword"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *saveTextField;
@property (weak, nonatomic) IBOutlet UITextField *readTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

/** 读取按钮 */
- (IBAction)readButton:(UIButton *)sender {
    
    NSString *str = [RWKeyChain rw_readDataForKey:saveKey];
    
    
    self.readTextField.text = str;
    
    
    
}


/** 存储 */
- (IBAction)saveButton:(UIButton *)sender {
    
    if (self.saveTextField.text.length) {
        
        [RWKeyChain rw_saveData:self.saveTextField.text ForKey:saveKey];
    }
    
}

@end
