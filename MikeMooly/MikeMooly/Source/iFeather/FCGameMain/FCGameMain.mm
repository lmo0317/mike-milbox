#import "FCGameMain.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"

FCGameMain::FCGameMain():
m_pWindowManager(NULL),
m_bGameEnd(false),
m_bStageClear(false),
m_nContinueCount(0),
m_nStageCoin(0),
m_nStageDamage(0),
m_nClearTime(CLEAR_TIME_SOUND)
{
    
}

FCGameMain::~FCGameMain()
{
    Clear();
    delete m_pWindowManager;
}

void FCGameMain::Init(NSString* strWorldName,HUDLayer* pHudLayer)
{
    m_pHudLayer = pHudLayer;
    
    m_strWorldName = strWorldName;
    InitWorldData();
    
    m_pWindowManager = new FCUIWindowManager;
    m_pWindowManager->Init(m_pHudLayer);
    m_bGameEnd = false;
    m_bStageClear = false;
    
    m_dRemainTime = m_pWorldData->GetTime();
    InitGameMainData();
}

void FCGameMain::InitGameMainData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    if(strSaveSlot == NULL)
        return;
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    if(pSaveData == NULL)
        return;
    
    SetScore(pSaveData->GetScore());
    SetContinueCount(pSaveData->GetContinueCount());
    SetCoin(pSaveData->GetCoin());
}

void FCGameMain::GameEnd()
{
    m_bGameEnd = true;
}

void FCGameMain::GameStart()
{
    m_bGameEnd = false;
}

void FCGameMain::InitWorldData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCWorldDataManager* pWorldDataManager = [pDataManager GetWorldDataManager];
   
    FCWorldData* pWorldData = pWorldDataManager->GetWorldData(m_strWorldName);
    if(pWorldData == NULL)
    {
        //데이터 없을경우 default
        pWorldData = pWorldDataManager->GetWorldData(@"DEFAULT");
    }
    
    if(pWorldData)
    {
        InitWorldData(pWorldData);
    }
}

void FCGameMain::InitWorldData(FCWorldData* pWorldData)
{
    m_pWorldData = pWorldData;
}

void FCGameMain::Clear()
{    
    //CCLOG(@"CLEAR GAME MAIN");
    
    ObjectClear();
    m_vecCreateSpriteReserve.clear();
}


void FCGameMain::ReserveProcess(ccTime dt)
{
    std::vector<LHSprite*>::iterator it = m_vecCreateSpriteReserve.begin();
    for(;it != m_vecCreateSpriteReserve.end();++it)
    {
        LHSprite* pSprite = (*it);
        CreateSprite(pSprite);
    }
    
    m_vecCreateSpriteReserve.clear();
}

void FCGameMain::StageClearProcess(ccTime dt)
{  
    if(m_dRemainTime <= 0)
        return;

    m_dRemainTime -= TIME_WIEGHT;
    m_nClearTime += TIME_WIEGHT;

    if(m_dRemainTime <= 0)
    {
        m_dRemainTime = 0;
    }
    
    if(m_nClearTime >= CLEAR_TIME_SOUND)
    {
        PlayClearTimeSound();
        m_nClearTime = 0;
    }
    
    FCUIStageClearWindow* pStageClearWindow = m_pWindowManager->GetStageClearWindow();
    FCUIGameMainWindow* pGameMainWindow = m_pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetTime(m_dRemainTime);
    AddScoreMainWindow(10);
    
    if(m_dRemainTime <= 0)
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];  
        ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
        
        [pActionLayer SaveData];
        pStageClearWindow->EndAddScore();
    }
}

void FCGameMain::Process(ccTime dt)
{
    m_pWindowManager->Process(dt);

    if(m_bStageClear)
    {
        StageClearProcess(dt);
        return;
    }
    
    if(m_bGameEnd)
        return;
    
    m_dCurTime += dt;
    m_dRemainTime -= dt;
    
    if(m_dRemainTime >= 0)
    {
        FCUIGameMainWindow* pGameMainWindow = m_pWindowManager->GetGameMainWindow();
        pGameMainWindow->SetTime(m_dRemainTime);
    }
    
    ObjectProcess(dt);
    TimeCountCheck();
    ReserveProcess(dt);
}

void FCGameMain::CreateSpriteReserve(LHSprite* pSprite)
{
    m_vecCreateSpriteReserve.push_back(pSprite);
}

void FCGameMain::CreateSprite(LHSprite* pSprite)
{
    if(pSprite == nil)
        return;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
    
    [pActionLayer addChild:pSprite z:10 tag:[pSprite tag]];
    if(IsPlayer([pSprite tag]))
    {
        CreateLocalPlayerSprite(pSprite);
    }
    else if(IsEnemy([pSprite tag]))
    {
        CreateEnemySprite(pSprite);
    }
    else if(IsBlock([pSprite tag]))
    {
        CreateBlockSprite(pSprite);
    }
    else if(IsPlatForm([pSprite tag]))
    {
        CreatePlatFormSprite(pSprite);
    }
    else if(IsFieldItem([pSprite tag]))
    {
        CreateFieldItemSprite(pSprite);
    }
    else if(IsShoot([pSprite tag]))
    {
        CreateShootSprite(pSprite);
    }
    else if(IsHitData([pSprite tag]))
    {
        CreateHitDataSprite(pSprite);
    }
    else if(IsEventBoxPortal([pSprite tag]))
    {
        CreateEventBoxPortalSprite(pSprite);
    }
    else if(IsEventBoxPosition([pSprite tag]))
    {
        CreateEventBoxPositionSprite(pSprite);
    }
    else if(IsEventBoxStageClear([pSprite tag]))
    {
        CreateEventBoxStageClearSprite(pSprite);
    }
    else if(IsEventBoxCheckPoint([pSprite tag]))
    {
        CreateEventBoxCheckPointSprite(pSprite);
    }
    else if(IsGimmick([pSprite tag]))
    {
        CreateGimmickSprite(pSprite);
    }
    else if(IsBackGround([pSprite tag]))
    {
        CreateBackGroundSprite(pSprite);
    }
}

void FCGameMain::CreateObject(const int nTag,NSString* key)
{
    if(IsPlayer(nTag))
    {
        CreateLocalPlayerName(key);
    }
    else if(IsEnemy(nTag))
    {
        CreateEnemyName(key);
    }
    else if(IsBlock(nTag))
    {
        CreateBlockName(key);
    }
    else if(IsPlatForm(nTag))
    {
        CreatePlatFormName(key);
    }
    else if(IsFieldItem(nTag))
    {
        CreateFieldItemName(key);
    }
    else if(IsShoot(nTag))
    {
        CreateShootName(key);
    }
    else if(IsHitData(nTag))
    {
        CreateHitDataName(key);
    }
    else if(IsEventBoxPortal(nTag))
    {
        CreateEventBoxPortalName(key);
    }
    else if(IsEventBoxPosition(nTag))
    {
        CreateEventBoxPositionName(key);
    }
    else if(IsEventBoxStageClear(nTag))
    {
        CreateEventBoxStageClearName(key);
    }
    else if(IsEventBoxCheckPoint(nTag))
    {
        CreateEventBoxCheckPointName(key);
    }
    else if(IsGimmick(nTag))
    {
        CreateGimmickName(key);
    }
    else if(IsBackGround(nTag))
    {
        CreateBackGroundName(key);
    }
}

void FCGameMain::CreateSpriteInLevel()
{
	NSMutableDictionary*  spritesInLevel = [_lhelper GetSpriteInLevel];
    NSArray *spritekeys = [spritesInLevel allKeys];
    for(NSString* key in spritekeys)
    {
        LHSprite* ccSprite = [spritesInLevel objectForKey:key];
        if(ccSprite == nil)
            continue;

        CreateObject([ccSprite tag],key);
    }
    
    ObjectInit();
}


void FCGameMain::FirstEvent()
{
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();++it)
    {
        FCObject* pObject = *it;
        if(pObject)
        {
            pObject->FirstEvent();
        }
    }

}

void FCGameMain::TimeCountCheck()
{
    if(m_dRemainTime < 0)
    {
        if(m_pLocalPlayer)
        {
            m_pLocalPlayer->SetState(STATE_DEATH);
        }
    }
}

void FCGameMain::ccTouchesBegan(NSSet * touches,UIEvent * event)
{
	for( UITouch *touch in touches ) 
    {
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
            
        m_pWindowManager->TouchBegan(location);
	}
}

void FCGameMain::ccTouchesMoved(NSSet * touches,UIEvent * event)
{
	for( UITouch *touch in touches ) 
    {
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        m_pWindowManager->TouchMoved(location);
	}
}

void FCGameMain::ccTouchesEnded(NSSet *touches,UIEvent * event)
{
	for( UITouch *touch in touches ) 
    {
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        m_pWindowManager->TouchEnded(location);
	}
}

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------


void FCGameMain::SetCoin(const int nCoin)
{
    m_nCoin = nCoin;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetCoin(m_nCoin);
}

void FCGameMain::AddCoin(const int nCoin)
{
    m_nCoin += nCoin;
    m_nStageCoin += nCoin;
    
    if(m_nCoin >= 100)
    {
        m_nCoin = 0;
        m_pLocalPlayer->AddLife(1);
        PlayCoinLifeUpSound();
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];    
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetCoin(m_nCoin);
}

void FCGameMain::PlayCoinLifeUpSound()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
    FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");
    
    NSString* strLifeUpSound = pDefaultData->GetSoundData(@"COIN_LIFE_UP", 0);
    [[SimpleAudioEngine sharedEngine] playEffect:strLifeUpSound];
}

void FCGameMain::PlayPortalSound()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
    FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");
    
    NSString* strLifeUpSound = pDefaultData->GetSoundData(@"PORTAL", 0);
    [[SimpleAudioEngine sharedEngine] playEffect:strLifeUpSound];

}

void FCGameMain::PlayClearTimeSound()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
    FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");
    
    NSString* strLifeUpSound = pDefaultData->GetSoundData(@"CLEAR_TIME", 0);
    [[SimpleAudioEngine sharedEngine] playEffect:strLifeUpSound];    
}

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------

void FCGameMain::SetScore(const int nScore)
{
    m_nScore = nScore;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetScore(m_nScore);
}

void FCGameMain::AddScore(const int nScore)
{
    //addscore main window와 name panel 모두 추가
    m_nScore += nScore;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];    
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetScore(m_nScore);
    
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    CGPoint pos = pPlayer->GetSprite().position;
    FCUINamePanelWindow* pNamePanelWindow = pWindowManager->GetNamePanelWindow();
    [pNamePanelWindow CreateScorePanel:pos.x y:pos.y z:10 score:nScore];
}

void FCGameMain::AddScoreMainWindow(const int nScore)
{
    //addscore main window에만 표시
    m_nScore += nScore;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetScore(m_nScore);
}


//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------

void FCGameMain::SetContinueCount(const int nContinueCount)
{
    m_nContinueCount = nContinueCount;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCUIContinueWindow* pContinueWindow = pWindowManager->GetContinueWindow();
    pContinueWindow->SetContinueCount(m_nContinueCount);
}


void FCGameMain::AddContinueCount(const int nContinueCount)
{
    m_nContinueCount += nContinueCount;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCUIContinueWindow* pContinueWindow = pWindowManager->GetContinueWindow();
    pContinueWindow->SetContinueCount(m_nContinueCount);
    
}

//------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------

FCEventBoxCheckPoint* FCGameMain::GetCheckPoint()
{
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();++it)
    {
        FCObject* pObject = *it;
        if(IsEventBoxCheckPoint([pObject->GetSprite() tag]))
        {
            return (FCEventBoxCheckPoint*)pObject;
        }
    }
    
    return NULL;
}

FCEventBoxPosition* FCGameMain::GetEventBoxPosition(NSString* strEventBoxPosition)
{
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();++it)
    {
        FCObject* pObject = *it;
        if(IsEventBoxPosition([pObject->GetSprite() tag]))
        {
            if([pObject->GetName() isEqualToString:strEventBoxPosition])
            {
                return (FCEventBoxPosition*)pObject;
            }
        }
    }
    
    return NULL;
}

void FCGameMain::setupAudio()
{
    std::vector<NSString*>* vecSoundPreload = m_pWorldData->GetSoundPreload();
    std::vector<NSString*>::iterator it = vecSoundPreload->begin();
    for(;it != vecSoundPreload->end();++it)
    {
        NSString* strSoundPreload = (*it);
        [[SimpleAudioEngine sharedEngine] preloadEffect:strSoundPreload];
    }
}

void FCGameMain::InputJump()
{
    if(m_pLocalPlayer)
    {
        m_pLocalPlayer->InputJump();
    }
}

void FCGameMain::InputStick(CGPoint velocity)
{
    if(m_pLocalPlayer)
    {
        m_pLocalPlayer->InputStick(velocity);
    }
}

FCObject* FCGameMain::GetObjectFromFixture(b2Fixture* pFixture)
{
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();++it)
    {
        FCObject* pObject = *it;
        if(pObject->IsMyFixture(pFixture))
            return pObject;
    }
    
    return NULL;
}

void FCGameMain::AddStageDamage(const int nStageDamage)
{
    CCLOG(@"ADD STAGE DAMAGE = [%d]",nStageDamage);
    m_nStageDamage += nStageDamage;
}

void FCGameMain::SetCurTime(ccTime dTime)
{
    m_dCurTime = dTime;
    m_dRemainTime -= dTime;
}

void FCGameMain::MoveToEventBoxPosition(NSString* strEventBoxPosition)
{
    FCEventBoxPosition* pEventBoxPosition = GetEventBoxPosition(strEventBoxPosition);
    if(pEventBoxPosition)
    {
        
        float fX = pEventBoxPosition->GetBody()->GetPosition().x;
        float fY = pEventBoxPosition->GetBody()->GetPosition().y;
        
        b2Vec2 point;
        point.x = fX;
        point.y = fY;
        
        b2Vec2 velocity(0,0);
        m_pLocalPlayer->GetBody()->SetLinearVelocity(velocity);
        m_pLocalPlayer->GetBody()->SetTransform(point, 0);
    }
}

void FCGameMain::SetMissionItem(int nIndex,bool bSet)
{
    m_bMissionItem[nIndex] = bSet;
    
    FCUIGameMainWindow* pGameMainWindow = m_pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetMissionItem(nIndex, m_bMissionItem[nIndex]);
}
