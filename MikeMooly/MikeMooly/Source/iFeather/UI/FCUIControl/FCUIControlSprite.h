#ifndef MikeMooly_FCUIControlSprite_h
#define MikeMooly_FCUIControlSprite_h

#import "FCUIControl.h"
class FCUIControlSprite : public FCUIControl
{
public:
    FCUIControlSprite();
    ~FCUIControlSprite();
    
    CCSprite* GetSprite() {return m_pSprite;}
    void Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData);
    void Create();
    void SetShow(const bool bShow);
    
    const bool IsInRect(CGPoint point);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    void SetTexture(NSString* strTexture);
    
    void SetState(const int nState);
    void Reset();
    void Delete();
    
    void ClickEvent();
    void ShowEvent();
    
    void SetPos(CGPoint pos);
    
    void SetFirstTexture();
    void SetSecondTexture();
    
private:
    
    CCSprite* m_pSprite;
    
    CCTexture2D *m_pFirstTexture;
    CCTexture2D *m_pSecondTexture;

};

#endif
