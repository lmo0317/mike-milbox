#import "FCUIControlSprite.h"
#import "AppDelegate.h"
#import "FCDataManager.h"
#import "FCActionDataManager.h"

FCUIControlSprite::FCUIControlSprite():
m_pFirstTexture(NULL),
m_pSecondTexture(NULL),
m_pSprite(NULL)
{
    
}

FCUIControlSprite::~FCUIControlSprite()
{
    
}

void FCUIControlSprite::Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData)
{
    
    FCUIControl::Init(pParentLayer,pUIControlData);
}

void FCUIControlSprite::Create()
{
    const int nX = m_pUIControlData->GetX();
    const int nY = m_pUIControlData->GetY();
    const int nZ = m_pUIControlData->GetZ();
    
    /*
    const int nU = m_pUIControlData->GetU();
    const int nV = m_pUIControlData->GetV();
    const int nWidth = m_pUIControlData->GetWidth();
    const int nHeight = m_pUIControlData->GetHeight();
    */
    
    const float fAnchorX = m_pUIControlData->GetAnchorX();
    const float fAnchorY = m_pUIControlData->GetAnchorY();
       
    m_pSprite = [CCSprite spriteWithFile:m_pUIControlData->GetImg1()];
    
    if(m_pUIControlData->GetImg1())
    {
        m_pFirstTexture = [[CCTextureCache sharedTextureCache] addImage: m_pUIControlData->GetImg1()];
    }
    
    if(m_pUIControlData->GetImg2())
    {
        m_pSecondTexture = [[CCTextureCache sharedTextureCache] addImage: m_pUIControlData->GetImg2()];
    }

    CGPoint point = CGPointMakeBothIPad(nX,nY);
    m_pSprite.position = point;
    
    m_pSprite.anchorPoint = ccp(fAnchorX,fAnchorY);
    [m_pParentLayer addChild:m_pSprite z:nZ];
    FCUIControl::Create();
}

void FCUIControlSprite::SetShow(const bool bShow)
{
    [m_pSprite setVisible:bShow];
    
    if(bShow)
    {
        ShowEvent();
    }
    
    FCUIControl::SetShow(bShow);
}

void FCUIControlSprite::ShowEvent()
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

void FCUIControlSprite::ClickEvent()
{
    
    FCUIControl::ClickEvent();
}

const bool FCUIControlSprite::IsInRect(CGPoint point)
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

void FCUIControlSprite::TouchBegan(CGPoint point)
{
    FCUIControl::TouchBegan(point);
}

void FCUIControlSprite::TouchMoved(CGPoint point)
{
    FCUIControl::TouchMoved(point);
}

void FCUIControlSprite::TouchEnded(CGPoint point)
{
    FCUIControl::TouchEnded(point);
}

void FCUIControlSprite::SetTexture(NSString* strTexture)
{
    CCTexture2D* pTexture = [[CCTextureCache sharedTextureCache] addImage: strTexture];
    [m_pSprite setTexture:pTexture];
}

void FCUIControlSprite::Reset()
{
    FCUIControl::Reset();
}

void FCUIControlSprite::Delete()
{
    [m_pParentLayer removeChild:m_pSprite cleanup:TRUE];    
    FCUIControl::Delete();
}

void FCUIControlSprite::SetState(const int nState)
{
    
    FCUIControl::SetState(nState);
}

void FCUIControlSprite::SetPos(CGPoint pos)
{
    [m_pSprite setPosition:pos];
}

void FCUIControlSprite::SetFirstTexture()
{
    if(m_pFirstTexture)
    {
        CGSize size = [m_pFirstTexture contentSize];
        CGRect rect = CGRectMake(0, 0, size.width,size.height);
        
        [m_pSprite setTexture:m_pFirstTexture];
        [m_pSprite setTextureRect:rect];
    }
}

void FCUIControlSprite::SetSecondTexture()
{
    if(m_pSecondTexture)
    {
        CGSize size = [m_pSecondTexture contentSize];
        CGRect rect = CGRectMake(0, 0, size.width,size.height);
        
        [m_pSprite setTexture:m_pSecondTexture];
        [m_pSprite setTextureRect:rect];
    }
}