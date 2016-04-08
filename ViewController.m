//
//  ViewController.m
//  RobotControl
//
//  Created by Aaron Brodney on 3/18/16.
//  Copyright © 2016 Aaron Brodney. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

const NSString *myAppVersion = @"1.0.2";

const NSString *myIpAddress = @"10.7.1.201";

@synthesize  restartButton, currentSpeed, currentDuration;

@synthesize speedSelect, durationSelect, setDefaultsButton, lockButton;

@synthesize appVersionLabel, safetyMode, shortTurns, justReboted;

- (void)updateRobotSettingsFromApp
{
    [self updateRobotSpeed:nil];
    [self updateRobotDuration:nil];
    [self shortTurnsSwitchPressed:nil];
    
}

- (void)selectInterfaceDefaults
{
    [speedSelect setSelectedSegmentIndex:2];
    [durationSelect setSelectedSegmentIndex:1];
    
    [appVersionLabel setText:(NSString *)myAppVersion];
    
    safetyMode = FALSE;
    
}

- (NSString *)returnCurrentIpAddress
{
    return (NSString *)myIpAddress;
}

- (IBAction)shortTurnsSwitchPressed:(id) sender
{
    bool currentState = [shortTurns isOn];
    
     NSString *urlString = @"";
    
    if ( currentState == TRUE )
    {
        urlString = [NSString stringWithFormat:@"http://%@/%@", myIpAddress, @"shortTurns"];
        
        NSLog(@"short turns on");
    
    } else {
        urlString = [NSString stringWithFormat:@"http://%@/%@", myIpAddress, @"regularTurns"];
        
        NSLog(@"regular turns on");
    }
    
    [self getDataFrom:urlString];
    
    return;
}



- (IBAction)resetRobotButtonPressed:(id) sender
{
    NSString *urlString = [NSString stringWithFormat:@"http://%@/%@", myIpAddress, @"restart"];
    
    NSLog(@"user has requested MCU restart on robot");
    
    [self getDataFrom:urlString];
    return;
}


// reset to default settings on the robot's mcu
- (IBAction)setDefaultsButtonPressed:(id) sender
{
    

    NSString *urlString = [NSString stringWithFormat:@"http://%@/%@", myIpAddress, @"defaults"];
    
    [self getDataFrom:urlString];
    
    // [self selectInterfaceDefaults];
    
    return;
}


- (IBAction)updateRobotSpeed:(id) sender
{
    
    NSInteger value = [speedSelect selectedSegmentIndex];
    
    NSString *commandToUse = @"";
    
    if ( value == 0 )
        commandToUse = @"speedSlow";
    if ( value == 1 )
        commandToUse = @"mediumSpeed";
    if ( value == 2)
        commandToUse = @"normalSpeed";
    if ( value == 3 )
        commandToUse = @"highSpeed";
    if ( value == 4 ) // this is hidden for the moment as it could damage the motor gears
        commandToUse = @"fullSpeed";
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/%@", myIpAddress, commandToUse];
    
    NSLog(@"calling URL string from %@: %@", urlString, commandToUse);
    
    [self getDataFrom:urlString];
    
    return;
}

- (IBAction)updateRobotDuration:(id) sender
{
    NSInteger value = [durationSelect selectedSegmentIndex];
    
    NSString *commandToUse = @"";
    
    if ( value == 0 )
            commandToUse = @"shortDuration";
    if ( value == 1 )
            commandToUse = @"normalDuration";
    if ( value == 2 )
            commandToUse = @"longDuration";
    if ( value == 3 )
            commandToUse = @"veryLong";
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/%@", myIpAddress, commandToUse];
    
    NSLog(@"calling URL string from %@: %@", urlString, commandToUse);
    
    
    [self getDataFrom:urlString];
        
    return;
}


- (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    [request setTimeoutInterval:2];

    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}



- (IBAction)forwardButtonPress:(id) sender {
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/forward", myIpAddress];
    
    NSLog(@"calling URL string from forwardButtonPress: %@", urlString);
    
    [self getDataFrom:urlString];
    
}

- (IBAction)backwardButtonPress:(id)sender
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/backward", myIpAddress];
    
    NSLog(@"calling URL string from backwardButtonPress: %@", urlString);
    
    [self getDataFrom:urlString];
    
}

- (IBAction)rightButtonPress:(id) sender
{
    NSString *urlString = [NSString stringWithFormat:@"http://%@/right", myIpAddress];
    
    [self getDataFrom:urlString];
    
}

- (IBAction)leftButtonPress:(id) sender
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/left", myIpAddress];
    [self getDataFrom:urlString];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectInterfaceDefaults];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
