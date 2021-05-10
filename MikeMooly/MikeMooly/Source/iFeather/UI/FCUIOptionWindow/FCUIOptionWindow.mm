#import "FCUIOptionWIndow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"


FCUIOptionWindow::FCUIOptionWindow()
{
    
}

FCUIOptionWindow::~FCUIOptionWindow()
{
    
}

void FCUIOptionWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"OptionWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"OptionWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUIOptionWindow::Create()
{
    FCUIWindow::Create();
    m_pTitle = GetControl(@"menu1");
    m_pBGM   = GetControl(@"bgm");
    m_pFX    = GetControl(@"sfx");
    
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

void FCUIOptionWindow::Process(ccTime dt)
{
    FCUIWindow::Process(dt);
}

void FCUIOptionWindow::TouchBegan(CGPoint point)
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

void FCUIOptionWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIOptionWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    
    if(m_pTitle->IsInRect(point))
    {
        if(m_pTitle->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            SaveOption();
            
            [pGameManager WorldChange:@"title"];
            return;
        }
    }
        
    FCUIWindow::TouchEnded(point);
}

void FCUIOptionWindow::SetShow(const bool bShow)
{
    
    FCUIWindow::SetShow(bShow);
}

void FCUIOptionWindow::SaveOption()
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
