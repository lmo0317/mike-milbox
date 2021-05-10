#ifndef MikeMooly_FCUIControlCheckButton_h
#define MikeMooly_FCUIControlCheckButton_h

#import "FCUIControl.h"
class FCUIControlCheckButton : public FCUIControl
{
public:
    FCUIControlCheckButton();
    ~FCUIControlCheckButton();
    
    CCSprite* GetSprite() {return m_pSprite;}
    void Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData);
    void Create();
    void SetShow(const bool bShow);
    const bool IsInRect(CGPoint point);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetState(const int nState);
    
    void Click();
    void Reset();
    void Delete();
    
    void ClickEvent();
    void ShowEvent();
    
    void Selector();
    
private:
    
    CCSprite* m_pSprite;
    CCTexture2D *m_pNormalTexture;
    CCTexture2D *m_pCheckedTexture;
};


#endif
