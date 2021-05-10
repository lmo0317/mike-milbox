#ifndef MikeMooly_FCHitBoxData_h
#define MikeMooly_FCHitBoxData_h

#include <map>
#include <vector>

struct FCHitBoxData
{
public:
    
    FCHitBoxData();
    ~FCHitBoxData();
    
    void Copy(FCHitBoxData* pHitBoxData);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetLifeTime(const float fLifeTime);
    const float GetLifeTime();

private:
    NSString* m_strName;
    float m_fLifeTime;
};

#endif
