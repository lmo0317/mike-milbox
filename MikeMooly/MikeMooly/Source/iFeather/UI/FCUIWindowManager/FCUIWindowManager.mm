#import "FCUIWindowManager.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

FCUIWindowManager::FCUIWindowManager():
m_pUIGameMainWindow(NULL),
m_pUIPausedWindow(NULL),
m_pUITitleWindow(NULL),
m_pUIStageSelectWindow(NULL),
m_pUIStageStartWindow(NULL),
m_pUIStageClearWindow(NULL),
m_pUICreditWindow(NULL),
m_pUIOptionWindow(NULL),
m_pUIGameOverWindow(NULL),
m_pUIContinueWindow(NULL),
m_pUIWindowListData(NULL),
m_pUIMainOptionWindow(NULL)
{
    
}

FCUIWindowManager::~FCUIWindowManager()
{
    
}

void FCUIWindowManager::Init(HUDLayer* pHudLayer)
{  
    m_pHudLayer = pHudLayer;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    StageSelectLayer* pStageSelectLayer = (StageSelectLayer*)[appDelegate GetStageSelectLayer];
    [pStageSelectLayer Clear];
    
    m_pUINamePanelWindow = [[FCUINamePanelWindow alloc] init];

    m_pUIGameMainWindow = new FCUIGameMainWindow;
    m_pUIGameMainWindow->Init(m_pHudLayer);
    m_pUIGameMainWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUIGameMainWindow->GetWindowName().hash,m_pUIGameMainWindow));

    m_pUIPausedWindow = new FCUIPausedWindow;
    m_pUIPausedWindow->Init(m_pHudLayer);
    m_pUIPausedWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUIPausedWindow->GetWindowName().hash,m_pUIPausedWindow));
    
    m_pUITitleWindow = new FCUITitleWindow;
    m_pUITitleWindow->Init(m_pHudLayer);
    m_pUITitleWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUITitleWindow->GetWindowName().hash,m_pUITitleWindow));
    
    m_pUIStageSelectWindow = new FCUIStageSelectWindow;
    m_pUIStageSelectWindow->Init(pStageSelectLayer);
    m_pUIStageSelectWindow->SetShow(true);
    m_hashUIWindow.insert(std::make_pair(m_pUIStageSelectWindow->GetWindowName().hash,m_pUIStageSelectWindow));
    
    m_pUIStageStartWindow = new FCUIStageStartWindow;
    m_pUIStageStartWindow->Init(m_pHudLayer);
    m_pUIStageStartWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUIStageStartWindow->GetWindowName().hash,m_pUIStageStartWindow));
    
    m_pUIStageClearWindow = new FCUIStageClearWindow;
    m_pUIStageClearWindow->Init(m_pHudLayer);
    m_pUIStageClearWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUIStageClearWindow->GetWindowName().hash,m_pUIStageClearWindow));
    
    m_pUICreditWindow = new FCUICreditWindow;
    m_pUICreditWindow->Init(m_pHudLayer);
    m_pUICreditWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUICreditWindow->GetWindowName().hash,m_pUICreditWindow));

    m_pUIOptionWindow = new FCUIOptionWindow;
    m_pUIOptionWindow->Init(m_pHudLayer);
    m_pUIOptionWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUIOptionWindow->GetWindowName().hash,m_pUIOptionWindow));

    m_pUIGameOverWindow = new FCUIGameOverWindow;
    m_pUIGameOverWindow->Init(m_pHudLayer);
    m_pUIGameOverWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUIGameOverWindow->GetWindowName().hash,m_pUIGameOverWindow));
    
    m_pUISceneEventWindow = new FCUISceneEventWindow;
    m_pUISceneEventWindow->Init(m_pHudLayer);
    m_pUISceneEventWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUISceneEventWindow->GetWindowName().hash,m_pUISceneEventWindow));
    
    m_pUIContinueWindow = new FCUIContinueWindow;
    m_pUIContinueWindow->Init(m_pHudLayer);
    m_pUIContinueWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUIContinueWindow->GetWindowName().hash,m_pUIContinueWindow));
    
    m_pUIMainOptionWindow = new FCUIMainOptionWindow;
    m_pUIMainOptionWindow->Init(m_pHudLayer);
    m_pUIMainOptionWindow->SetShow(false);
    m_hashUIWindow.insert(std::make_pair(m_pUIMainOptionWindow->GetWindowName().hash,m_pUIMainOptionWindow));
    

    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
        
    FCWorldData* pWorldData = pGameMain->GetWorldData();
    if([pWorldData->GetType() isEqualToString:@"TITLE"])
    {
        m_pUITitleWindow->SetShow(true);
        
        m_pUIGameMainWindow->SetShow(false);
        m_pUIStageSelectWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageClearWindow->SetShow(false);
        m_pUISceneEventWindow->SetShow(false);
        
        [m_pHudLayer SetShowJoy:false];
        [m_pHudLayer SetShowButton:false];
    }
    else if([pWorldData->GetType() isEqualToString:@"STAGE_SELECT"])
    {
        m_pUIStageSelectWindow->SetShow(true);
        
        m_pUIGameMainWindow->SetShow(false);
        m_pUITitleWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageClearWindow->SetShow(false);
        m_pUISceneEventWindow->SetShow(false);
        
        [m_pHudLayer SetShowJoy:false];
        [m_pHudLayer SetShowButton:false];
    }
    else if([pWorldData->GetType() isEqualToString:@"CREDIT"])
    {
        m_pUICreditWindow->SetShow(true);
        
        m_pUIGameMainWindow->SetShow(false);
        m_pUIStageSelectWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageClearWindow->SetShow(false);
        m_pUISceneEventWindow->SetShow(false);
        
        [m_pHudLayer SetShowJoy:false];
        [m_pHudLayer SetShowButton:false];
    }
    else if([pWorldData->GetType() isEqualToString:@"OPTION"])
    {
        m_pUIOptionWindow->SetShow(true);
        
        m_pUIGameMainWindow->SetShow(false);
        m_pUIStageSelectWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageClearWindow->SetShow(false);
        m_pUISceneEventWindow->SetShow(false);
        
        [m_pHudLayer SetShowJoy:false];
        [m_pHudLayer SetShowButton:false];
    }
    else if([pWorldData->GetType() isEqualToString:@"GAME_OVER"])
    {
        m_pUIGameOverWindow->SetShow(true);
        
        m_pUIGameMainWindow->SetShow(false);
        m_pUIStageSelectWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageClearWindow->SetShow(false);
        m_pUISceneEventWindow->SetShow(false);
        
        [m_pHudLayer SetShowJoy:false];
        [m_pHudLayer SetShowButton:false];
    }
    else if([pWorldData->GetType() isEqualToString:@"CONTINUE"])
    {
        m_pUIContinueWindow->SetShow(true);
        
        m_pUIGameMainWindow->SetShow(false);
        m_pUIStageSelectWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageStartWindow->SetShow(false);
        m_pUIStageClearWindow->SetShow(false);
        m_pUISceneEventWindow->SetShow(false);
        m_pUISceneEventWindow->SetShow(false);
        
        [m_pHudLayer SetShowJoy:false];
        [m_pHudLayer SetShowButton:false];
    }
    else if([pWorldData->GetType() isEqualToString:@"GAME"])
    {
        m_pUIGameMainWindow->SetShow(true);
        m_pUIStageStartWindow->SetShow(true);
        
        m_pUIStageClearWindow->SetShow(false);
        m_pUITitleWindow->SetShow(false);
        m_pUIStageSelectWindow->SetShow(false);
        m_pUISceneEventWindow->SetShow(false);
        
        [m_pHudLayer SetShowJoy:true];
        [m_pHudLayer SetShowButton:true];
    }
}

void FCUIWindowManager::Create()
{
    std::map<NSInteger,FCUIWindow*>::iterator it = m_hashUIWindow.begin();
    for(;it != m_hashUIWindow.end();++it)
    {
        FCUIWindow* pUIWindow = (*it).second;
        pUIWindow->Create();
    }
}

void FCUIWindowManager::Process(ccTime dt)
{   
    std::map<NSInteger,FCUIWindow*>::iterator it = m_hashUIWindow.begin();
    for(;it != m_hashUIWindow.end();++it)
    {
        FCUIWindow* pUIWindow = (*it).second;
        pUIWindow->Process(dt);
    }
}

void FCUIWindowManager::SetShow(NSString* pID,const bool bShow)
{
    std::map<NSInteger,FCUIWindow*>::iterator it = m_hashUIWindow.find(pID.hash);
    if(it != m_hashUIWindow.end())
    {
        FCUIWindow* pUIWindow = (*it).second;
        
        pUIWindow->Reset();
        pUIWindow->SetShow(bShow);
    }
}

const bool FCUIWindowManager::GetShow(NSString* pID)
{
    std::map<NSInteger,FCUIWindow*>::iterator it = m_hashUIWindow.find(pID.hash);
    if(it != m_hashUIWindow.end())
    {
        FCUIWindow* pUIWindow = (*it).second;
        return pUIWindow->GetShow();
    }
    
    return false;
}

void FCUIWindowManager::TouchBegan(CGPoint point)
{
    std::map<NSInteger,FCUIWindow*>::iterator it = m_hashUIWindow.begin();
    for(;it != m_hashUIWindow.end();++it)
    {
        FCUIWindow* pUIWindow = (*it).second;
        pUIWindow->TouchBegan(point);
    }
}

void FCUIWindowManager::TouchMoved(CGPoint point)
{
    std::map<NSInteger,FCUIWindow*>::iterator it = m_hashUIWindow.begin();
    for(;it != m_hashUIWindow.end();++it)
    {
        FCUIWindow* pUIWindow = (*it).second;
        pUIWindow->TouchMoved(point);
    }
}

void FCUIWindowManager::TouchEnded(CGPoint point)
{
    std::map<NSInteger,FCUIWindow*>::iterator it = m_hashUIWindow.begin();
    for(;it != m_hashUIWindow.end();++it)
    {
        FCUIWindow* pUIWindow = (*it).second;
        pUIWindow->TouchEnded(point);
    }
}

void FCUIWindowManager::SetState(const int nState)
{
    std::map<NSInteger,FCUIWindow*>::iterator it = m_hashUIWindow.begin();
    for(;it != m_hashUIWindow.end();++it)
    {
        FCUIWindow* pUIWindow = (*it).second;
        pUIWindow->SetState(nState);
    }
}