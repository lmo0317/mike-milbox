#ifndef MikeMooly_FCShootData_h
#define MikeMooly_FCShootData_h

#include <map>
#include <vector>

struct FCShootData 
{
public:
    
    FCShootData();
    ~FCShootData();
    
    void Copy(FCShootData* pShootData);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetLifeTime(const float fLifeTime);
    float GetLifeTime();

private:
    NSString* m_strName;
    float m_fLifeTime;
};

#endif
