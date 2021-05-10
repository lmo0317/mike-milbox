//
//  AppDelegate.h
//  convert_tool
//
//  Created by minoh lee on 12. 5. 10..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FCEncryption;
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    FCEncryption  *m_pEncryption;
}

@property (assign) IBOutlet NSWindow *window;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
