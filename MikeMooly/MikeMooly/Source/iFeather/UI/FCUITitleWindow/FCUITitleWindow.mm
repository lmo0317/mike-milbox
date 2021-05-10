#import "FCUITitleWIndow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"
#import "HUDLayer.h"
#import "FCGameCenterManager.h"


FCUITitleWindow::FCUITitleWindow():
m_nDeleteIndex(0)
{
    
}

FCUITitleWindow::~FCUITitleWindow()
{
    
}

void FCUITitleWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"TitleWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"TitleWindow");
    FCUIWindow::Init(pParentLayer);
}

void FCUITitleWindow::Create()
{
    FCUIWindow::Create();
    //m_pFaceBook     = GetControl(@"menu2");
    //m_pTwitter      = GetControl(@"menu3");
    
    m_pCredit       = GetControl(@"menu4");
    m_pOption       = GetControl(@"menu1");
    m_pCaution      = GetControl(@"caution_bar");
    m_pDeleteYes    = GetControl(@"delete_yes");
    m_pDeleteNo     = GetControl(@"delete_no");
    
    for(int i=0;i<3;++i)
    {
        NSString* strSlot = [NSString stringWithFormat:@"slot_%02d",i];
        m_pSlot[i] = GetControl(strSlot);
        
        NSString* strDelete = [NSString stringWithFormat:@"trash_%02d",i];
        m_pDelete[i] = GetControl(strDelete);
        
        NSString* strSlotSprite = [NSString stringWithFormat:@"slot_%02d_sprite",i];
        m_pSlotSprite[i] = GetControl(strSlotSprite);
        
        NSString* strSlotPercent = [NSString stringWithFormat:@"slot_%02d_percent",i];
        m_pSlotPercent[i] = GetControl(strSlotPercent);
    }
    
    m_pCaution->SetShow(false);
    InitSlotPercent();
}

void FCUITitleWindow::SetShowSlot(const bool bShow)
{
    for(int i=0;i<3;++i)
    {
        m_pSlot[i]->SetShow(bShow);
        m_pDelete[i]->SetShow(bShow);
        m_pSlotSprite[i]->SetShow(bShow);
        m_pSlotPercent[i]->SetShow(bShow);
    }
}

void FCUITitleWindow::SetShowCaution(const bool bShow)
{
    m_pCaution->SetShow(bShow);
    m_pDeleteYes->SetShow(bShow);
    m_pDeleteNo->SetShow(bShow);
}

void FCUITitleWindow::Process(ccTime dt)
{
    FCUIWindow::Process(dt);
}

void FCUITitleWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUITitleWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUITitleWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    for(int i=0;i<3;++i)
    {
        if(m_pSlot[i]->IsInRect(point))
        {
            if(m_pSlot[i]->GetState() == CONTROL_BUTTON_STATE_SELECT)
            {
                AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                FCGameManager* pGameManager = [appDelegate GetGameManager];
                [pGameManager WorldChange:@"StageSelect"];
                
                NSString* strSlot = [[NSString stringWithFormat:@"slot_%02d",i] retain];
                [pGameManager SetSaveSlot:strSlot];
                return;
            }
        }
        
        if(m_pDelete[i]->IsInRect(point))
        {
            if(m_pDelete[i]->GetState() == CONTROL_BUTTON_STATE_SELECT)
            {
                SetShowCaution(true);
                SetShowSlot(false);
                
                m_nDeleteIndex = i;
                return;
            }
        }
    }
    
    if(m_pDeleteYes->IsInRect(point))
    {
        if(m_pDeleteYes->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            SetShowCaution(false);
            SetShowSlot(true);
            
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            
            NSString *strSlotName = [NSString stringWithFormat:@"slot_%02d",m_nDeleteIndex];
            [pGameManager DeleteSaveData:strSlotName];
            
            InitSlotPercent();
            m_pDeleteYes->SetState(CONTROL_BUTTON_STATE_NONE);
        }
    }
    
    if(m_pDeleteNo->IsInRect(point))
    {
        if(m_pDeleteNo->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            SetShowCaution(false);
            SetShowSlot(true);
            
            m_pDeleteNo->SetState(CONTROL_BUTTON_STATE_NONE);
        }
    }
    
    /*
    if(m_pFaceBook->IsInRect(point))
    {
        if(m_pFaceBook->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameCenterManager* pGameCenterManager = [appDelegate GetGameCenterManager];
            
            [pGameCenterManager sendScoreToGameCenter:1000];
            [pGameCenterManager showLeaderboard];
        }
    }
    else if(m_pTwitter->IsInRect(point))
    {
        if(m_pTwitter->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameCenterManager* pGameCenterManager = [appDelegate GetGameCenterManager];
            
            [pGameCenterManager sendAchievementWithIdentifier:@"mike_archieve_00" percentComplete:100.0f];
            [pGameCenterManager showArchboard];
        }
    }
    */
    
    if(m_pCredit->IsInRect(point))
    {
        if(m_pCredit->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            [pGameManager WorldChange:@"credit"];
        }
    }
    else if(m_pOption->IsInRect(point))
    {
        if(m_pOption->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            [pGameManager WorldChange:@"option"];
        }        
    }
    

    FCUIWindow::TouchEnded(point);
}

void FCUITitleWindow::SetShow(const bool bShow)
{
    
    FCUIWindow::SetShow(bShow);
    
    m_pCaution->SetShow(false);
    m_pDeleteYes->SetShow(false);
    m_pDeleteNo->SetShow(false);
}

void FCUITitleWindow::SetSlotPercent(const int nIndex,const int nPercent)
{
    NSString* strPercent = [NSString stringWithFormat:@"%d%%", nPercent];
    m_pSlotPercent[nIndex]->SetString(strPercent);
}

void FCUITitleWindow::InitSlotPercent()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    std::map<NSInteger ,FCSaveData*>* mapSaveData = pSaveDataManager->GetSaveDataMap();
    std::map<NSInteger ,FCSaveData*>::iterator it_save_data = mapSaveData->begin();
    
    int i = 0;
    for(;it_save_data != mapSaveData->end();++it_save_data)
    {
        FCSaveData* pSaveData = it_save_data->second;
        
        FCSaveWorldDataManager* pSaveWorldDataManager = pSaveData->GetSaveWorldDataManager();
        const int nPercent = pSaveWorldDataManager->GetPercent();
    
        SetSlotPercent(i,nPercent);
        i++;
    }
}