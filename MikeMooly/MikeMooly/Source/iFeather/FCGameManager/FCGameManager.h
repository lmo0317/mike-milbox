#ifndef MikeMooly_FCGameManager_h
#define MikeMooly_FCGameManager_h

#import "FCGameManagerDef.h"

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"

@interface FCGameManager : NSObject 
{
    int  m_nLoadingState;
    int  m_nPortalState;
    int  m_nStageSelectPage;

    bool m_bCheckPoint;
    int  m_nCheckPointCoin;
    int  m_nCheckPointDamage;
    ccTime  m_dCheckPointTime;
    bool m_bCheckPointMissionItem[3];
    
    NSString* m_strWorldName;
    NSString* m_strEventBoxPosition;
    NSString* m_strGameWorld;
    NSString* m_strSaveSlot;
    
    float m_fBGVolume;
    float m_fFXVolume;
    int   m_nControlType;
};

-(void)Init;
-(void)StartLoadWorldEvent:(NSString*) strWorldName;
-(void)WorldChange:(NSString*) strWorldName;
-(void)LoadWorld:(NSString*) strWorldName;
-(void)RestartGame;
-(void)FadeInEnd;
-(void)FadeInEndLoading;
-(void)FadeInEndPortal;
-(void)FadeOutEnd;

-(void)InputStick:(CGPoint)veclocity;
-(void)InputJump;
-(void)Death;
-(void)StageClear:(NSString*)strNextStage;
-(void)SetCheckPoint:(bool)bCheckPoint;
-(void)SetCheckPointTime:(ccTime) dCheckPointTime;
-(void)SetCheckPointCoin:(int) nCheckPointCoin;
-(void)SetCheckPointMissionItem:(int) nIndex set:(bool)bSet;
-(void)SetCheckPointDamage:(int) nCheckPointDamage;
-(void)LockWorld;
-(void)MissionCheck;
-(void)SetStageSelectPage:(int) nPage;
-(void)SetSaveSlot:(NSString*) strSaveSlot;
-(void)ClearUnLockWorld;
-(void)ResetContinueCount;
-(void)DeleteSaveData:(NSString*) strSlotName;
-(void)DeleteSaveDataScore:(NSString*) strSlotName;
-(void)MoveToEventBoxPosition:(NSString*) strEventBoxPosition;

-(int)GetCheckPointCoin;
-(int)GetCheckPointDamage;
-(bool)GetCheckPointMissionItem:(int) nIndex;
-(int)GetLoadingState;
-(int)GetPortalState;
-(int)GetStageSelectPage;
-(bool)GetCheckPoint;

-(NSString*) GetGameWorld;
-(NSString*)GetSaveSlot;
-(ccTime)GetCheckPointTime;

-(void)SetBGVolume:(float) fBGVolume;
-(void)SetFXVolume:(float) fFXVolume;
-(void)SetControlType:(int) nControlType;

-(float)GetBGVolume;
-(float)GetFXVolume;
-(int)GetControlType;

-(void)ClearCheckPointInfo;

@end

#endif