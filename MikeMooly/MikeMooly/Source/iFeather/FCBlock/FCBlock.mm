#import "FCBlock.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCBlock::FCBlock():
m_nState(BLOCK_STATE_NONE),
m_bMakeFieldItem(false),
m_nHP(0)
{
    
}

FCBlock::~FCBlock()
{
    
}

void FCBlock::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCObject::Init();
    
    m_strStayMotion = @"block1_stay1";
    m_strBreakMotion = @"block1_break1";

    SetCreateSensor(false);
    SetLevelHelper(pLevelHelper);
    InitBlockData();
}

void FCBlock::Create(NSString *Name)
{
    FCObject::Create(Name);
    Create();
}

void FCBlock::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCBlock::Create()
{
    SetTag();
    SetState(BLOCK_STATE_STAY);
}

void FCBlock::SetTag()
{
    if(m_pSprite == NULL)
        return;

    switch([m_pSprite tag])
    {
        case BLOCK01:
            break;
        case BLOCK02:
            break;
        case BLOCK03:
            break;
        case BLOCK04:
            break;
        case BLOCK05:
            break;
        case BLOCK06:
            break;
        case BLOCK07:
            break;
        case BLOCK08:
            break;
        case BLOCK09:
            break;
        case BLOCK10:
            break;
    }
}

void FCBlock::SetState(const int nState)
{
    m_nState = nState;
    switch(nState)
    {
        case BLOCK_STATE_STAY:
            {
                NSString* strStayMotion = m_pBlockData->GetStateData(@"STAY",m_nHP);
                SetCurMotion(strStayMotion);
                //CCLOG(@"BLOCK STAY = [%@] [%d]",strStayMotion,m_nHP);
            }
            break;
        case BLOCK_STATE_BREAK:
            {
                NSString* strBreakMotion = m_pBlockData->GetStateData(@"DAMAGE",m_nHP);
                SetCurMotion(strBreakMotion);
                //CCLOG(@"BLOCK BREAK = [%@] [%d]",strBreakMotion,m_nHP);
            }
            break;
    }
}

void FCBlock::Break()
{
    switch(m_nState)
    {
        case BLOCK_STATE_STAY:
            AddScore();
            SetState(BLOCK_STATE_BREAK);
            SetHP(m_nHP - 1);
            break;
            
    }
}

void FCBlock::AddScore()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    const int nScore = m_pBlockData->GetScore();
    pGameMain->AddScore(nScore);
    //CCLOG(@"SCORE = [%d]",nScore);
}

void FCBlock::MakeFieldItem()
{
    NSString *uniqueName = [m_pSprite uniqueName];
    NSArray *strArray = [uniqueName componentsSeparatedByString:@"_"];
    LHSprite *pSprite = [[m_pLevelHelper createPhysicalSpriteWithUniqueName:[strArray objectAtIndex:0]] retain];
    
    float fX = m_pBody->GetPosition().x;
    float fY = m_pBody->GetPosition().y;
    b2Vec2 point;
    point.x = fX;
    point.y = fY;
    pSprite.body->SetTransform(point,0);

    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    [pActionLayer CreateSprite:pSprite];
}

void FCBlock::InitBlockData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCBlockDataManager* pBlockDataManager = [pDataManager GetBlockDataManager];
    
    NSString* strKey = GetKey(m_strName);
    FCBlockData* pBlockData = pBlockDataManager->GetBlockData(strKey);
    if(pBlockData == NULL)
    {
        //데이터 없을경우 default
        pBlockData = pBlockDataManager->GetBlockData(@"DEFAULT");
    }
    
    if(pBlockData)
    {
        InitBlockData(pBlockData);
    }
}

void FCBlock::InitBlockData(FCBlockData* pBlockData)
{
    m_pBlockData = pBlockData;
    SetHP(m_pBlockData->GetHP());
}


