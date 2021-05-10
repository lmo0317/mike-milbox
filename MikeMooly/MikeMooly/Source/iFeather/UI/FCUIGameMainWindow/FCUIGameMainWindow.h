#ifndef MikeMooly_FCUIGameMainWindow_h
#define MikeMooly_FCUIGameMainWindow_h

#import "FCUIWindow.h"
class FCUIGameMainWindow : public FCUIWindow
{
public:
    FCUIGameMainWindow();
    ~FCUIGameMainWindow();
    
    void Init(CCLayer* pParentLayer);
    void Create();
    void Process(ccTime dt);
    
    void TouchBegan(CGPoint point);
    void TouchMoved(CGPoint point);
    void TouchEnded(CGPoint point);
    
    void SetHP(const int nHP);
    void SetLife(const int nLife);
    void SetScore(const int nScore);
    void SetCoin(const int nCoin);
    
    void SetShow(const bool bShow);
    void SetTime(ccTime dTime);
    
    void SetMissionItem(const int nIndex,const bool bShow);
    
private:
    
    FCUIControl* m_pTimeLeft;
    FCUIControl* m_pCurrentScore;
    FCUIControl* m_pMikeLife;
    FCUIControl* m_pCoin;
    
    FCUIControl* m_pHeart[3];
    FCUIControl* m_pHeartOff[3];
    
    FCUIControl* m_pMissionItem[3];
    FCUIControl* m_pMissionItemOff[3];
    
    FCUIControl* m_pPaused;
};


#endif
