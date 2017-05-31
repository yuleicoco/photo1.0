//
//  AppDelegate.h
//  rahmen
//
//  Created by yulei on 17/5/19.
//  Copyright © 2017年 yulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MainTabViewController.h"
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MainTabViewController* mainTabVC;
@property (nonatomic, strong) LoginViewController *loginVC;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

