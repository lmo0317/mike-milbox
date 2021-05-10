#import "FCUISceneEventWIndow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"


FCUISceneEventWindow::FCUISceneEventWindow()
{
    
}

FCUISceneEventWindow::~FCUISceneEventWindow()
{
    
}

void FCUISceneEventWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"SceneEventWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"SceneEventWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUISceneEventWindow::Create()
{
    FCUIWindow::Create();
    m_pBlack = GetControl(@"black");
}

void FCUISceneEventWindow::Process(ccTime dt)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::Process(dt);
}

void FCUISceneEventWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUISceneEventWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUISceneEventWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchEnded(point);
}

void FCUISceneEventWindow::SetShow(const bool bShow)
{
    
    FCUIWindow::SetShow(bShow);
}
