#ifndef MikeMooly_FCUIStageStartWindow_h
#define MikeMooly_FCUIStageStartWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUIStageStartWindow : public FCUIWindow
{
public:
    FCUIStageStartWindow();
    ~FCUIStageStartWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetUIStageName(NSString* strUIStageName);
    NSString* GetUIStageName() {return m_strUIStageName;}
    
    void SetUIStageSprite(NSString* strUIStageSprite);
    NSString* GetUIStageSprite() {return m_strUIStageSprite;}
    
    void SetShow(const bool bShow);
    
private:
  
    ccTime m_dCurTime;
    
    NSString* m_strUIStageName;
    NSString* m_strUIStageSprite;
    
    FCUIControl* m_pUIStageSprite;
    FCUIControl* m_pUIStageName;
};


#endif
