#import "FCUIPausedWIndow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "FCGameManager.h"
#import "ActionLayer.h"


FCUIPausedWindow::FCUIPausedWindow()
{
    
}

FCUIPausedWindow::~FCUIPausedWindow()
{
    
}

void FCUIPausedWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"PausedWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"PausedWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUIPausedWindow::Create()
{
    FCUIWindow::Create();
    
    m_pStageSelect    = GetControl(@"menu1");
    m_pMainMenu       = GetControl(@"menu2");
    m_pOption         = GetControl(@"menu3");
    m_pRestart        = GetControl(@"menu4");
    m_pClose          = GetControl(@"close");
}

void FCUIPausedWindow::Process(ccTime dt)
{
    FCUIWindow::Process(dt);
}

void FCUIPausedWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUIPausedWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIPausedWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    if(m_pStageSelect->IsInRect(point))
    {
        if(m_pStageSelect->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            if(pGameManager)
            {
                [pGameManager WorldChange:@"StageSelect"];
            }
            
            return;
        }
    }
    else if(m_pMainMenu->IsInRect(point))
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];        
        FCGameManager* pGameManager = [appDelegate GetGameManager];
        [pGameManager WorldChange:@"title"];
    }
    else if(m_pOption->IsInRect(point))
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
        FCGameMain* pGameMain = [pActionLayer GetGameMain];
        FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
        FCUIMainOptionWindow* pMainOptionWindow = pWindowManager->GetMainOptionWindow();
        
        
        if(pMainOptionWindow)
        {
            pMainOptionWindow->SetShow(true);
            
            m_pOption->TouchEnded(point);
            SetShow(false);
        }
    }
    else if(m_pRestart->IsInRect(point))
    {
        if(m_pRestart->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];        
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            if(pGameManager)
            {
                [pGameManager RestartGame];
            }
        }
    }
    else if(m_pClose->IsInRect(point))
    {
        if(m_pClose->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            m_pClose->TouchEnded(point);
            
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
            [pActionLayer ClosePausedWindow];
        }
    }

    
     FCUIWindow::TouchEnded(point);
}

void FCUIPausedWindow::SetShow(const bool bShow)
{
    
    FCUIWindow::SetShow(bShow);
}