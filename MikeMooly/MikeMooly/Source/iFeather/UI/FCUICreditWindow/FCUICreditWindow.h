#ifndef MikeMooly_FCUICreditWindow_h
#define MikeMooly_FCUICreditWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUICreditWindow : public FCUIWindow
{
public:
    FCUICreditWindow();
    ~FCUICreditWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetShow(const bool bShow);
    
private:

    FCUIControl* m_pTitle;
};


#endif
