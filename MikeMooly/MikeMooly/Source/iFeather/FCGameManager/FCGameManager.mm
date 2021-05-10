#import "FCGameManager.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "HUDLayer.h"

@implementation FCGameManager

-(void) Init
{
    m_nLoadingState = 0;
    m_bCheckPoint = false;
    m_nStageSelectPage = 1;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCOptionDataManager* pOptionDataManager = [pDataManager GetOptionDataManager];
    
    FCOptionData* pOptionData = pOptionDataManager->GetOptionData(@"option_00");
    if(pOptionData == NULL)
        return;
    
    const bool bBGM = pOptionData->GetBGM();
    const bool bFX  = pOptionData->GetFX();
    const int  nControl = pOptionData->GetControl();
    
    if(bBGM) {
        m_fBGVolume = 0.5;
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:m_fBGVolume];
    }
    else {
        m_fBGVolume = 0.0;
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:m_fBGVolume];
    }
    
    if(bFX) {
        m_fFXVolume = 1.0;
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:m_fFXVolume];
    }
    else {
        m_fFXVolume = 0.0;
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:m_fFXVolume];
    }
    
    [self SetControlType:nControl];
}

-(void)InputStick:(CGPoint) velocity
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    pGameMain->InputStick(velocity);
}

-(void)InputJump
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    pGameMain->InputJump();
}

-(void) WorldChange:(NSString*) strWorldName
{
    m_bCheckPoint = false;
    if(m_nLoadingState == LOADING_STATE_FADE_IN)
        return;
    
    [self StartLoadWorldEvent:strWorldName];
}

-(void) RestartGame
{
    if(m_nLoadingState == LOADING_STATE_FADE_IN)
        return;

    [self StartLoadWorldEvent:m_strWorldName];
}

-(void) StartLoadWorldEvent:(NSString*) strWorldName
{
    m_nLoadingState = LOADING_STATE_FADE_IN;
    
    m_strWorldName = strWorldName;
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);    
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    if(pGameMain)
    {
        pGameMain->GameEnd();
    }
    
    [self FadeIn];
}

-(void) MoveToEventBoxPosition:(NSString*) strEventBoxPosition
{
    m_nPortalState = PORTAL_STATE_FADE_IN;
    m_strEventBoxPosition = strEventBoxPosition;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    pGameMain->PlayPortalSound();
    
    [pActionLayer pauseSchedulerAndActions];
    [self FadeIn];
}

-(void) LoadWorld:(NSString*) strWorldName
{
    //가장 최근에 로딩한 게임 월드 저장
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCWorldDataManager* pWorldDataManager = [pDataManager GetWorldDataManager];
    FCWorldData* pWorldData = pWorldDataManager->GetWorldData(strWorldName);
    if(pWorldData)
    {
        if([pWorldData->GetType() isEqualToString:@"GAME"])
        {
            m_strGameWorld = strWorldName;
        }
        else if([pWorldData->GetType() isEqualToString:@"TITLE"])
        {
            m_strGameWorld = @"";
        }
    }
    
    //월드 로딩 할떄 체크 포인트가 없을경우 체크 포인트 정보 초기화
    if(m_bCheckPoint == false)
    {
        [self ClearCheckPointInfo];
    }
    
    CCScene *scene = [ActionLayer scene:strWorldName];
    [[CCDirector sharedDirector] replaceScene:scene];
}

-(int) GetLoadingState
{
    return m_nLoadingState;
}

-(int) GetPortalState
{
    return m_nPortalState;
}

-(void) Death
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pLocalPlayer = pGameMain->GetLocalPlayer();
    
    int nLife = pLocalPlayer->GetLife();
    nLife -= 1;
    pLocalPlayer->SetLife(nLife);
    
    if(nLife <= 0)
    {
        pLocalPlayer->SetLife(nLife);
        [pActionLayer SaveData];
        
        //continue 카운트가 있으면 continue 없으면 게임 오버
        if(pGameMain->GetContinueCount()) {
            [self WorldChange:@"continue"];
        }
        else {
            [self WorldChange:@"gameover"];
        }
    }
    else
    {
        pLocalPlayer->SetLife(nLife);
        [pActionLayer SaveData];
        [self RestartGame];
    }
}

-(void) StageClear:(NSString*) strNextStage
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    HUDLayer* pHudLayer = (HUDLayer*)([appDelegate GetHudLayer]);
    
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    if(pWindowManager->GetShow(@"StageClearWindow"))
    {
        return;
    }
    
    if(pPlayer->GetState() != STATE_DEATH)
    {
        m_bCheckPoint = false;
        
        pGameMain->SetStageClear(true);
        
        [pHudLayer SetShowJoy:false];
        [pHudLayer SetShowButton:false];
        
        pWindowManager->SetShow(@"StageClearWindow",true);
        FCUIStageClearWindow* pStageClearWindow = pWindowManager->GetStageClearWindow();
        pStageClearWindow->SetNextStage(strNextStage);
        
        CCLOG(@"NEXT STAGE = [%@]",strNextStage);
        
        [self MissionCheck];
        [self LockWorld];
        [pActionLayer OpenSaveWorldData:strNextStage];
    }    
}

-(void) MissionCheck
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCWorldDataManager* pWorldDataManager = [pDataManager GetWorldDataManager];
    FCWorldData* pCurrentWorldData = pWorldDataManager->GetWorldData(m_strWorldName);
    
    if(pCurrentWorldData == NULL)
        return;
    
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCUIStageClearWindow* pStageClearWindow = pWindowManager->GetStageClearWindow();
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    
    FCSaveWorldData* pSaveWorldData = pSaveData->GetSaveWorldData(m_strWorldName);
    if(pSaveWorldData == NULL)
        return;

    int nMissionClearCount = 0;    
    int nMissionTime = pCurrentWorldData->GetMissionTime();
    int nMissionDamage = pCurrentWorldData->GetMissionDamage();
    
    int nCurrentTime = pGameMain->GetCurTime();
    int nStageDamage = pGameMain->GetStageDamage();
    
    if(nCurrentTime < nMissionTime)
    {
        pSaveWorldData->SetMissionTime(true);
        pStageClearWindow->SetStarShow(0,true);
        nMissionClearCount++;
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //mission item check
    //3개다 있을경우에만 저장한다
    if(pGameMain->GetMissionItem(0) && pGameMain->GetMissionItem(1) && pGameMain->GetMissionItem(2))
    {
        pSaveWorldData->SetMissionItem(true);
        pStageClearWindow->SetStarShow(1,true);
        nMissionClearCount++; 
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    if(nStageDamage <= nMissionDamage)
    {
        pSaveWorldData->SetMissionDamage(true);
        pStageClearWindow->SetStarShow(2,true);
        nMissionClearCount++;
    }
    
    if(nMissionClearCount == 0)
    {
        pStageClearWindow->SetMessageString(@"Good!");
    }
    else if(nMissionClearCount == 1)
    {
        pStageClearWindow->SetMessageString(@"Well Done!");
    }
    else if(nMissionClearCount == 2)
    {
        pStageClearWindow->SetMessageString(@"You Did It!!");
    }
    else if(nMissionClearCount == 3)
    {
        pStageClearWindow->SetMessageString(@"Super Awesome!!!");
    }
}

-(void) DeleteSaveDataScore:(NSString*) strSlotName
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    FCSaveDataParser* pSaveDataParser = [pDataManager GetSaveDataParser];
    
    FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
    FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSlotName);
    
    pSaveData->SetCoin(0);
    pSaveData->SetContinueCount(pDefaultData->GetContinueCount());
    pSaveData->SetHP(pDefaultData->GetHP());
    pSaveData->SetLife(pDefaultData->GetLife());
    pSaveData->SetScore(0);
    
    //world 정보 초기화
    pSaveDataParser->SaveSaveData();
}

-(void) DeleteSaveData:(NSString*) strSlotName
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    FCSaveDataParser* pSaveDataParser = [pDataManager GetSaveDataParser];
    
    FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
    FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSlotName);
    
    pSaveData->SetCoin(0);
    pSaveData->SetContinueCount(pDefaultData->GetContinueCount());
    pSaveData->SetHP(pDefaultData->GetHP());
    pSaveData->SetLife(pDefaultData->GetLife());
    pSaveData->SetScore(0);
    
    FCSaveWorldDataManager* pSaveWorldDataManager = pSaveData->GetSaveWorldDataManager();
    pSaveWorldDataManager->ClearSaveWorldData();
    
    //world 정보 초기화
    pSaveDataParser->SaveSaveData();
}

-(void) LockWorld
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCWorldDataManager* pWorldDataManager = [pDataManager GetWorldDataManager];
    FCWorldData* pCurrentWorldData = pWorldDataManager->GetWorldData(m_strWorldName);
    
    if(pCurrentWorldData == NULL)
        return;
    
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    
    if(pCurrentWorldData->GetGroupEnd())
    {
        NSString* strCurrentGroup = pCurrentWorldData->GetGroup();        
        if(strCurrentGroup == NULL)
            return;
        
        std::map<NSInteger ,FCWorldData*>* mapWorldData = pWorldDataManager->GetWorldDatMap(); 
        std::map<NSInteger ,FCWorldData*>::iterator it = mapWorldData->begin();
        for(;it != mapWorldData->end();++it)
        {
            FCWorldData* pWorldData = it->second;
            NSString* strGroup = pWorldData->GetGroup();
            
            if(strGroup == NULL)
                continue;
            
            if([strGroup isEqualToString:strCurrentGroup])
            {
                FCSaveWorldData* pSaveWorldData = pSaveData->GetSaveWorldData(pWorldData->GetName());
                if(pSaveWorldData)
                {
                    CCLOG(@"LOCK WORLD [%@]",pSaveWorldData->GetID());
                    pSaveWorldData->SetLock(true);
                }
                
            }
        }
    }
}


-(void) ClearUnLockWorld;
{
    //lock 되어 있지 않은 월드는 open을 해지한다
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];  
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    
    FCSaveWorldDataManager* pSaveWorldDataManager = pSaveData->GetSaveWorldDataManager();
    std::map<NSInteger,FCSaveWorldData*>* hashSaveWorldData = pSaveWorldDataManager->GetSaveWorldDataHash();
    std::map<NSInteger,FCSaveWorldData*>::iterator it = hashSaveWorldData->begin();
    for(;it != hashSaveWorldData->end();++it)
    {
        FCSaveWorldData* pSaveWorldData = (*it).second;
        
        FCDataManager* pDataManager = [appDelegate GetDataManager];    
        FCWorldDataManager* pWorldDataManager = [pDataManager GetWorldDataManager];
        FCWorldData* pWorldData = pWorldDataManager->GetWorldData(pSaveWorldData->GetID());
        
        //lock이 되어있지 않고 first 맵이 아닐경우
        if(pSaveWorldData->GetLock() == false)
        {
            if(pWorldData->GetGroupFirst() == false)
            {
                //그룹의 첫번째 는 열지 않음
                pSaveWorldData->SetOpen(false);
            }
            
            pSaveWorldData->SetMissionItem(false);
            pSaveWorldData->SetMissionTime(false);
            pSaveWorldData->SetMissionDamage(false);
        }
    }
}

-(void)SetCheckPoint:(bool)bCheckPoint
{
    m_bCheckPoint = bCheckPoint;
}

-(bool)GetCheckPoint
{
    return m_bCheckPoint;
}

-(void)SetStageSelectPage:(int)nPage
{
    m_nStageSelectPage = nPage;
}

-(int)GetStageSelectPage
{
    return m_nStageSelectPage;
}

-(NSString*)GetGameWorld
{
    return m_strGameWorld;
}

-(void)SetSaveSlot:(NSString*) strSaveSlot
{
    m_strSaveSlot = strSaveSlot;
}

-(NSString*)GetSaveSlot
{
    return m_strSaveSlot;
}

-(void) ResetContinueCount
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
    FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");    
    ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    pGameMain->SetContinueCount(pDefaultData->GetContinueCount());
}

-(void)ClearCheckPointInfo
{
    m_dCheckPointTime = 0;
    m_nCheckPointCoin = 0;
    m_nCheckPointDamage = 0;
    
    m_bCheckPointMissionItem[0] = false;
    m_bCheckPointMissionItem[1] = false;
    m_bCheckPointMissionItem[2] = false;
}

-(void)SetCheckPointTime:(ccTime) dCheckPointTime
{
    m_dCheckPointTime = dCheckPointTime;
}
-(void)SetCheckPointCoin:(int) nCheckPointCoin
{
    m_nCheckPointCoin = nCheckPointCoin;
}

-(void)SetCheckPointMissionItem:(int) nIndex set:(bool)bSet
{
    m_bCheckPointMissionItem[nIndex] = bSet;
}

-(void)SetCheckPointDamage:(int) nCheckPointDamage
{
    m_nCheckPointDamage = nCheckPointDamage;
}

-(ccTime)GetCheckPointTime
{
    return m_dCheckPointTime;
}
-(int)GetCheckPointCoin
{
    return m_nCheckPointCoin;
}
-(int)GetCheckPointDamage
{
    return m_nCheckPointDamage;
}

-(bool)GetCheckPointMissionItem:(int) nIndex
{
    return m_bCheckPointMissionItem[nIndex];
}

-(void) FadeIn
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    
    FCUISceneEventWindow* pSceneEventWindow = pWindowManager->GetSceneEventWindow();
    if(pSceneEventWindow)
    {
        pSceneEventWindow->SetShow(true);
        FCUIControl* pBlack = pSceneEventWindow->GetBlackControl();
        
        CCActionInterval *a = [CCSequence actions:
                               [CCFadeIn actionWithDuration:0.5],
                               [CCCallFunc actionWithTarget:self selector:@selector(FadeInEnd)],
                               nil ];
        
        [pBlack->GetSprite() runAction:a];
    }
}

-(void) FadeOut
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    
    FCUISceneEventWindow* pSceneEventWindow = pWindowManager->GetSceneEventWindow();
    if(pSceneEventWindow)
    {
        pSceneEventWindow->SetShow(true);
        FCUIControl* pBlack = pSceneEventWindow->GetBlackControl();
        
        CCActionInterval *a = [CCSequence actions:
                               [CCFadeOut actionWithDuration:0.5],
                               [CCCallFunc actionWithTarget:self selector:@selector(FadeOutEnd)],
                               nil ];
        
        [pBlack->GetSprite() runAction:a];
    }
}

-(void) FadeInEndLoading
{
    //CCLOG(@"WORLD NAME = [%@]",m_strWorldName);
    [self LoadWorld:m_strWorldName];
    [self FadeOut];
    
    m_nLoadingState = LOADING_STATE_FADE_OUT;    
}

-(void) FadeInEndPortal
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    if(pGameMain)
    {
        pGameMain->MoveToEventBoxPosition(m_strEventBoxPosition);
        [pActionLayer update:0];
    }
    
    [self FadeOut];
    m_nPortalState = PORTAL_STATE_FADE_OUT;
}

-(void) FadeInEnd
{
    if(m_nLoadingState == LOADING_STATE_FADE_IN)
    {
        [self FadeInEndLoading];
    }
    
    if(m_nPortalState == PORTAL_STATE_FADE_IN)
    {
        [self FadeInEndPortal];
    }
}

-(void) FadeOutEndLoading
{
    m_nLoadingState = LOADING_STATE_NONE;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    if(pGameMain)
    {
        pGameMain->GameStart();
    }        
}

-(void) FadeOutEndPortal
{
    m_nPortalState = PORTAL_STATE_NONE;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    [pActionLayer resumeSchedulerAndActions];
}

-(void) FadeOutEnd
{
    if(m_nLoadingState != LOADING_STATE_NONE)
    {
        [self FadeOutEndLoading];
    }
    
    if(m_nPortalState != PORTAL_STATE_NONE)
    {
        [self FadeOutEndPortal];
    }    
}

-(void)SetBGVolume:(float) fBGVolume
{
    m_fBGVolume = fBGVolume;
}
-(void)SetFXVolume:(float) fFXVolume
{
    m_fFXVolume = fFXVolume;
}

-(void)SetControlType:(int) nControlType
{
    m_nControlType = nControlType;
}

-(float)GetBGVolume
{
    return m_fBGVolume;
}
-(float)GetFXVolume
{
    return m_fFXVolume;
}
-(int) GetControlType
{
    return m_nControlType;
}

@end