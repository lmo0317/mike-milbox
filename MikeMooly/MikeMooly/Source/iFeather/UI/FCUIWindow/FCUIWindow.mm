#import "FCUIWindow.h"

FCUIWindow::FCUIWindow():
m_pParentLayer(NULL),
m_bShow(false)
{
    
}

FCUIWindow::~FCUIWindow()
{
    
}

void FCUIWindow::Init(CCLayer* pParentLayer)
{
    m_pParentLayer = pParentLayer;
    m_hashUIControl.clear();
    
    Create();
}

void FCUIWindow::Process(ccTime dt)
{
    
}

void FCUIWindow::Create()
{
    std::map<NSInteger,FCUIControlData*>* pUIControlDataHash = m_pWindowData->GetUIControlDataHash();
    std::map<NSInteger,FCUIControlData*>::iterator it = pUIControlDataHash->begin();
    for(;it != pUIControlDataHash->end(); ++it)
    {
        FCUIControlData* pUIControlData = (*it).second;
        CreateControl(pUIControlData);
    }
}

void FCUIWindow::CreateControl(FCUIControlData* pUIControlData)
{
    if([pUIControlData->GetType() isEqualToString:@"sprite"])
    {
        FCUIControlSprite* pUIControlSprite = new FCUIControlSprite;
        pUIControlSprite->Init(m_pParentLayer,pUIControlData);
        
        m_hashUIControl.insert(std::make_pair(pUIControlData->GetID().hash,pUIControlSprite));

    }
    else if([pUIControlData->GetType() isEqualToString:@"label"])
    {
        FCUIControlLabel* pUIControlLabel = new FCUIControlLabel;
        pUIControlLabel->Init(m_pParentLayer,pUIControlData);
        
        m_hashUIControl.insert(std::make_pair(pUIControlData->GetID().hash,pUIControlLabel));
    }
    else if([pUIControlData->GetType() isEqualToString:@"button"])
    {
        FCUIControlButton* pUIControlButton = new FCUIControlButton;
        pUIControlButton->Init(m_pParentLayer,pUIControlData);
        
        m_hashUIControl.insert(std::make_pair(pUIControlData->GetID().hash,pUIControlButton));
    }
    else if([pUIControlData->GetType() isEqualToString:@"check_button"])
    {
        FCUIControlCheckButton* pUIControlCheckButton = new FCUIControlCheckButton;
        pUIControlCheckButton->Init(m_pParentLayer,pUIControlData);
        
        m_hashUIControl.insert(std::make_pair(pUIControlData->GetID().hash,pUIControlCheckButton));
    }
    
}

FCUIControl* FCUIWindow::GetControl(NSString* pID)
{
    std::map<NSInteger,FCUIControl*>::iterator it = m_hashUIControl.find(pID.hash);
    if(it != m_hashUIControl.end())
    {
        return ((*it).second);
    }
    
    return NULL;
}

void FCUIWindow::SetShow(const bool bShow)
{
    m_bShow = bShow;
    
    std::map<NSInteger,FCUIControl*>::iterator it = m_hashUIControl.begin();
    for(;it != m_hashUIControl.end();++it)
    {
        FCUIControl *pControl = (*it).second;
        pControl->SetShow(bShow);
    }
}
const bool FCUIWindow::GetShow()
{
    return m_bShow;
}

void FCUIWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    std::map<NSInteger,FCUIControl*>::iterator it = m_hashUIControl.begin();
    for(;it != m_hashUIControl.end();++it)
    {
        FCUIControl *pControl = (*it).second;
        pControl->TouchBegan(point);
    }
}

void FCUIWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    std::map<NSInteger,FCUIControl*>::iterator it = m_hashUIControl.begin();
    for(;it != m_hashUIControl.end();++it)
    {
        FCUIControl *pControl = (*it).second;
        pControl->TouchMoved(point);
    }
}

void FCUIWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    std::map<NSInteger,FCUIControl*>::iterator it = m_hashUIControl.begin();
    for(;it != m_hashUIControl.end();++it)
    {
        FCUIControl *pControl = (*it).second;
        pControl->TouchEnded(point);
    }
}

void FCUIWindow::Reset()
{
    std::map<NSInteger,FCUIControl*>::iterator it = m_hashUIControl.begin();
    for(;it != m_hashUIControl.end();++it)
    {
        FCUIControl *pControl = (*it).second;
        pControl->Reset();
    }    
}

void FCUIWindow::ShowEvent()
{
    std::map<NSInteger,FCUIControl*>::iterator it = m_hashUIControl.begin();
    for(;it != m_hashUIControl.end();++it)
    {
        FCUIControl *pControl = (*it).second;
        pControl->ShowEvent();
    }    
}

void FCUIWindow::SetState(const int nState)
{
    std::map<NSInteger,FCUIControl*>::iterator it = m_hashUIControl.begin();
    for(;it != m_hashUIControl.end();++it)
    {
        FCUIControl *pControl = (*it).second;
        pControl->SetState(nState);
    }
}