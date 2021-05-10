#import "FCHitBox.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCHitBox::FCHitBox():
m_fLifeTime(0.f),
m_dCurTime(0)
{
    
}

FCHitBox::~FCHitBox()
{
    
}

void FCHitBox::Init(MyLevelHelperLoader * pLevelHelper)
{
    FCObject::Init();
    SetCreateSensor(false);
    SetLevelHelper(pLevelHelper);
    InitHitBoxData();
}

void FCHitBox::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCHitBox::Create(NSString* Name)
{
    FCObject::Create(Name);
    Create();
}

void FCHitBox::Create()
{
    SetTag();
    SetAllFixtureSensor(true);
}

void FCHitBox::SetTag()
{
    if(m_pSprite == NULL)
        return;
    
    switch([m_pSprite tag])
    {
            
    }
}

void FCHitBox::SetLifeTime(const float fLifeTime)
{
    m_fLifeTime = fLifeTime;
}

const float FCHitBox::GetLifeTime()
{
    return m_fLifeTime;
}

void FCHitBox::InitHitBoxData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];    
    FCHitBoxDataManager* pHitBoxDataManager = [pDataManager GetHitBoxDataManager];
    
    NSString* strKey = GetKey(m_strName);
    FCHitBoxData* pHitBoxData = pHitBoxDataManager->GetHitBoxData(strKey);
    if(pHitBoxData == NULL)
    {
        //데이터 없을경우 default
        pHitBoxData = pHitBoxDataManager->GetHitBoxData(@"DEFAULT");
    }
    
    if(pHitBoxData)
    {
        InitHitBoxData(pHitBoxData);
    }
}

void FCHitBox::InitHitBoxData(FCHitBoxData* pHitBoxData)
{
    m_pHitBoxData = pHitBoxData;
    SetLifeTime(m_pHitBoxData->GetLifeTime());
}