#import "FCUIControlButton.h"
#import "AppDelegate.h"
#import "FCDataManager.h"
#import "FCActionDataManager.h"

FCUIControlButton::FCUIControlButton():
m_pSprite(NULL)
{
    m_pNormalTexture    = [[CCTexture2D alloc] init];
    m_pSelectedTexture  = [[CCTexture2D alloc] init];
    m_pDisableTexture   = [[CCTexture2D alloc] init];
}

FCUIControlButton::~FCUIControlButton()
{
    [m_pNormalTexture release];
    [m_pSelectedTexture release];
    [m_pDisableTexture release];
}

void FCUIControlButton::Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData)
{
    
    FCUIControl::Init(pParentLayer,pUIControlData);
}

void FCUIControlButton::Create()
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
        m_pSelectedTexture = [[CCTextureCache sharedTextureCache] addImage: m_pUIControlData->GetImg2()];
    }
    
    if(m_pUIControlData->GetImg3())
    {
        m_pDisableTexture = [[CCTextureCache sharedTextureCache] addImage: m_pUIControlData->GetImg3()];
    }
    
    SetState(m_nState);
    [m_pParentLayer addChild:m_pSprite z:nZ];
    FCUIControl::Create();
}

void FCUIControlButton::SetShow(const bool bShow)
{
    [m_pSprite setVisible:bShow];
    
    if(bShow)
    {
        ShowEvent();
    }
    FCUIControl::SetShow(bShow);
}

const bool FCUIControlButton::IsInRect(CGPoint point)
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

void FCUIControlButton::ClickEvent()
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

void FCUIControlButton::ShowEvent()
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

void FCUIControlButton::Click()
{
    ClickEvent();
}

void FCUIControlButton::TouchBegan(CGPoint point)
{
    if(m_pSprite == NULL)
        return;
    
    if([m_pSprite visible] == false)
        return;
    
    if(m_nState == CONTROL_BUTTON_STATE_DISABLE)
        return;
    
    if(IsInRect(point))
    {
        SetState(CONTROL_BUTTON_STATE_SELECT);
        Click();
    }
    
    FCUIControl::TouchBegan(point);
}

void FCUIControlButton::TouchMoved(CGPoint point)
{
    if([m_pSprite visible] == false)
        return;

    FCUIControl::TouchMoved(point);
}

void FCUIControlButton::TouchEnded(CGPoint point)
{
    if([m_pSprite visible] == false)
        return;

    if(GetState() == CONTROL_BUTTON_STATE_SELECT)
    {
        SetState(CONTROL_BUTTON_STATE_NONE);
    }
    
    FCUIControl::TouchEnded(point);
}

void FCUIControlButton::Reset()
{    
    FCUIControl::Reset();
}

void FCUIControlButton::Delete()
{
    [m_pParentLayer removeChild:m_pSprite cleanup:TRUE];
    FCUIControl::Delete();
}

void FCUIControlButton::SetState(const int nState)
{
    switch(nState)
    {
        case CONTROL_BUTTON_STATE_NONE:
            if(m_nState == CONTROL_BUTTON_STATE_DISABLE)
                return;
            break;
    }
    
    m_nState = nState;
    switch(nState)
    {
        case CONTROL_BUTTON_STATE_NONE:
            {
                CGSize size = [m_pNormalTexture contentSize];
                CGRect rect = CGRectMake(0, 0, size.width,size.height);
                
                [m_pSprite setTexture:m_pNormalTexture];
                [m_pSprite setTextureRect:rect];
            }   
            break;
        case CONTROL_BUTTON_STATE_SELECT:
            {
                CGSize size = [m_pSelectedTexture contentSize];
                CGRect rect = CGRectMake(0, 0, size.width,size.height);

                [m_pSprite setTexture:m_pSelectedTexture];
                [m_pSprite setTextureRect:rect];
            }
            break;
        case CONTROL_BUTTON_STATE_DISABLE:
            {
                CGSize size = [m_pDisableTexture contentSize];
                CGRect rect = CGRectMake(0, 0, size.width,size.height);
                
                [m_pSprite setTexture:m_pDisableTexture];
                [m_pSprite setTextureRect:rect];
            }
            break;
    }
    
    FCUIControl::SetState(nState);
}

void FCUIControlButton::Selector()
{
    
}

