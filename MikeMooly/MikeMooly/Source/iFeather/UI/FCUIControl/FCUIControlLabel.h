#ifndef MikeMooly_FCUIControlLabel_h
#define MikeMooly_FCUIControlLabel_h

#import "FCUIControl.h"
class FCUIControlLabel : public FCUIControl
{
public:
    FCUIControlLabel();
    ~FCUIControlLabel();
    
    void Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData);
    void Create();
    void SetString(NSString* pString);
    void SetShow(const bool bShow);
    
    const bool IsInRect(CGPoint point);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetState(const int nState);
    void Reset();
    void Delete();
    
    void ClickEvent();
    void ShowEvent();
    
private:
    
    CCLabelBMFont * m_pLabelBMFont;
};

#endif
