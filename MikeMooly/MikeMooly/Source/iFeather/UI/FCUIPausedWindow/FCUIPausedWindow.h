#ifndef MikeMooly_FCUIPausedWindow_h
#define MikeMooly_FCUIPausedWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUIPausedWindow : public FCUIWindow
{
public:
    FCUIPausedWindow();
    ~FCUIPausedWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetShow(const bool bShow);
    
private:
    
    FCUIControl* m_pStageSelect;
    FCUIControl* m_pMainMenu;
    FCUIControl* m_pOption;
    FCUIControl* m_pRestart;
    FCUIControl* m_pClose;
};


#endif
