#import "FCFieldItem.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCFieldItem::FCFieldItem():
m_nState(FIELDITEM_STATE_NONE)
{
    
}

FCFieldItem::~FCFieldItem()
{
    
}

void FCFieldItem::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCObject::Init();
    
    SetCreateSensor(false);
    SetLevelHelper(pLevelHelper);
    InitFieldItemData();
}

void FCFieldItem::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCFieldItem::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCFieldItem::Create()
{
    SetTag();
}

void FCFieldItem::FirstEvent()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    if([m_pFieldItemData->GetCategory() isEqualToString:@"MISSION_ITEM"])
    {
        bool bMissionItem = pGameMain->GetMissionItem(m_pFieldItemData->GetMissionItemID());
        if(bMissionItem) {
            SetState(FIELDITEM_STATE_RESCUE);
        }
    }
    
    FCObject::FirstEvent();
}  

void FCFieldItem::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    SetState(FIELDITEM_STATE_STAY);
}

void FCFieldItem::SetState(const int nState)
{
    m_nState = nState;
    switch(nState)
    {
        case FIELDITEM_STATE_STAY:
            {
                NSString* strStayMotion = m_pFieldItemData->GetStateData(@"STAY",0);
                SetCurMotion(strStayMotion);
            }
            break;
        case FIELDITEM_STATE_BREAK:
            {
                NSString* strDamageMotion = m_pFieldItemData->GetStateData(@"DAMAGE",0);
                SetCurMotion(strDamageMotion);
            }
            break;
        case FIELDITEM_STATE_RESCUE:
            {
                NSString* strRescueMotion = m_pFieldItemData->GetStateData(@"RESCUE",0);
                SetCurMotion(strRescueMotion);
            }
            break;
    }      
}

void FCFieldItem::Break()
{
    switch(m_nState)
    {
        case FIELDITEM_STATE_STAY:
        case FIELDITEM_STATE_RESCUE:
            AddFieldItemEffect();
            SetState(FIELDITEM_STATE_BREAK);
            break;
    }
}

void FCFieldItem::AddFieldItemEffect()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pLocalPlayer = pGameMain->GetLocalPlayer();
    
    if(m_pFieldItemData->GetCategory() == NULL)
        return;
    
    //CCLOG(@"CATEGORY = [%@]",m_pFieldItemData->GetCategory());
    if([m_pFieldItemData->GetCategory() isEqualToString:@"LIFE"])
    {
        pLocalPlayer->AddLife(1);
    }
    else if([m_pFieldItemData->GetCategory() isEqualToString:@"COIN"])
    {
        pGameMain->AddCoin(1);
        
        if(m_pFieldItemData->GetScore())
        {
            pGameMain->AddScore(m_pFieldItemData->GetScore());
        }
    }
    else if([m_pFieldItemData->GetCategory() isEqualToString:@"SCORE"])
    {
        if(m_pFieldItemData->GetScore())
        {
            pGameMain->AddScore(m_pFieldItemData->GetScore());
        }
    }
    else if([m_pFieldItemData->GetCategory() isEqualToString:@"HP"])
    {
        int nHP = pLocalPlayer->GetHP();
        if(nHP < 3)
        {
            nHP += 1;
            pLocalPlayer->SetHP(nHP);
        }
    }
    else if([m_pFieldItemData->GetCategory() isEqualToString:@"MISSION_ITEM"])
    {
        //mission id 체크해서 해당하는 mission id 적용
        int nMissionItemID = m_pFieldItemData->GetMissionItemID();
        NSLog(@"MISSION ITEM ID = [%d]",nMissionItemID);
        
        pGameMain->SetMissionItem(nMissionItemID, true);
    }
}


void FCFieldItem::InitFieldItemData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCFieldItemDataManager* pFieldItemDataManager = [pDataManager GetFieldItemDataManager];
    
    NSString* strKey = GetKey(m_strName);
    FCFieldItemData* pFieldItemData = pFieldItemDataManager->GetFieldItemData(strKey);
    if(pFieldItemData == NULL)
    {
        //데이터 없을경우 default
        pFieldItemData = pFieldItemDataManager->GetFieldItemData(@"DEFAULT");
    }
    
    if(pFieldItemData)
    {
        InitFieldItemData(pFieldItemData);
    }
}

void FCFieldItem::InitFieldItemData(FCFieldItemData* pFieldItemData)
{
    m_pFieldItemData = pFieldItemData;
}