#import "FCUINamePanelWindow.h"
#import "AppDelegate.h"
#import "HUDLayer.h"
#import "ActionLayer.h"

@implementation FCUINamePanelWindow

-(void) CreateScorePanel:(int) nX y:(int) nY z:(int) nZ score:(int) nScore
{
    
    NSString* pFntFile = @"dunkin_9.fnt";
    NSString* pDefault = [NSString stringWithFormat:@"%d",nScore];
    
    const float fAnchorX = 0;
    const float fAnchorY = 0;
    
    const int nR = 255;
    const int nG = 255;
    const int nB = 255;
        
    CCLabelBMFont* pLabelBMFont = [CCLabelBMFont labelWithString:pDefault fntFile:pFntFile];
    
    pLabelBMFont.position = ccp(nX, nY);
    pLabelBMFont.anchorPoint = ccp(fAnchorX, fAnchorY);
    pLabelBMFont.color = ccc3(nR,nG,nB);
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
    [pActionLayer addChild:pLabelBMFont z:nZ];
    
    id move = [CCMoveBy actionWithDuration:1 position:ccp(0,100)];
    id fadeout = [CCFadeOut actionWithDuration:1];
    id spawn = [CCSpawn actions:move,fadeout,nil];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(EndEvent:)];
    [pLabelBMFont runAction:[CCSequence actions:spawn, actionMoveDone, nil]];
}

-(void) EndEvent:(id)sender 
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
    
    CCLabelBMFont* pLabelBMFont = (CCLabelBMFont*) sender;
    [pActionLayer removeChild:pLabelBMFont cleanup:TRUE];
}

@end