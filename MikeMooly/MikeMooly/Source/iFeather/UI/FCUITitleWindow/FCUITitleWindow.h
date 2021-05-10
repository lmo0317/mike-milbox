#ifndef MikeMooly_FCUITitleWindow_h
#define MikeMooly_FCUITitleWindow_h

#import "FCUIWindow.h"
#import "FCUIControlButton.h"

class FCUITitleWindow : public FCUIWindow
{
public:
    FCUITitleWindow();
    ~FCUITitleWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetShow(const bool bShow);
    void SetSlotPercent(const int nIndex,const int nPercent);
    void InitSlotPercent();
    
    void SetShowSlot(const bool bShow);
    void SetShowCaution(const bool bShow);
    
private:
    
    //FCUIControl* m_pFaceBook;
    //FCUIControl* m_pTwitter;
    
    FCUIControl* m_pCredit;
    FCUIControl* m_pOption;
    FCUIControl* m_pDeleteYes;
    FCUIControl* m_pDeleteNo;
    FCUIControl* m_pSlot[3];
    FCUIControl* m_pDelete[3];
    FCUIControl* m_pSlotPercent[3];
    FCUIControl* m_pSlotSprite[3];    
    FCUIControl* m_pCaution;
    
    int m_nDeleteIndex;
};


#endif
