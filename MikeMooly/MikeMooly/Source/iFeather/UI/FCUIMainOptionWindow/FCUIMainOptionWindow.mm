#import "FCUIMainOptionWindow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"


FCUIMainOptionWindow::FCUIMainOptionWindow()
{
    
}

FCUIMainOptionWindow::~FCUIMainOptionWindow()
{
    
}

void FCUIMainOptionWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"MainOptionWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"MainOptionWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUIMainOptionWindow::Create()
{
    FCUIWindow::Create();
    m_pTitle = GetControl(@"menu1");
    m_pBGM   = GetControl(@"bgm");
    m_pFX    = GetControl(@"sfx");
    m_pClose = GetControl(@"close");
    
    m_pControl[0] = GetControl(@"controller_type1");
    m_pControl[1] = GetControl(@"controller_type2");
    
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCOptionDataManager* pOptionDataManager = [pDataManager GetOptionDataManager];
    
    FCOptionData* pOptionData = pOptionDataManager->GetOptionData(@"option_00");
    if(pOptionData == NULL)
        return;
    
    const bool bBGM = pOptionData->GetBGM();
    const bool bFX  = pOptionData->GetFX();
    const int  nControl = pOptionData->GetControl();
    
    if(bBGM) {
        m_pBGM->SetState(CONTROL_CHECK_BUTTON_STATE_CHECKED);
    }
    else {
        m_pBGM->SetState(CONTROL_CHECK_BUTTON_STATE_NONE);        
    }
    
    if(bFX) {
        m_pFX->SetState(CONTROL_CHECK_BUTTON_STATE_CHECKED);
    }
    else {
        m_pFX->SetState(CONTROL_CHECK_BUTTON_STATE_NONE);        
    }
    
    if(nControl == 1) {
        m_pControl[0]->SetState(CONTROL_CHECK_BUTTON_STATE_CHECKED);
        m_pControl[1]->SetState(CONTROL_CHECK_BUTTON_STATE_NONE);
    }
    else if(nControl == 2){
        m_pControl[0]->SetState(CONTROL_CHECK_BUTTON_STATE_NONE);
        m_pControl[1]->SetState(CONTROL_CHECK_BUTTON_STATE_CHECKED);       
    }
}

void FCUIMainOptionWindow::Process(ccTime dt)
{
    FCUIWindow::Process(dt);
}

void FCUIMainOptionWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    
    if(m_pControl[0]->IsInRect(point))
    {
        if(m_pControl[0]->GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED)
        {
            return;
        }
        else if(m_pControl[0]->GetState() == CONTROL_CHECK_BUTTON_STATE_NONE)
        {
            m_pControl[1]->SetState(CONTROL_CHECK_BUTTON_STATE_NONE);
            [pGameManager SetControlType:1];
        }
    }
    else if(m_pControl[1]->IsInRect(point))
    {
        if(m_pControl[1]->GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED)
        {
            return;
        }
        else if(m_pControl[1]->GetState() == CONTROL_CHECK_BUTTON_STATE_NONE)
        {
            m_pControl[0]->SetState(CONTROL_CHECK_BUTTON_STATE_NONE);
            [pGameManager SetControlType:2];
        }
    } 
    else if(m_pBGM->IsInRect(point))
    {
        if(m_pBGM->GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED)
        {
            [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0];
            [pGameManager SetBGVolume:0];
        }
        else if(m_pBGM->GetState() == CONTROL_CHECK_BUTTON_STATE_NONE)
        {
            [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5];
            [pGameManager SetBGVolume:0.5];
        }
    }
    else if(m_pFX->IsInRect(point))
    {
        if(m_pFX->GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED)
        {
            [[SimpleAudioEngine sharedEngine] setEffectsVolume:0];
            [pGameManager SetFXVolume:0];
        }
        else if(m_pFX->GetState() == CONTROL_CHECK_BUTTON_STATE_NONE)
        {
            [[SimpleAudioEngine sharedEngine] setEffectsVolume:1];
            [pGameManager SetFXVolume:1];
        }
    }
    
    FCUIWindow::TouchBegan(point);
}

void FCUIMainOptionWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIMainOptionWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    if(m_pClose->IsInRect(point))
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

void FCUIMainOptionWindow::SetShow(const bool bShow)
{
    SaveOption();
    FCUIWindow::SetShow(bShow);
}

void FCUIMainOptionWindow::SaveOption()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCOptionDataManager* pOptionDataManager = [pDataManager GetOptionDataManager];
    FCOptionDataParser* pOptionDataParser = [pDataManager GetOptionDataParser];
    
    FCOptionData* pOptionData = pOptionDataManager->GetOptionData(@"option_00");
    if(pOptionData == NULL)
        return;
    
    if(m_pBGM->GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED) {
        pOptionData->SetBGM(true);
    }
    else {
        pOptionData->SetBGM(false);
    }
    
    if(m_pFX->GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED) {
        pOptionData->SetFX(true);
    }
    else {
        pOptionData->SetFX(false);
    }
    
    if(m_pControl[0]->GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED) {
        pOptionData->SetControl(1);
    }
    else if(m_pControl[1]->GetState() == CONTROL_CHECK_BUTTON_STATE_CHECKED) {
        pOptionData->SetControl(2);        
    }
    
    pOptionDataParser->SaveOptionData();
}
