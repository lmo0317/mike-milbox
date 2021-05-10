#ifndef MikeMooly_FCDefaultData_h
#define MikeMooly_FCDefaultData_h

#include <map>
#include <vector>
#import "FCSoundDataManager.h"

struct FCDefaultData
{
public:
    
    FCDefaultData();
    ~FCDefaultData();
    
    void Copy(FCDefaultData* pDefault);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetLife(const int nLife) {m_nLife = nLife;}
    const int GetLife() {return m_nLife;}
    
    void SetHP(const int nHP) {m_nHP = nHP;}
    const int GetHP() {return m_nHP;}
    
    void SetContinueCount(const int nContinueCount) {m_nContinueCount = nContinueCount;}
    const int GetContinueCount() {return m_nContinueCount;}
    
    void AddSoundData(NSString* pID,const int nCategory,NSString *pValue);
    NSString* GetSoundData(NSString* pID,const int nCategory);
    
private:
    NSString* m_strName;
    int m_nLife;
    int m_nHP;
    int m_nContinueCount;
    
    FCSoundDataManager m_SoundDataManager;
};

#endif
