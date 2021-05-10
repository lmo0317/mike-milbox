#import "FCPlatForm.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCPlatForm::FCPlatForm():
m_nState(BLOCK_STATE_NONE)
{
    
}

FCPlatForm::~FCPlatForm()
{
    
}

void FCPlatForm::Init(MyLevelHelperLoader * pLevelHelper)
{    
    FCObject::Init();
    SetCreateSensor(false);
    SetLevelHelper(pLevelHelper);
}

void FCPlatForm::Create(NSString *Name)
{
    FCObject::Create(Name);
    Create();
}

void FCPlatForm::Create(LHSprite* pSprite)
{
    FCObject::Create(pSprite);
    Create();
}

void FCPlatForm::Create()
{
    SetTag();    
    m_vecPrevPos = m_pBody->GetPosition();
}

void FCPlatForm::SetTag()
{
    if(m_pSprite == NULL)
        return;
}

void FCPlatForm::SetState(const int nState)
{
}

void FCPlatForm::FirstEvent()
{
    AddChild();
    FCObject::FirstEvent();
}  

void FCPlatForm::AddChild()
{
    NSString *uniqueName = [m_pSprite uniqueName];
    NSArray *strArray = [uniqueName componentsSeparatedByString:@"_"];
    LHSprite *pSprite = [[m_pLevelHelper createPhysicalSpriteWithUniqueName:[strArray objectAtIndex:0]] retain];
    
    float fX = m_pBody->GetPosition().x;
    float fY = m_pBody->GetPosition().y;
    float fAngle = m_pBody->GetAngle();
    
    b2Vec2 point;
    point.x = fX;
    point.y = fY;
    pSprite.body->SetTransform(point,fAngle);
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);

    m_pChildSprite = pSprite;
    [pActionLayer CreateSprite:pSprite];
}
