#ifndef MikeMooly_FCUIWindowManager_h
#define MikeMooly_FCUIWindowManager_h

#import "FCUIWindowListData.h"
#import "FCUIWindow.h"
#import "FCUIGameMainWindow.h"
#import "FCUIPausedWindow.h"
#import "FCUITitleWindow.h"
#import "FCUIStageSelectWindow.h"
#import "FCUIStageStartWindow.h"
#import "FCUIStageClearWindow.h"
#import "FCUINamePanelWindow.h"
#import "FCUICreditWindow.h"
#import "FCUIGameOverWindow.h"
#import "FCUIContinueWindow.h"
#import "FCUIOptionWindow.h"
#import "FCUISceneEventWindow.h"
#import "FCUIMainOptionWindow.h"
#import "HUDLayer.h"
#import "StageSelectLayer.h"

class FCUIWindowManager
{
public:
    FCUIWindowManager();
    ~FCUIWindowManager();
    
    void Init(HUDLayer* pHudLayer);

    void Create();
    void Process(ccTime dt);
    void SetShow(NSString* pID,const bool bShow);
    const bool GetShow(NSString* pID);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    FCUIGameMainWindow*     GetGameMainWindow()     {return m_pUIGameMainWindow;}
    FCUIPausedWindow*       GetPausedWindow()       {return m_pUIPausedWindow;}
    FCUITitleWindow*        GetTitleWindow()        {return m_pUITitleWindow;}
    FCUIStageSelectWindow*  GetStageSelectWindow()  {return m_pUIStageSelectWindow;}
    FCUIStageStartWindow*   GetStageStartWindow()   {return m_pUIStageStartWindow;}
    FCUIStageClearWindow*   GetStageClearWindow()   {return m_pUIStageClearWindow;}
    FCUINamePanelWindow*    GetNamePanelWindow()    {return m_pUINamePanelWindow;}
    FCUICreditWindow*       GetCreditWindow()       {return m_pUICreditWindow;}
    FCUIGameOverWindow*     GetGameOverWindow()     {return m_pUIGameOverWindow;}
    FCUIContinueWindow*     GetContinueWindow()     {return m_pUIContinueWindow;}
    FCUIOptionWindow*       GetOptionWindow()       {return m_pUIOptionWindow;}
    FCUISceneEventWindow*   GetSceneEventWindow()   {return m_pUISceneEventWindow;}
    FCUIMainOptionWindow*   GetMainOptionWindow()   {return m_pUIMainOptionWindow;}
    
    void SetState(const int nState);

private:
    HUDLayer* m_pHudLayer;

    //c++
    FCUIGameMainWindow*     m_pUIGameMainWindow;
    FCUIPausedWindow*       m_pUIPausedWindow;
    FCUITitleWindow*        m_pUITitleWindow;
    FCUIStageSelectWindow*  m_pUIStageSelectWindow;
    FCUIStageStartWindow*   m_pUIStageStartWindow;
    FCUIStageClearWindow*   m_pUIStageClearWindow;
    FCUICreditWindow*       m_pUICreditWindow;
    FCUIGameOverWindow*     m_pUIGameOverWindow;
    FCUIWindowListData*     m_pUIWindowListData;
    FCUIContinueWindow*     m_pUIContinueWindow;
    FCUIOptionWindow*       m_pUIOptionWindow;
    FCUISceneEventWindow*   m_pUISceneEventWindow;
    FCUIMainOptionWindow*   m_pUIMainOptionWindow;
    
    //object-c
    FCUINamePanelWindow* m_pUINamePanelWindow;

    std::map<NSInteger,FCUIWindow*> m_hashUIWindow;
};

#endif
