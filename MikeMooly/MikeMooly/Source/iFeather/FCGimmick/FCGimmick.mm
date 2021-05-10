#import "FCGimmick.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCGimmick::FCGimmick():
m_dCurTime(0)
{
    
}

FCGimmick::~FCGimmick()
{
    
}

void FCGimmick::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCObject::Init();
    SetCreateSensor(false);
    SetLevelHelper(pLevelHelper);
    InitGimmickData();
}

void FCGimmick::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCGimmick::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCGimmick::Create()
{
    SetTag();
    //SetAllFixtureSensor(true);
}

void FCGimmick::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
            
    }
}

void FCGimmick::InitGimmickData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCGimmickDataManager* pGimmickDataManager = [pDataManager GetGimmickDataManager];
    
    NSString* strKey = GetKey(m_strName);
    FCGimmickData* pGimmickData = pGimmickDataManager->GetGimmickData(strKey);
    if(pGimmickData == NULL)
    {
        //데이터 없을경우 default
        pGimmickData = pGimmickDataManager->GetGimmickData(@"DEFAULT");
    }
    
    if(pGimmickData)
    {
        InitGimmickData(pGimmickData);
    }
}

void FCGimmick::InitGimmickData(FCGimmickData* pGimmickData)
{
    m_pGimmickData = pGimmickData;
    SetTarget(m_pGimmickData->GetTarget());
    SetOneShot(m_pGimmickData->GetOneShot());
}
