#import "FCUIContinueWIndow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"


FCUIContinueWindow::FCUIContinueWindow()
{
    
}

FCUIContinueWindow::~FCUIContinueWindow()
{
    
}

void FCUIContinueWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"ContinueWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"ContinueWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUIContinueWindow::Create()
{
    FCUIWindow::Create();
    
    m_pYes              = GetControl(@"yes");
    m_pNo               = GetControl(@"no");
    m_pContinueCount    = GetControl(@"continue_count");
}

void FCUIContinueWindow::Process(ccTime dt)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::Process(dt);
}

void FCUIContinueWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUIContinueWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIContinueWindow::SetSaveData()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
    FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    
    pSaveData->SetLife(pDefaultData->GetLife());
    pSaveData->SetHP(pDefaultData->GetHP());
}

void FCUIContinueWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    if(m_pYes->IsInRect(point))
    {
        if(m_pYes->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            //continue 카운트 있을경우      
            //다시 시작
            
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
            FCGameMain* pGameMain = [pActionLayer GetGameMain];
            
            if([pGameManager GetLoadingState] != LOADING_STATE_NONE)
                return;
            
            int nContinueCount = pGameMain->GetContinueCount();
            if(nContinueCount <= 0)
            {
                return;
            }
            
            pGameMain->AddContinueCount(-1);
            SetSaveData();
            [pActionLayer SaveData];
            [pGameManager WorldChange:@"StageSelect"];
            
            return;
        }
    }
    else if(m_pNo->IsInRect(point))
    {
        if(m_pNo->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            //종료 타이틀로 돌아감
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];

            //스테이지 초기화 
            //ResetContinueCount();
            NSString* strSaveSlot = [pGameManager GetSaveSlot];
            [pGameManager ResetContinueCount];
            SetSaveData();
            [pGameManager ClearUnLockWorld];
            [pActionLayer SaveData];
            
            [pGameManager DeleteSaveDataScore:strSaveSlot];
            [pGameManager WorldChange:@"title"];
            return;
        }
    }
    
    FCUIWindow::TouchEnded(point);
}

void FCUIContinueWindow::SetShow(const bool bShow)
{
    
    FCUIWindow::SetShow(bShow);
}

void FCUIContinueWindow::SetContinueCount(const int nContinueCount)
{
    NSString* strContinueCount = [NSString stringWithFormat:@"%d",nContinueCount];
    m_pContinueCount->SetString(strContinueCount);
}
