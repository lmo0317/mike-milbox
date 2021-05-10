#ifndef MikeMooly_FCUIMainOptionWindow_h
#define MikeMooly_FCUIMainOptionWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUIMainOptionWindow : public FCUIWindow
{
public:
    FCUIMainOptionWindow();
    ~FCUIMainOptionWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetShow(const bool bShow);
    void SaveOption();
    
private:
    
    FCUIControl* m_pTitle;
    FCUIControl* m_pBGM;
    FCUIControl* m_pFX;
    FCUIControl* m_pControl[2];
    
    FCUIControl* m_pClose;
};


#endif
