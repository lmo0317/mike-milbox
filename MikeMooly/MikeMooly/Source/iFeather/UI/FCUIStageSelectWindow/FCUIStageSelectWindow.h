#ifndef MikeMooly_FCUIStageSelectWindow_h
#define MikeMooly_FCUIStageSelectWindow_h

#import "FCUIStageSelectWindowDef.h"
#import "FCUIWindow.h"
#import "FCUIControlButton.h"
#import "FCUIControlSprite.h"

class FCUIStageSelectWindow : public FCUIWindow
{
public:
    FCUIStageSelectWindow();
    ~FCUIStageSelectWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetShow(const bool bShow);
    void Reset();
    void ResetStar();
    void InitMark();
    
private:
    FCUIControl* m_pMark;
    FCUIControl* m_pTitle[4];
    FCUIControl* m_pLiteButton[3];

    FCUIControl* m_pNumber[STAGE_COUNT][MAP_COUNT];
    FCUIControl* m_pButton[STAGE_COUNT][MAP_COUNT];
    FCUIControl* m_pStar[STAGE_COUNT][MAP_COUNT][3];
};


#endif
