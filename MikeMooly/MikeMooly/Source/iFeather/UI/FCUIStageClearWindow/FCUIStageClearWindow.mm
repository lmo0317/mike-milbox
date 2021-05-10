#import "FCUIStageClearWindow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "FCGameManager.h"
#import "ActionLayer.h"


FCUIStageClearWindow::FCUIStageClearWindow()
{
}

FCUIStageClearWindow::~FCUIStageClearWindow()
{
    
}

void FCUIStageClearWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"StageClearWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"StageClearWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUIStageClearWindow::SetShowButton(const bool bShow)
{
    m_pRestartButton->SetShow(bShow);
    m_pNextButton->SetShow(bShow);
    m_pStageSelectButton->SetShow(bShow);
    
    m_pRestartLabel->SetShow(bShow);
    m_pNextLabel->SetShow(bShow);
    m_pStageSelectLabel->SetShow(bShow);
    
    m_pRestartSprite->SetShow(bShow);
    m_pNextSprite->SetShow(bShow);
    m_pStageSelectSprite->SetShow(bShow);
}

void FCUIStageClearWindow::Create()
{
    FCUIWindow::Create();
    
    m_pRestartButton        = GetControl(@"menu_00");
    m_pNextButton           = GetControl(@"menu_01");
    m_pStageSelectButton    = GetControl(@"menu_02");
    
    m_pRestartLabel         = GetControl(@"iconname_restart");
    m_pNextLabel            = GetControl(@"iconname_next_stage");
    m_pStageSelectLabel     = GetControl(@"iconname_stage_select");
    
    m_pRestartSprite        = GetControl(@"icon_restart");
    m_pNextSprite           = GetControl(@"icon_next_stage");
    m_pStageSelectSprite    = GetControl(@"icon_stage_select");

    m_pStar[0]              = GetControl(@"star1");
    m_pStar[1]              = GetControl(@"star2");
    m_pStar[2]              = GetControl(@"star3");
    
    m_pMessage = GetControl(@"message");
    for(int i=0;i<3;++i)
    {
        m_pStar[i]->SetShow(false);
    }
    
    SetShowButton(false);
}

void FCUIStageClearWindow::StarClear()
{
    for(int i=0;i<3;++i)
    {
        m_pStar[i]->SetShow(false);
    }
}

void FCUIStageClearWindow::SetMessageString(NSString* strMessage)
{
    m_pMessage->SetString(strMessage);
}

void FCUIStageClearWindow::SetStarShow(const int nIndex,const bool bShow)
{
    m_pStar[nIndex]->SetShow(bShow);
}

void FCUIStageClearWindow::Process(ccTime dt)
{
    FCUIWindow::Process(dt);
}

void FCUIStageClearWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUIStageClearWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIStageClearWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    if(m_pRestartButton->IsInRect(point))
    {
        if(m_pRestartButton->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];        
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            if(pGameManager)
            {
                [pGameManager RestartGame];
            }
        }
    }
    else if(m_pNextButton->IsInRect(point))
    {
        if(m_pNextButton->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];        
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            if(pGameManager)
            {
                [pGameManager WorldChange:m_strNextStage];
            }
        }
    }
    else if(m_pStageSelectButton->IsInRect(point))
    {
        if(m_pStageSelectButton->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];        
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            if(pGameManager)
            {
                [pGameManager WorldChange:@"StageSelect"];
            }
        }
    }


    FCUIWindow::TouchEnded(point);
}

void FCUIStageClearWindow::SetShow(const bool bShow)
{
    FCUIWindow::SetShow(bShow);
    StarClear();
    SetShowButton(false);
}

void FCUIStageClearWindow::EndAddScore()
{
    SetShowButton(true);

}