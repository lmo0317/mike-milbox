#ifndef MikeMooly_FCStateData_h
#define MikeMooly_FCStateData_h

#include <vector>
#include <map>

class FCStateData
{
public:
    
    void AddValue(const int nCategory,NSString* pValue);
    void SetValue(const int nCategory,NSString* pValue);
    NSString* GetValue(const int nCategory);

    NSString* GetID() {return m_pID;}
    void SetID(NSString* pID) {m_pID = pID;}
    
private:
    
    NSString* m_pID;
    std::map<int,NSString*> m_hashValue;
};

#endif
