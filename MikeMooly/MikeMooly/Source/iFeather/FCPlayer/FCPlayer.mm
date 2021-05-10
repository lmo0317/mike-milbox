#import "FCPlayer.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"

FCPlayer::FCPlayer():
m_pPlayerData(NULL),
m_nLife(0)
{
    
}

FCPlayer::~FCPlayer()
{
    
}

void FCPlayer::Init(MyLevelHelperLoader * pLevelHelper)
{
    SetCreateSensor(true);
    SetLevelHelper(pLevelHelper);
    InitData();
    
    FCCharacter::Init(); 
}
void FCPlayer::InitData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    
    if(pSaveData == NULL)
        return;
    
    int nLife = pSaveData->GetLife();
    int nHP = pSaveData->GetHP();
    
    
    if(nLife <= 0)
    {
        FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
        FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");
        NSString* strSaveSlot = [pGameManager GetSaveSlot];
        FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
        
        nLife = pDefaultData->GetLife();
        nHP = pDefaultData->GetHP();
        
        pSaveData->SetLife(nLife);
        pSaveData->SetHP(nHP);
    }
    
    SetLife(nLife);    
    SetHP(nHP);

}

void FCPlayer::InitPlayerData(FCPlayerData* pPlayerData)
{
    m_pPlayerData = pPlayerData;
  
    SetWalkMotionName(pPlayerData->GetStateData(@"WALK",0));
    SetStayMotionName(pPlayerData->GetStateData(@"STAY",0));    
    SetDamageMotionName(pPlayerData->GetStateData(@"DAMAGE",0));
    SetJumpMotionName(pPlayerData->GetStateData(@"JUMP1",0));
    SetJump2MotionName(pPlayerData->GetStateData(@"JUMP2",0));
    SetFallMotionName(pPlayerData->GetStateData(@"FALL",0));
    SetDyingMotionName(pPlayerData->GetStateData(@"DYING",0));
    SetAttackMotionName(pPlayerData->GetStateData(@"ATTACK",0));

    //SetHP(pPlayerData->GetHP());
    SetWalkSpeed(pPlayerData->GetWalkSpeed());
    SetJumpMoveSpeed(pPlayerData->GetJumpMoveSpeed());
    SetJumpSpeed(pPlayerData->GetJumpSpeed());
    SetJump2Speed(pPlayerData->GetJump2Speed());
    SetDeathTime(pPlayerData->GetDeathTime());
    SetBounceSpeed(pPlayerData->GetBounceSpeed());
    SetDamageBounceSpeed(pPlayerData->GetDamageBounceSpeed());
    SetJumpMaxCount(pPlayerData->GetJumpMaxCount());
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetHP(m_nHP);
    pGameMainWindow->SetLife(m_nLife);
}

void FCPlayer::Create(NSString *Name)
{
    FCObject::Create(Name);
    Create();
}

void FCPlayer::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCPlayer::Create()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCPlayerDataManager* pPlayerDataManager = [pDataManager GetPlayerDataManager];
    FCPlayerData* pPlayerData = pPlayerDataManager->GetPlayerData(m_strName);
    InitPlayerData(pPlayerData);
    
    SetState(STATE_STAY);
    m_pBody->SetSleepingAllowed(false);
}

void FCPlayer::InitCheckPoint()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    if(pGameManager)
    {
        bool bCheckPoint = [pGameManager GetCheckPoint];
        if(bCheckPoint)
        {
            ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
            FCGameMain* pGameMain = [pActionLayer GetGameMain];
            
            FCEventBoxCheckPoint* pCheckPoint = pGameMain->GetCheckPoint();
            if(pCheckPoint)
            {
                float fX = pCheckPoint->GetBody()->GetPosition().x;
                float fY = pCheckPoint->GetBody()->GetPosition().y;                
                b2Vec2 point;
                point.x = fX;
                point.y = fY;
                
                m_pBody->SetTransform(point,0);
                
                ccTime dCheckPointTime = [pGameManager GetCheckPointTime];
                int nCheckPointCoin = [pGameManager GetCheckPointCoin];
                int nCheckPointDamage = [pGameManager GetCheckPointDamage];
                
                pGameMain->SetCurTime(dCheckPointTime);
                pGameMain->SetStageCoin(nCheckPointCoin);
                pGameMain->SetStageDamage(nCheckPointDamage);
                
                for(int i=0;i<3;++i)
                {
                    int bMissionItem = [pGameManager GetCheckPointMissionItem:i];
                    CCLOG(@"CHECK_POINT LOAD MISSION ITEM = [%d]",bMissionItem);
                    pGameMain->SetMissionItem(i, bMissionItem);
                }
            }
        }
    }
}

void FCPlayer::InputJump()  
{
    b2Vec2 vecVelocity = m_pBody->GetLinearVelocity();
    if(m_nJumpCount == 0)
    {
        if(m_nContactBottomFixture)
        {
            ++m_nJumpCount;
            SetState(STATE_JUMP);
        }
    }
    else if(m_nJumpCount <= m_nJumpMaxCount && vecVelocity.y < 5)
    {
        ++m_nJumpCount;
        SetState(STATE_JUMP2);
    }
}

void FCPlayer::InputStick(CGPoint velocity)
{ 
    SetDirection(velocity);
}

void FCPlayer::SetHP(const int nHP)
{
    FCCharacter::SetHP(nHP);
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetHP(m_nHP);
}

void FCPlayer::SetLife(const int nLife) 
{
    m_nLife = nLife;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetLife(m_nLife);
}

void FCPlayer::AddLife(const int nLife)
{    
    m_nLife += nLife;
    
    if(m_nLife > 99)
        m_nLife = 99;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    
    FCUIGameMainWindow* pGameMainWindow = pWindowManager->GetGameMainWindow();
    pGameMainWindow->SetLife(m_nLife);
}

