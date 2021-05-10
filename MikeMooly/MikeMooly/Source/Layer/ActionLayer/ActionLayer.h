
#import "CCLayerBase.h"
#import "MyLevelHelperLoader.h"
#import "HUDLayer.h"
#import "GLES-Render.h"
#import "FCPlayer.h"
#import "FCBlock.h"
#import "FCEnemy.h"
#import "FCPlatForm.h"
#import "FCFieldItem.h"
#import "FCShoot.h"
#import "FCHitBox.h"
#import "FCDataManager.h"
#import "FCGameMain.h"
#import "ActionLayerDef.h"

@class PASoundSource;
@interface ActionLayer : CCLayerBase 
{
    b2World * _world;
    b2ContactListener * _contactListener;
    GLESDebugDraw *m_debugDraw;
    MyLevelHelperLoader * _lhelper;
    LHParallaxNode* parallaxNode;
    FCGameMain m_GameMain;
    
    HUDLayer * _hud;    
    float m_fInitialDistance;
    CGPoint prevLocation;
}

+(id)scene:(NSString*) Name;
-(id)initWithHUD:(HUDLayer *)hud name:(NSString*)Name;

-(void)OpenPausedWindow;
-(void)ClosePausedWindow;
-(void)SetDebugDraw;
-(void)beginContact:(b2Contact *)contact;
-(void)endContact:(b2Contact *)contact;
-(void)CreateSprite:(LHSprite*) pSprite;
-(void)CreateSpriteReserve:(LHSprite*) pSprite;
-(void)CreateSpriteInLevel;
-(void)InitGameMain:(HUDLayer *)hud name:(NSString*)Name;
-(void)SaveData;
-(void)OpenSaveWorldData:(NSString*) strMapName;
-(void)update:(ccTime) dt;

-(b2World*)GetWorld;
-(FCGameMain*) GetGameMain;

@end