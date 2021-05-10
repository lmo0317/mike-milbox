#ifndef MikeMooly_FCUIStageClearWindow_h
#define MikeMooly_FCUIStageClearWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUIStageClearWindow : public FCUIWindow
{
public:
    FCUIStageClearWindow();
    ~FCUIStageClearWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetNextStage(NSString* strNextStage) {m_strNextStage = strNextStage;}
    NSString* GetNextStage() {return m_strNextStage;}
    
    void SetShow(const bool bShow);
    void StarClear();
    void SetStarShow(const int nIndex,const bool bShow);
    void EndAddScore();

    void SetShowButton(const bool bShow);
    
    void SetMessageString(NSString* strMessage);
private:
  
    FCUIControl* m_pRestartLabel;
    FCUIControl* m_pNextLabel;
    FCUIControl* m_pStageSelectLabel;
    FCUIControl* m_pRestartSprite;
    FCUIControl* m_pNextSprite;
    FCUIControl* m_pStageSelectSprite;
    FCUIControl* m_pRestartButton;
    FCUIControl* m_pNextButton;
    FCUIControl* m_pStageSelectButton;
    FCUIControl* m_pStar[3];
    FCUIControl* m_pMessage;
    
    ccTime m_dCurTime;
    NSString* m_strNextStage;
    int m_nScore;
};


#endif
