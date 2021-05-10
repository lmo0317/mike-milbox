#import "FCUIGameOverWIndow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"


FCUIGameOverWindow::FCUIGameOverWindow()
{
    
}

FCUIGameOverWindow::~FCUIGameOverWindow()
{
    
}

void FCUIGameOverWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"GameOverWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"GameOverWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUIGameOverWindow::Create()
{
    FCUIWindow::Create();
    
    m_pNo = GetControl(@"no");    
}

void FCUIGameOverWindow::Process(ccTime dt)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::Process(dt);
}

void FCUIGameOverWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUIGameOverWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIGameOverWindow::SetSaveData()
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

void FCUIGameOverWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    if(m_pNo->IsInRect(point))
    {
        if(m_pNo->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            //종료 타이틀로 돌아감
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCGameManager* pGameManager = [appDelegate GetGameManager];
            ActionLayer* pActionLayer = (ActionLayer*)[appDelegate GetActionLayer];
            
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

void FCUIGameOverWindow::SetShow(const bool bShow)
{
    
    FCUIWindow::SetShow(bShow);
}