#import "FCShoot.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCShoot::FCShoot():
m_fLifeTime(0.f),
m_dCurTime(0)
{
    
}

FCShoot::~FCShoot()
{
    
}

void FCShoot::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCObject::Init();
    SetCreateSensor(false);
    SetLevelHelper(pLevelHelper);
    InitShootData();
}

void FCShoot::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCShoot::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCShoot::Create()
{
    SetTag();
}

void FCShoot::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
            
    }
}

void FCShoot::SetLifeTime(const float fLifeTime)
{
    m_fLifeTime = fLifeTime;
}

const float FCShoot::GetLifeTime()
{
    return m_fLifeTime;
}

void FCShoot::InitShootData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCShootDataManager* pShootDataManager = [pDataManager GetShootDataManager];
    
    NSString* strKey = GetKey(m_strName);
    FCShootData* pShootData = pShootDataManager->GetShootData(strKey);
    if(pShootData == NULL)
    {
        //데이터 없을경우 default
        pShootData = pShootDataManager->GetShootData(@"DEFAULT");
    }
    
    if(pShootData)
    {
        InitShootData(pShootData);
    }
}

void FCShoot::InitShootData(FCShootData* pShootData)
{
    m_pShootData = pShootData;
    SetLifeTime(m_pShootData->GetLifeTime());
}