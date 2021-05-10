#import "FCEventBoxStageClear.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCEventBoxStageClear::FCEventBoxStageClear()
{
    
}

FCEventBoxStageClear::~FCEventBoxStageClear()
{
    
}

void FCEventBoxStageClear::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCEventBox::Init();
    SetLevelHelper(pLevelHelper);
    InitEventBoxStageClearData();
}


void FCEventBoxStageClear::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCEventBoxStageClear::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCEventBoxStageClear::Create()
{
    SetTag();
}

void FCEventBoxStageClear::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
            
    }
    
    SetState(EVENT_BOX_STAGE_CLEAR_STATE_STAY);
}


void FCEventBoxStageClear::InitEventBoxStageClearData()
{ 
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];   
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    
    FCEventBoxStageClearDataManager* pEventBoxStageClearDataManager = [pDataManager GetEventBoxStageClearDataManager];
    NSString* strKey = GetKey(m_strName);
    FCEventBoxStageClearData* pEventBoxStageClearData = pEventBoxStageClearDataManager->GetEventBoxStageClearData(strKey);
    if(pEventBoxStageClearData == NULL)
    {
        //데이터 없을경우 default
        pEventBoxStageClearData = pEventBoxStageClearDataManager->GetEventBoxStageClearData(@"DEFAULT");
    }
    
    if(pEventBoxStageClearData)
    {
        InitEventBoxStageClearData(pEventBoxStageClearData);
    }
}

void FCEventBoxStageClear::InitEventBoxStageClearData(FCEventBoxStageClearData* pEventBoxStageClearData)
{
    m_pEventBoxStageClearData = pEventBoxStageClearData;
}

void FCEventBoxStageClear::SetState(const int nState)
{
    m_nState = nState;
    switch(nState)
    {
        case EVENT_BOX_STAGE_CLEAR_STATE_STAY:
        {
            NSString* strStayMotion = m_pEventBoxStageClearData->GetStateData(@"STAY",0);
            SetCurMotion(strStayMotion);
        }
        break;
            
        case EVENT_BOX_STAGE_CLEAR_STATE_BREAK:
        {
            NSString* strDamageMotion = m_pEventBoxStageClearData->GetStateData(@"DAMAGE",0);
            SetCurMotion(strDamageMotion);
        }
        break;
    }      
}

void FCEventBoxStageClear::Break()
{
    switch(m_nState)
    {
        case EVENT_BOX_STAGE_CLEAR_STATE_STAY:
            SetState(EVENT_BOX_STAGE_CLEAR_STATE_BREAK);
            break;
    }
}
