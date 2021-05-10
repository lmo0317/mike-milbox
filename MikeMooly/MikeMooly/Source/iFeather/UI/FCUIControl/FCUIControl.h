#ifndef MikeMooly_FCUIControl_h
#define MikeMooly_FCUIControl_h
#import "FCUIControlData.h"
#import "HUDLayer.h"
#import "FCUIControlDef.h"


class FCUIControl
{
public:
    FCUIControl();
    ~FCUIControl();
    
    virtual void Init(CCLayer* pParentLayer,FCUIControlData* pUIControlData);
    virtual void Create();    
    virtual void SetShow(const bool bShow);
    virtual const bool IsInRect(CGPoint point);
    
    virtual void TouchBegan(CGPoint point);
    virtual void TouchMoved(CGPoint point);
    virtual void TouchEnded(CGPoint point);
    
    virtual void Reset();
    virtual void Delete();
    
    virtual void ClickEvent();
    virtual void ShowEvent();
    
    virtual void SetState(const int nState);
    virtual void SetString(NSString* pString) {}
    virtual CCSprite* GetSprite() {return NULL;}
    virtual void SetFirstTexture() {}
    virtual void SetSecondTexture() {}
    virtual void SetPos(CGPoint pos) {}
    virtual void SetTexture(NSString* strTexture) {}
    
    const int GetState() {return m_nState;}
    
protected:
    
    FCUIControlData* m_pUIControlData;
    CCLayer* m_pParentLayer;
    
    int m_nState;
};

#endif
