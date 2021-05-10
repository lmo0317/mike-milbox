#import "FCBackGround.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCBackGround::FCBackGround():
m_dCurTime(0)
{
    
}

FCBackGround::~FCBackGround()
{
    
}

void FCBackGround::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCObject::Init();
    SetCreateSensor(false);
    SetLevelHelper(pLevelHelper);
    //InitBackGroundData();
}

void FCBackGround::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCBackGround::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCBackGround::Create()
{
    SetTag();
    SetAllFixtureSensor(true);
    
    LHAnimationNode* animation = [m_pSprite animation];
    NSString* strAnimation = [animation uniqueName];
    SetCurMotion(strAnimation);
}

void FCBackGround::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
            
    }
}
/*
void FCBackGround::InitBackGroundData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCBackGroundDataManager* pBackGroundDataManager = [pDataManager GetBackGroundDataManager];
    
    NSString* strKey = GetKey(m_strName);
    FCBackGroundData* pBackGroundData = pBackGroundDataManager->GetBackGroundData(strKey);
    if(pBackGroundData == NULL)
    {
        //데이터 없을경우 default
        pBackGroundData = pBackGroundDataManager->GetBackGroundData(@"DEFAULT");
    }
    
    if(pBackGroundData)
    {
        InitBackGroundData(pBackGroundData);
    }
}

void FCBackGround::InitBackGroundData(FCBackGroundData* pBackGroundData)
{
    m_pBackGroundData = pBackGroundData;
    SetTarget(m_pBackGroundData->GetTarget());
}
*/
