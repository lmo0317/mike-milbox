#ifndef MikeMooly_FCSaveData_h
#define MikeMooly_FCSaveData_h

#include <map>
#include <vector>
#import "FCSaveWorldDataManager.h"

struct FCSaveData
{
public:
    
    FCSaveData();
    ~FCSaveData();
    
    void Copy(FCSaveData* pSave);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetLife(const int nLife) {m_nLife = nLife;}
    const int GetLife() {return m_nLife;}
    
    void SetHP(const int nHP) {m_nHP = nHP;}
    const int GetHP() {return m_nHP;}
    
    void SetScore(const int nScore) {m_nScore = nScore;}
    const int GetScore() {return m_nScore;}
    
    void SetContinueCount(const int nContinueCount) {m_nContinueCount = nContinueCount;}
    const int GetContinueCount() {return m_nContinueCount;}
    
    void SetCoin(const int nCoin) {m_nCoin = nCoin;}
    const int GetCoin() {return m_nCoin;}
    
    FCSaveWorldData* AddSaveWorldData(NSString* pID);
    FCSaveWorldData* GetSaveWorldData(NSString* pID);
    FCSaveWorldDataManager* GetSaveWorldDataManager() {return &m_SaveWorldDataManager;}

private:
    NSString* m_strName;
    int m_nLife;
    int m_nHP;
    int m_nScore;
    int m_nContinueCount;
    int m_nCoin;
    
    FCSaveWorldDataManager m_SaveWorldDataManager;
};

#endif
