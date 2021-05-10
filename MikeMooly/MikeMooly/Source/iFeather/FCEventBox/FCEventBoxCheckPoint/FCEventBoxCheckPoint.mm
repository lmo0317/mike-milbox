#import "FCEventBoxCheckPoint.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCEventBoxCheckPoint::FCEventBoxCheckPoint():
m_pEventBoxCheckPointData(NULL)
{
    
}

FCEventBoxCheckPoint::~FCEventBoxCheckPoint()
{
    
}

void FCEventBoxCheckPoint::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCEventBox::Init();
    SetLevelHelper(pLevelHelper);
    InitEventBoxCheckPointData();
}


void FCEventBoxCheckPoint::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCEventBoxCheckPoint::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCEventBoxCheckPoint::Create()
{
    SetTag();
    SetState(CHECK_POINT_STATE_STAY);
}

void FCEventBoxCheckPoint::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
            
    }
}


void FCEventBoxCheckPoint::InitEventBoxCheckPointData()
{ 
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];   
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    
    FCEventBoxCheckPointDataManager* pEventBoxCheckPointDataManager = [pDataManager GetEventBoxCheckPointDataManager];
    NSString* strKey = GetKey(m_strName);
    
    
    FCEventBoxCheckPointData* pEventBoxCheckPointData = pEventBoxCheckPointDataManager->GetEventBoxCheckPointData(strKey);
    if(pEventBoxCheckPointData == NULL)
    {
        //데이터 없을경우 default
        pEventBoxCheckPointData = pEventBoxCheckPointDataManager->GetEventBoxCheckPointData(@"DEFAULT");
    }
    
    if(pEventBoxCheckPointData)
    {
        InitEventBoxCheckPointData(pEventBoxCheckPointData);
    }
}

void FCEventBoxCheckPoint::InitEventBoxCheckPointData(FCEventBoxCheckPointData* pEventBoxCheckPointData)
{
    m_pEventBoxCheckPointData = pEventBoxCheckPointData;
}

void FCEventBoxCheckPoint::Break()
{
    switch(m_nState)
    {
        case CHECK_POINT_STATE_STAY:
            SetState(CHECK_POINT_STATE_BREAK);
            break;
            
    }
}


void FCEventBoxCheckPoint::SetState(const int nState)
{
    if(m_pEventBoxCheckPointData == NULL)
        return;
    
    m_nState = nState;
    switch(nState)
    {
        case CHECK_POINT_STATE_STAY:
            {
                NSString* strStayMotion = m_pEventBoxCheckPointData->GetStateData(@"STAY",0);
                if([strStayMotion isEqualToString:@""] == false)
                {
                    SetCurMotion(strStayMotion);
                }
            }
            break;
        case CHECK_POINT_STATE_BREAK:
            {
                NSString* strBreakMotion = m_pEventBoxCheckPointData->GetStateData(@"DAMAGE",0);
                if([strBreakMotion isEqualToString:@""] == false)
                {
                    SetCurMotion(strBreakMotion);
                }
            }
            break;
    }
}
