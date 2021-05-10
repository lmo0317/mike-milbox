#ifndef MikeMooly_FCGimmickData_h
#define MikeMooly_FCGimmickData_h

#include <map>
#include <vector>

struct FCGimmickData
{
public:
    
    FCGimmickData();
    ~FCGimmickData();
    
    void Copy(FCGimmickData* pGimmickData);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetLifeTime(const float fLifeTime);
    const float GetLifeTime();
    
    void SetTarget(NSString* strTarget) {m_strTarget = strTarget;}
    NSString* GetTarget() {return m_strTarget;}
    
    void SetOneShot(const bool bOneShot) {m_bOneShot = bOneShot;}
    const bool GetOneShot() {return m_bOneShot;}

private:
    NSString* m_strName;
    NSString* m_strTarget;
    float m_fLifeTime;
    
    bool m_bOneShot;
};

#endif
