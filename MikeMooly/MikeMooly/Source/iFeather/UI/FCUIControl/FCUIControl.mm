#import "FCUIControl.h"

FCUIControl::FCUIControl():
m_nState(0)
{
    
}

FCUIControl::~FCUIControl()
{
    
}

void FCUIControl::Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData)
{
    m_pUIControlData = pUIControlData;
    m_pParentLayer = pParentLayer;
    
    Create();
}

void FCUIControl::Create()
{
    
}

void FCUIControl::SetShow(const bool bShow)
{
    
}

const bool FCUIControl::IsInRect(CGPoint point)
{
    
    return true;
}

void FCUIControl::TouchBegan(CGPoint point)
{
}

void FCUIControl::TouchMoved(CGPoint point)
{
    
}

void FCUIControl::TouchEnded(CGPoint point)
{
}

void FCUIControl::Reset()
{
    Delete();
    Create();
}

void FCUIControl::Delete()
{
    
}

void FCUIControl::ShowEvent()
{
    
}

void FCUIControl::ClickEvent()
{
    
}

void FCUIControl::SetState(const int nState)
{
    
}