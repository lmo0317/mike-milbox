#ifndef MikeMooly_FCUIWindow_h
#define MikeMooly_FCUIWindow_h

#import "FCUIWindowDataParser.h"
#import "HUDLayer.h"

#import "FCUIControlSprite.h"
#import "FCUIControlLabel.h"
#import "FCUIControlButton.h"
#import "FCUIControlCheckButton.h"

class FCUIWindow
{
public:
    FCUIWindow();
    ~FCUIWindow();
    
    virtual void Init(CCLayer* pParentLayer);
    virtual void Create();
    virtual void Process(ccTime dt);
    virtual void Reset();
    
    void SetWindowDataParser(FCUIWindowDataParser* pParser) {m_pParser = pParser;}
    FCUIWindowDataParser* GetWindowDataParser() {return m_pParser;}
      
    void CreateControl(FCUIControlData* pUIControlData);
    FCUIControl* GetControl(NSString* pID);

    virtual void SetShow(const bool bShow);
    const bool GetShow();
    
    NSString* GetWindowName() {return m_pWindowData->GetName();}
    
    virtual void TouchBegan(CGPoint point);
    virtual void TouchMoved(CGPoint point);
    virtual void TouchEnded(CGPoint point);
    

    void ShowEvent();
    
    void SetState(const int nState);
    
protected:
    
    FCUIWindowDataParser* m_pParser;
    FCUIWindowData* m_pWindowData;
    CCLayer* m_pParentLayer;
    
    std::map<NSInteger,FCUIControl*> m_hashUIControl;
    bool m_bShow;
};


#endif
