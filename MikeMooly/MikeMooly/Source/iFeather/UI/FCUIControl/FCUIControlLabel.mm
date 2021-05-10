#import "FCUIControlLabel.h"
#import "AppDelegate.h"
#import "FCDataManager.h"
#import "FCActionDataManager.h"

FCUIControlLabel::FCUIControlLabel()
{
    
}

FCUIControlLabel::~FCUIControlLabel()
{
    
}

void FCUIControlLabel::Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData)
{
    
    FCUIControl::Init(pParentLayer,pUIControlData);
}

void FCUIControlLabel::Create()
{
    const int nX = m_pUIControlData->GetX();
    const int nY = m_pUIControlData->GetY();
    const int nZ = m_pUIControlData->GetZ();
    
    NSString* pFntFile = m_pUIControlData->GetFntFile();
    NSString* pDefault = m_pUIControlData->GetDefault();
    const float fAnchorX = m_pUIControlData->GetAnchorX();
    const float fAnchorY = m_pUIControlData->GetAnchorY();
    
    const int nR = m_pUIControlData->GetR();
    const int nG = m_pUIControlData->GetG();
    const int nB = m_pUIControlData->GetB();

    m_pLabelBMFont = [CCLabelBMFont labelWithString:pDefault fntFile:pFntFile];
    
    CGPoint point = CGPointMakeBothIPad(nX,nY);
    m_pLabelBMFont.position = point;
    m_pLabelBMFont.anchorPoint = ccp(fAnchorX, fAnchorY);
    m_pLabelBMFont.color = ccc3(nR,nG,nB);

    [m_pParentLayer addChild:m_pLabelBMFont z:nZ];
    FCUIControl::Create();
}

void FCUIControlLabel::SetString(NSString* pString)
{
    [m_pLabelBMFont setString:pString];
}

void FCUIControlLabel::SetShow(const bool bShow)
{
    [m_pLabelBMFont setVisible:bShow];
    
    if(bShow)
    {
        ShowEvent();
    }
    FCUIControl::SetShow(bShow);
}

void FCUIControlLabel::ClickEvent()
{
    FCUIControl::ClickEvent();
}

void FCUIControlLabel::ShowEvent()
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
            [m_pLabelBMFont stopAllActions];
            [m_pLabelBMFont runAction:sequence];
        }
    }
    
    FCUIControl::ShowEvent();
}

const bool FCUIControlLabel::IsInRect(CGPoint point)
{
    if([m_pLabelBMFont visible] == false)
        return false;

    CGRect rect = [m_pLabelBMFont boundingBox];
    if (CGRectContainsPoint(rect, point))
    {
        return true;
    }
    
    return false;
}

void FCUIControlLabel::TouchBegan(CGPoint point)
{
    FCUIControl::TouchBegan(point);
}

void FCUIControlLabel::TouchMoved(CGPoint point)
{
    FCUIControl::TouchMoved(point);
}

void FCUIControlLabel::TouchEnded(CGPoint point)
{
    FCUIControl::TouchEnded(point);
}

void FCUIControlLabel::Reset()
{
    FCUIControl::Reset();
}

void FCUIControlLabel::Delete()
{
    [m_pParentLayer removeChild:m_pLabelBMFont cleanup:TRUE];    
    FCUIControl::Delete();
}

void FCUIControlLabel::SetState(const int nState)
{
    
    FCUIControl::SetState(nState);
}