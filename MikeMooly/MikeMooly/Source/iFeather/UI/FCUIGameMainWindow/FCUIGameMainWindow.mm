#import "FCUIGameMainWIndow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"

FCUIGameMainWindow::FCUIGameMainWindow()
{
    for(int i=0;i<3;++i)
    {
        m_pMissionItem[i] = NULL;
    }
}

FCUIGameMainWindow::~FCUIGameMainWindow()
{
    
}

void FCUIGameMainWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"GameMainWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"GameMainWindow");
    
    FCUIWindow::Init(pParentLayer);
}

void FCUIGameMainWindow::Create()
{
    FCUIWindow::Create();
    
    m_pTimeLeft     = GetControl(@"time_left_label");
    m_pMikeLife     = GetControl(@"mike_life_label");
    m_pCoin         = GetControl(@"coin_label");
    m_pCurrentScore = GetControl(@"current_score_label");
    m_pPaused       = GetControl(@"pause");
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
        
    if(strSaveSlot == NULL)
        return;
        
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    if(pSaveData == NULL)
        return;
    
    NSString* strLife = [NSString stringWithFormat:@"%d",pSaveData->GetLife()];
    m_pMikeLife->SetString(strLife);
    
    for(int i=0;i<3;i++)
    {
        NSString *strHeart;
        NSString *strHeartOff;
        
        strHeart = [NSString stringWithFormat:@"heart_%02d",i];
        strHeartOff = [NSString stringWithFormat:@"heart_off_%02d",i];
        
        m_pHeart[i]     = GetControl(strHeart);
        m_pHeartOff[i]  = GetControl(strHeartOff);
    }
    
    for(int i=0;i<3;i++)
    {
        NSString *strMissionItem;
        NSString *strMissionItemOff;
        
        strMissionItem = [NSString stringWithFormat:@"mission_item_%02d",i];
        strMissionItemOff = [NSString stringWithFormat:@"mission_item_off_%02d",i];
        
        m_pMissionItem[i]       = GetControl(strMissionItem);
        m_pMissionItemOff[i]    = GetControl(strMissionItemOff);
        
        m_pMissionItem[i]->SetShow(false);
    }
}

void FCUIGameMainWindow::SetMissionItem(const int nIndex,const bool bShow)
{
    m_pMissionItem[nIndex]->SetShow(bShow);
}

void FCUIGameMainWindow::Process(ccTime dt)
{
    FCUIWindow::Process(dt);
}

void FCUIGameMainWindow::SetTime(ccTime dTime)
{
    NSString* strCurTime = [NSString stringWithFormat:@"%.0f", dTime];
    m_pTimeLeft->SetString(strCurTime);
}

void FCUIGameMainWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchBegan(point);
}

void FCUIGameMainWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIGameMainWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    if(m_pPaused->IsInRect(point))
    {
        if(m_pPaused->GetState() == CONTROL_BUTTON_STATE_SELECT)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
            FCGameMain* pGameMain = [pActionLayer GetGameMain];

            FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
            
            if(pWindowManager->GetShow(@"PausedWindow") == false && pWindowManager->GetShow(@"MainOptionWindow") == false)
            {
                [pActionLayer OpenPausedWindow];                
            }
            else 
            {
                [pActionLayer ClosePausedWindow]; 
            }
        }
    }

    FCUIWindow::TouchEnded(point);
}

void FCUIGameMainWindow::SetLife(const int nLife)
{
    NSString* strLife = [NSString stringWithFormat:@"%d",nLife];
    m_pMikeLife->SetString(strLife);
}

void FCUIGameMainWindow::SetScore(const int nScore)
{
    NSString* strScore = [NSString stringWithFormat:@"%d",nScore];
    m_pCurrentScore->SetString(strScore);    
}

void FCUIGameMainWindow::SetCoin(const int nCoin)
{
    NSString* strCoin = [NSString stringWithFormat:@"%d",nCoin];
    m_pCoin->SetString(strCoin);    
}

void FCUIGameMainWindow::SetHP(const int nHP)
{
    if(m_bShow == false)
        return;
    
    int nMax = nHP;
    if(nMax > 3)
    {
        nMax = 3;
    }
    
    for(int i=0;i<nMax;i++)
    {
        m_pHeart[i]->SetShow(true);
    }
    
    for(int i = nMax;i<3;++i)
    {
        m_pHeart[i]->SetShow(false);
    }
}

void FCUIGameMainWindow::SetShow(const bool bShow)
{
    FCUIWindow::SetShow(bShow);
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    for(int i=0;i<3;++i)
    {
        if(m_pMissionItem[i])
        {
            m_pMissionItem[i]->SetShow(pGameMain->GetMissionItem(i));
        }
    }
}