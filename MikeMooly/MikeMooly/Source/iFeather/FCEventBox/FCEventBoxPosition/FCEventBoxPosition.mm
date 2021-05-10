#import "FCEventBoxPosition.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCEventBoxPosition::FCEventBoxPosition()
{
    
}

FCEventBoxPosition::~FCEventBoxPosition()
{
    
}

void FCEventBoxPosition::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCEventBox::Init();
    SetLevelHelper(pLevelHelper);
    //InitEventBoxPositionData();
}


void FCEventBoxPosition::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCEventBoxPosition::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCEventBoxPosition::Create()
{
    SetTag();
}

void FCEventBoxPosition::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
            
    }
}

/*
void FCEventBoxPosition::InitEventBoxPositionData()
{ 
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];   
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    
    FCEventBoxPositionDataManager* pEventBoxPositionDataManager = [pDataManager GetEventBoxPositionDataManager];
    NSString* strKey = GetKey(m_strName);
    FCEventBoxPositionData* pEventBoxPositionData = pEventBoxPositionDataManager->GetEventBoxPositionData(strKey);
    if(pEventBoxPositionData == NULL)
    {
        //데이터 없을경우 default
        pEventBoxPositionData = pEventBoxPositionDataManager->GetEventBoxPositionData(@"DEFAULT");
    }
    
    if(pEventBoxPositionData)
    {
        InitEventBoxPositionData(pEventBoxPositionData);
    }
}

void FCEventBoxPosition::InitEventBoxPositionData(FCEventBoxPositionData* pEventBoxPositionData)
{
    m_pEventBoxPositionData = pEventBoxPositionData;
}
*/
