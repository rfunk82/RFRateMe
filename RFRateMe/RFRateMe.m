//
//  RFRateMe.m
//  RFRateMeDemo
//
//  Created by Ricardo Funk on 1/2/14.
//  Copyright (c) 2014 Ricardo Funk. All rights reserved.
//

#import "RFRateMe.h"
#import "UIAlertView+NSCookbook.h"

#pragma mark - Define dictionary keys

#define settingsKey     @"RFRateAlertSettings"
#define titleKey        @"RFRateAlertTitle"
#define messageKey      @"RFRateAlertMessage"
#define appStoreUrlKey  @"RFAppStoreApplicationURL"
#define numberOfDaysKey @"RFNumberOfDaysUntilShowing"
#define buttonsKey      @"RFRateAlertButtons"
#define cancelButtonKey @"RFCancelButtonTitle"
#define laterButtonKey  @"RFLaterButtonTitle"
#define rateButtonKey   @"RFRateButtonTitle"

#pragma mark - Implementation

@implementation RFRateMe

static NSDictionary *settingsDictionary;

+(void)showRateAlert {
    settingsDictionary = [self getSettingsDictionary];
    
    //If rate was completed, we just return if True
    BOOL rateCompleted = [[NSUserDefaults standardUserDefaults] boolForKey:@"RFRateCompleted"];
    if (rateCompleted) return;
    
    //Check if the user asked not to be prompted again for 3 days (remind me later)
    BOOL remindMeLater = [[NSUserDefaults standardUserDefaults] boolForKey:@"RFRemindMeLater"];
    
    if (remindMeLater) {
        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *start = [[NSUserDefaults standardUserDefaults] objectForKey:@"RFStartDate"];
        NSString *end = [DateFormatter stringFromDate:[NSDate date]];
        
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"yyyy-MM-dd"];
        NSDate *startDate = [f dateFromString:start];
        NSDate *endDate = [f dateFromString:end];
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:startDate
                                                              toDate:endDate
                                                             options:0];
        
        long numberOfDays = [settingsDictionary objectForKey:numberOfDaysKey] ? (long) [settingsDictionary objectForKey:numberOfDaysKey] : (long) 3;
        if ((long)[components day] <= numberOfDays) return;
        
    }
    
    //Show rate alert
    
    NSString *title = [settingsDictionary objectForKey:titleKey];
    NSString *message = [settingsDictionary objectForKey:messageKey];
    NSDictionary *buttons = [settingsDictionary objectForKey:buttonsKey];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:[buttons objectForKey:cancelButtonKey]
                                              otherButtonTitles:[buttons objectForKey:laterButtonKey], [buttons objectForKey:rateButtonKey], nil];
    
    [alertView showWithCompletion:^(UIAlertView *alertView, NSInteger buttonIndex) {
        
        switch (buttonIndex) {
            case 0:
                
                NSLog(@"No, thanks");
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RFRateCompleted"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                break;
            case 1:
                
                NSLog(@"Rate it now");
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RFRateCompleted"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[settingsDictionary objectForKey:appStoreUrlKey]]];
                
                break;
            case 2:
                
                NSLog(@"Remind me later");
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *now = [NSDate date];
                [[NSUserDefaults standardUserDefaults] setObject:[dateFormatter stringFromDate:now] forKey:@"RFStartDate"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RFRemindMeLater"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                break;
        }
    }];
}

+(void)showRateAlertAfterTimesOpened:(int)times {
    //Thanks @kylnew for feedback and idea!
    
    BOOL rateCompleted = [[NSUserDefaults standardUserDefaults] boolForKey:@"RFRateCompleted"];
    if (rateCompleted) return;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger timesOpened = [defaults integerForKey:@"timesOpened"];
    [defaults setInteger:timesOpened+1 forKey:@"timesOpened"];
    [defaults synchronize];
    NSLog(@"App has been opened %ld times", (long)[defaults integerForKey:@"timesOpened"]);
    if([defaults integerForKey:@"timesOpened"] >= times){
        [RFRateMe showRateAlert];
    }


}


+(void)showRateAlertAfterDays:(int)times {
    
    BOOL rateCompleted = [[NSUserDefaults standardUserDefaults] boolForKey:@"RFRateCompleted"];
    if (rateCompleted) return;
    
    BOOL showAfterXdays = [[NSUserDefaults standardUserDefaults] boolForKey:@"RFShowAfterXDays"];
    
    if (!showAfterXdays) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *now = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:[dateFormatter stringFromDate:now] forKey:@"RFGeneralStartDate"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RFShowAfterXDays"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *start = [[NSUserDefaults standardUserDefaults] objectForKey:@"RFGeneralStartDate"];
    NSString *end = [DateFormatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    
    if ((long)[components day] <= times) return;
    
    
}

#pragma mark - Settings Dictionary initializer

+(NSDictionary *)getSettingsDictionary {
    if (settingsDictionary) {
        return settingsDictionary;
    }
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:settingsKey];
}

@end
