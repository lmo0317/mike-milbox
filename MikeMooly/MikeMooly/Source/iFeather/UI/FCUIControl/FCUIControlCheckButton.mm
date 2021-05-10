#import "FCUIControlCheckButton.h"
#import "AppDelegate.h"
#import "FCDataManager.h"
#import "FCActionDataManager.h"

FCUIControlCheckButton::FCUIControlCheckButton():
m_pSprite(NULL)
{
    m_pNormalTexture    = [[CCTexture2D alloc] init];
    m_pCheckedTexture  = [[CCTexture2D alloc] init];
}

FCUIControlCheckButton::~FCUIControlCheckButton()
{
    [m_pNormalTexture release];
    [m_pCheckedTexture release];
}

void FCUIControlCheckButton::Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData)
{
    
    FCUIControl::Init(pParentLayer,pUIControlData);
}

void FCUIControlCheckButton::Create()
{
    const int nX = m_pUIControlData->GetX();
    const int nY = m_pUIControlData->GetY();
    const int nZ = m_pUIControlData->GetZ();    
    const float fAnchorX = m_pUIControlData->GetAnchorX();
    const float fAnchorY = m_pUIControlData->GetAnchorY();
    
    m_pSprite = [CCSprite spriteWithFile:m_pUIControlData->GetImg1()];
    
    CGPoint point = CGPointMakeBothIPad(nX,nY);
    m_pSprite.position = point;
    m_pSprite.anchorPoint = ccp(fAnchorX,fAnchorY);
    
    if(m_pUIControlData->GetImg1())
    {
        m_pNormalTexture = [[CCTextureCache sharedTextureCache] addImage: m_pUIControlData->GetImg1()];
    }
    
    if(m_pUIControlData->GetImg2())
    {
        m_pCheckedTexture = [[CCTextureCache sharedTextureCache] addImage: m_pUIControlData->GetImg2()];
    }
    
    SetState(m_nState);
    [m_pParentLayer addChild:m_pSprite z:nZ];
    FCUIControl::Create();
}

void FCUIControlCheckButton::SetShow(const bool bShow)
{
    [m_pSprite setVisible:bShow];
    
    if(bShow)
    {
        ShowEvent();
    }
    FCUIControl::SetShow(bShow);
}

const bool FCUIControlCheckButton::IsInRect(CGPoint point)
{
    if([m_pSprite visible] == false)
        return false;
    
    CGRect rect = [m_pSprite boundingBox];
    if (CGRectContainsPoint(rect, point))
    {
        return true;
    }
    
    return false;
}

void FCUIControlCheckButton::ClickEvent()
{
    NSString* strClickEvent = m_pUIControlData->GetClickEvent();
    if(strClickEvent)
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
        FCDataManager* pDataManager = [appDelegate GetDataManager];    
        FCActionDataManager* pActionDataManager = [pDataManager GetActionDataManager];
        id sequence = pActionDataManager->GetActionSequence(strClickEvent);
        
        if(sequence)
        {
            [m_pSprite runAction:sequence];
        }
    }
    
    FCUIControl::ClickEvent();
}

void FCUIControlCheckButton::ShowEvent()
{
    NSString* strShowEvent = m_pUIControlData->GetShowEvent();
    if(strShowEvent)
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
        FCDataManager* pDataManager = [appDelegate GetDataManager];    
        FCActionDataManager* pActionDataManager = [pDataManager GetActionDataManager];
        id sequence = pActionDataManager->GetActionSequence(strShowEvent);
        
        if(sequence)
        {
            [m_pSprite stopAllActions];
            [m_pSprite runAction:sequence];
        }
    }
    
    FCUIControl::ShowEvent();
}

void FCUIControlCheckButton::Click()
{
    ClickEvent();
}

void FCUIControlCheckButton::TouchBegan(CGPoint point)
{
    if(m_pSprite == NULL)
        return;
    
    if([m_pSprite visible] == false)
        return;
    
    if(IsInRect(point))
    {
        if(GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED)
        {
            SetState(CONTROL_CHECK_BUTTON_STATE_NONE);
        }
        else if(GetState() == CONTROL_CHECK_BUTTON_STATE_NONE)
        {
            SetState(CONTROL_CHECK_BUTTON_STATE_CHECKED);
        }
        
        Click();
    }
    
    FCUIControl::TouchBegan(point);
}

void FCUIControlCheckButton::TouchMoved(CGPoint point)
{
    if([m_pSprite visible] == false)
        return;
    
    FCUIControl::TouchMoved(point);
}

void FCUIControlCheckButton::TouchEnded(CGPoint point)
{
    if([m_pSprite visible] == false)
        return;
    
    FCUIControl::TouchEnded(point);
}

void FCUIControlCheckButton::Reset()
{    
    FCUIControl::Reset();
}

void FCUIControlCheckButton::Delete()
{
    [m_pParentLayer removeChild:m_pSprite cleanup:TRUE];
    FCUIControl::Delete();
}

void FCUIControlCheckButton::SetState(const int nState)
{
    m_nState = nState;
    switch(nState)
    {
        case CONTROL_CHECK_BUTTON_STATE_NONE:
        {
            CGSize size = [m_pNormalTexture contentSize];
            CGRect rect = CGRectMake(0, 0, size.width,size.height);
            
            [m_pSprite setTexture:m_pNormalTexture];
            [m_pSprite setTextureRect:rect];
        }   
            break;
        case CONTROL_CHECK_BUTTON_STATE_CHECKED:
        {
            CGSize size = [m_pCheckedTexture contentSize];
            CGRect rect = CGRectMake(0, 0, size.width,size.height);
            
            [m_pSprite setTexture:m_pCheckedTexture];
            [m_pSprite setTextureRect:rect];
        }
            break;
    }
    
    FCUIControl::SetState(nState);
}

void FCUIControlCheckButton::Selector()
{
    
}

