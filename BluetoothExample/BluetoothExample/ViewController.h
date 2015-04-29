//
//  ViewController.h
//  BluetoothExample
//
//  Created by Mussayev Temirulan Zamirbekovich on 4/2/15.
//  Copyright (c) 2015 Mussayev Temirulan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController {
    GKSession *currentSession;
    IBOutlet UITextField *txtMessage;
    IBOutlet UIButton *connect;
    IBOutlet UIButton *disconnect;
}
    @property (nonatomic, retain) GKSession *currentSession;
    @property (nonatomic, retain) UITextField *txtMessage;
    @property (nonatomic, retain) UIButton *connect;
    @property (nonatomic, retain) UIButton *disconnect;
    -(IBAction) btnSend:(id) sender;
    -(IBAction) btnConnect:(id) sender;
    -(IBAction) btnDisconnect:(id) sender;

@end

