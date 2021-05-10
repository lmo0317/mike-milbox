#import "FCEnemy.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCEnemy::FCEnemy():
m_bCanDeath(false),
m_bAI(false),
m_pBestState(NULL),
m_bDamageSensor(false),
m_bOneShot(false)
{
    
}

FCEnemy::~FCEnemy()
{
    
}

void FCEnemy::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
        case ENEMY01:
            m_bCanDeath = false;
            break;
        case ENEMY02:
            
            m_bCanDeath = false;
            m_bOneShot = true;
            
            break;
            
        case ENEMY03:

            SetCreateSensor(true);
            CreateSensor();
            m_bAI = true;
            
            InitEnemyData();
            InitAIData();
            CreateAIState();
            
            SetState(STATE_STAY);
            
            break;
        case ENEMY04:
            break;
        case ENEMY05:
            break;
        case ENEMY06:
            break;
        case ENEMY07:
            break;
        case ENEMY08:
            break;
        case ENEMY09:
            break;
        case ENEMY10:
            break;
    }
}

void FCEnemy::InitEnemyData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCEnemyDataManager* pEnemyDataManager = [pDataManager GetEnemyDataManager];
    
    NSString* strKey = GetKey(m_strName);
    FCEnemyData* pEnemyData = pEnemyDataManager->GetEnemyData(strKey);
    if(pEnemyData == NULL)
    {
        //데이터 없을경우 default
        pEnemyData = pEnemyDataManager->GetEnemyData(@"DEFAULT");
    }
    
    if(pEnemyData)
    {
        InitEnemyData(pEnemyData);
    }
}

void FCEnemy::InitAIData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCAIDataManager* pAIDataManager = [pDataManager GetAIDataManager];
    
    NSString* strAIName = m_pEnemyData->GetAIName();
    FCAIData* pAIData = pAIDataManager->GetAIData(strAIName);
    if(pAIData == NULL)
    {
        //데이터 없을경우 default
        pAIData = pAIDataManager->GetAIData(@"DEFAULT");
    }
    
    if(pAIData)
    {
        InitAIData(pAIData);
    }
}

void FCEnemy::InitAIData(FCAIData* pAIData)
{
    m_pAIData = pAIData;
}

FCAIData* FCEnemy::GetAIData()
{
    return m_pAIData;
}

void FCEnemy::Init(MyLevelHelperLoader * pLevelHelper)
{
    SetCreateSensor(false);    
    SetLevelHelper(pLevelHelper);
    FCCharacter::Init(); 
}

void FCEnemy::InitEnemyData(FCEnemyData* pEnemyData)
{
    m_pEnemyData = pEnemyData;
    
    SetWalkMotionName(pEnemyData->GetStateData(@"WALK",0));
    SetStayMotionName(pEnemyData->GetStateData(@"STAY",0));    
    SetDamageMotionName(pEnemyData->GetStateData(@"DAMAGE",0));
    SetJumpMotionName(pEnemyData->GetStateData(@"JUMP1",0));
    SetJump2MotionName(pEnemyData->GetStateData(@"JUMP2",0));
    SetFallMotionName(pEnemyData->GetStateData(@"FALL",0));
    SetDyingMotionName(pEnemyData->GetStateData(@"DYING",0));
    SetAttackMotionName(pEnemyData->GetStateData(@"ATTACK",0));

    SetHP(pEnemyData->GetHP());
    SetWalkSpeed(pEnemyData->GetWalkSpeed());
    SetJumpMoveSpeed(pEnemyData->GetJumpMoveSpeed());
    SetJumpSpeed(pEnemyData->GetJumpSpeed());
    SetJump2Speed(pEnemyData->GetJump2Speed());
    SetBounceSpeed(pEnemyData->GetBounceSpeed());
    SetDamageBounceSpeed(pEnemyData->GetDamageBounceSpeed());
    SetCanDeath(pEnemyData->GetCanDeath());
    SetCulling(pEnemyData->GetCulling());
    SetDamageSensor(pEnemyData->GetDamageSensor());
}

void FCEnemy::Create(NSString *Name)
{
    FCObject::Create(Name);
    Create();
}

void FCEnemy::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCEnemy::Create()
{   
    SetTag();
    /*
    if(m_bAI)
    {
        CreateAIState();
    }
    */
}

void FCEnemy::SetCanDeath(const bool bDeath)
{
    m_bCanDeath = bDeath;
}
const bool FCEnemy::GetCanDeath()
{
    return m_bCanDeath;
}

void FCEnemy::SetCulling(const int nCulling)
{
    m_nCulling = nCulling;
}

const int FCEnemy::GetCulling()
{
    return m_nCulling;
}


