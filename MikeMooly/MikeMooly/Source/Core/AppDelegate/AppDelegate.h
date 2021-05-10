#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "FCZipArchive.h"

@class RootViewController;
@class FCDataManager;
@class FCGameManager;
@class FCEncryption;
@class FCGameCenterManager;

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
	RootViewController *viewController;
    
    CCLayer *m_pActionLayer;
    CCLayer *m_pHudLayer;
    CCLayer *m_pStageSelectLayer;
    
    FCGameCenterManager *m_pGameCenterManager;
    FCDataManager *m_pDataManager;
    FCGameManager *m_pGameManager;
    FCEncryption  *m_pEncryption;
    //FCZipArchive  *m_pZipArchive;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

-(void)SetActionLayer:(CCLayer*)pActionLayer;
-(void)SetHudLayer:(CCLayer*)pHudLayer;
-(CCLayer* )GetActionLayer;
-(CCLayer* )GetHudLayer;
-(CCLayer*) GetStageSelectLayer;

-(FCDataManager*)GetDataManager;
-(FCGameManager*)GetGameManager;
-(FCGameCenterManager*)GetGameCenterManager;
-(FCEncryption*)GetEncryption;

-(void) PageChange:(int) nPage;
-(void) SetState:(int) nState;
-(int) GetStageSelectPage;
//-(FCZipArchive*) GetZipArchive;

@end
