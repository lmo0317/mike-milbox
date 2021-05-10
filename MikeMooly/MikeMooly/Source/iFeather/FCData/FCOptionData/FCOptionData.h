#ifndef MikeMooly_FCOptionData_h
#define MikeMooly_FCOptionData_h

#include <map>
#include <vector>
#import "FCSaveWorldDataManager.h"

struct FCOptionData
{
public:
    
    FCOptionData();
    ~FCOptionData();
    
    void Copy(FCOptionData* pSave);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetBGM(const bool bBGM) {m_bBGM = bBGM;}
    const bool GetBGM() {return m_bBGM;}

    void SetFX(const bool bFX) {m_bFX = bFX;}
    const bool GetFX() {return m_bFX;}

    void SetControl(const int nControl) {m_nControl = nControl;}
    const int GetControl() {return m_nControl;}

private:
    NSString* m_strName;
    
    bool m_bBGM;
    bool m_bFX;
    int  m_nControl;
};

#endif
