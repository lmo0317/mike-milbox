#ifndef MikeMooly_FCUIContinueWindow_h
#define MikeMooly_FCUIContinueWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUIContinueWindow : public FCUIWindow
{
public:
    FCUIContinueWindow();
    ~FCUIContinueWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetShow(const bool bShow);
    void SetSaveData();
    
    void SetContinueCount(const int nContinueCount);
    
private:
    
    FCUIControl* m_pYes;
    FCUIControl* m_pNo;
    FCUIControl* m_pContinueCount;
};


#endif
