#import "FCUICreditWIndow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"


FCUICreditWindow::FCUICreditWindow()
{
    
}

FCUICreditWindow::~FCUICreditWindow()
{
    
}

void FCUICreditWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"CreditWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"CreditWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUICreditWindow::Create()
{
    FCUIWindow::Create();
    m_pTitle = GetControl(@"menu1");
}

void FCUICreditWindow::Process(ccTime dt)
{
    FCUIWindow::Process(dt);
}

void FCUICreditWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUICreditWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUICreditWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    
    if(m_pTitle->IsInRect(point))
    {
        if(m_pTitle->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];        
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            [pGameManager WorldChange:@"title"];
            return;
        }
    }

    FCUIWindow::TouchEnded(point);
}

void FCUICreditWindow::SetShow(const bool bShow)
{
    
    FCUIWindow::SetShow(bShow);
}