#import "FCUIStageStartWindow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"


FCUIStageStartWindow::FCUIStageStartWindow()
{
    
}

FCUIStageStartWindow::~FCUIStageStartWindow()
{
    
}

void FCUIStageStartWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"StageStartWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"StageStartWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUIStageStartWindow::Create()
{
    FCUIWindow::Create();
    
    m_pUIStageSprite    = GetControl(@"stage_name");
    m_pUIStageName      = GetControl(@"stage_name_label");
}

void FCUIStageStartWindow::Process(ccTime dt)
{
    if(GetShow() == false)
        return;
    
    m_dCurTime += dt;
    if(m_dCurTime >= 6)
    {
        CCLOG(@"FCUIStageStartWindow SetShow(false)");
        SetShow(false);
    }

    FCUIWindow::Process(dt);
}

void FCUIStageStartWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUIStageStartWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIStageStartWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
     FCUIWindow::TouchEnded(point);
}

void FCUIStageStartWindow::SetUIStageName(NSString* strUIStageName) 
{
    m_strUIStageName = strUIStageName;
    if(m_pUIStageName)
    {
        m_pUIStageName->SetString(m_strUIStageName);
    }
}

void FCUIStageStartWindow::SetUIStageSprite(NSString* strUIStageSprite) 
{
    m_strUIStageSprite = strUIStageSprite;
    if(m_pUIStageSprite)
    {
        m_pUIStageSprite->SetTexture(m_strUIStageSprite);
    }
}

void FCUIStageStartWindow::SetShow(const bool bShow)
{
    
    FCUIWindow::SetShow(bShow);
}
