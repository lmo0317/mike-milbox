#ifndef MikeMooly_FCUIGameOverWindow_h
#define MikeMooly_FCUIGameOverWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUIGameOverWindow : public FCUIWindow
{
public:
    FCUIGameOverWindow();
    ~FCUIGameOverWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetShow(const bool bShow);
    void SetSaveData();
    
private:
    
    FCUIControl* m_pNo;
};


#endif
