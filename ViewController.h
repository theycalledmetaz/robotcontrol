//
//  ViewController.h
//  RobotControl
//
//  Created by Aaron Brodney on 3/18/16.
//  Copyright © 2016 Aaron Brodney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UISegmentedControl *speedSelect;
    
    IBOutlet UISegmentedControl *durationSelect;
    
    IBOutlet UIButton *setDefaultsButton;
    
    IBOutlet UIButton *restartButton;
    
    IBOutlet UIButton *lockButton;
    
    IBOutlet UILabel *appVersionLabel;
    
    IBOutlet UISwitch *shortTurns;
    
    
    NSInteger currentSpeed;
    NSInteger currentDuration;
    
    bool safetyMode;
    
    bool justRebooted;

}

@property (assign) NSInteger currentSpeed;
@property (assign) NSInteger currentDuration;

@property (assign) bool safetyMode;
@property (assign) bool justReboted;

@property (nonatomic, retain) IBOutlet UISwitch *shortTurns;
@property (nonatomic, retain) IBOutlet UIButton *lockButton;
@property (nonatomic, retain) IBOutlet UIButton *restartButton;
@property (nonatomic, retain) IBOutlet UIButton *setDefaultsButton;
@property (nonatomic, retain) IBOutlet UILabel *appVersionLabel;

@property (nonatomic, retain) IBOutlet UISegmentedControl *speedSelect;
@property (nonatomic, retain) IBOutlet UISegmentedControl *durationSelect;


- (NSString *) getDataFrom:(NSString *)url;
- (NSString *)returnCurrentIpAddress;
- (IBAction)leftButtonPress:(id) sender;
- (IBAction)rightButtonPress:(id) sender;
- (IBAction)backwardButtonPress:(id)sender;
- (IBAction)forwardButtonPress:(id)sender;
- (IBAction)resetRobotButtonPressed:(id) sender;
- (IBAction)shortTurnsSwitchPressed:(id) sender;

- (void)updateRobotSettingsFromApp;
- (void)selectInterfaceDefaults;

@end

