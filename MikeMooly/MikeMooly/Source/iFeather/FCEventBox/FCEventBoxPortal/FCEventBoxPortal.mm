#import "FCEventBoxPortal.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCEventBoxPortal::FCEventBoxPortal()
{
    
}

FCEventBoxPortal::~FCEventBoxPortal()
{
    
}

void FCEventBoxPortal::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCEventBox::Init();
    SetLevelHelper(pLevelHelper);
    InitEventBoxPortalData();
}


void FCEventBoxPortal::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCEventBoxPortal::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCEventBoxPortal::Create()
{
    SetTag();
    SetState(EVENT_BOX_PORTAL_STATE_READY);
}

void FCEventBoxPortal::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
            
    }
}


void FCEventBoxPortal::InitEventBoxPortalData()
{ 
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];   
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    
    FCEventBoxPortalDataManager* pEventBoxPortalDataManager = [pDataManager GetEventBoxPortalDataManager];
    NSString* strKey = GetKey(m_strName);
    FCEventBoxPortalData* pEventBoxPortalData = pEventBoxPortalDataManager->GetEventBoxPortalData(strKey);
    if(pEventBoxPortalData == NULL)
    {
        //데이터 없을경우 default
        pEventBoxPortalData = pEventBoxPortalDataManager->GetEventBoxPortalData(@"DEFAULT");
    }
    
    if(pEventBoxPortalData)
    {
        InitEventBoxPortalData(pEventBoxPortalData);
    }
}

void FCEventBoxPortal::InitEventBoxPortalData(FCEventBoxPortalData* pEventBoxPortalData)
{
    m_pEventBoxPortalData = pEventBoxPortalData;
}

void FCEventBoxPortal::SetState(const int nState)
{
    if(m_pEventBoxPortalData == NULL)
        return;
    
    m_nState = nState;
    switch(nState)
    {
        case EVENT_BOX_PORTAL_STATE_READY:
        {
            NSString* strReadyMotion = m_pEventBoxPortalData->GetStateData(@"READY",0);
            if([strReadyMotion isEqualToString:@""] == false)
            {
                SetCurMotion(strReadyMotion);
            }
        }
            break;
        case EVENT_BOX_PORTAL_STATE_STAY:
        {
            NSString* strStayMotion = m_pEventBoxPortalData->GetStateData(@"STAY",0);
            if([strStayMotion isEqualToString:@""] == false)
            {
                SetCurMotion(strStayMotion);
            }
        }
            break;
    }
}
