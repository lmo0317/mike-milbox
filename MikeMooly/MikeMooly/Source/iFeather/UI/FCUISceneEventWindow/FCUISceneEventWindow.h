#ifndef MikeMooly_FCUISceneEventWindow_h
#define MikeMooly_FCUISceneEventWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUISceneEventWindow : public FCUIWindow
{
public:
    FCUISceneEventWindow();
    ~FCUISceneEventWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetShow(const bool bShow);
    FCUIControl* GetBlackControl() {return m_pBlack;};
    
private:
    
    FCUIControl* m_pBlack;
};


#endif
