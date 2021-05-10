#ifndef MikeMooly_FCBlockData_h
#define MikeMooly_FCBlockData_h

#include <map>
#include <vector>
#import "FCStateDataManager.h"

struct FCBlockData
{
public:
    
    FCBlockData();
    ~FCBlockData();
    
    void Copy(FCBlockData* pHitDataInfo);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetHP(const int nHP) {m_nHP = nHP;}
    const int GetHP() {return m_nHP;}
    
    void SetScore(const int nScore) {m_nScore = nScore;}
    const int GetScore() {return m_nScore;}
    
    void AddStateData(NSString* pID,const int nCategory,NSString *pValue);
    NSString* GetStateData(NSString* pID,const int nCategory);
    
private:
    NSString* m_strName;
    int m_nHP;
    int m_nScore;
    
    FCStateDataManager m_StateDataManager;
};

#endif
