#ifndef MikeMooly_FCFieldItemData_h
#define MikeMooly_FCFieldItemData_h

#include <map>
#include <vector>
#import "FCStateDataManager.h"

struct FCFieldItemData
{
public:
    
    FCFieldItemData();
    ~FCFieldItemData();
    
    void Copy(FCFieldItemData* pFieldItem);
    
    void SetName(NSString* strName) {m_strName = strName;}
    NSString* GetName() {return m_strName;}
    
    void SetCategory(NSString* strCategory) {m_strCategory = strCategory;}
    NSString* GetCategory() {return m_strCategory;}
    
    void SetScore(const int nScore) {m_nScore = nScore;}
    const int GetScore() {return m_nScore;}
    
    void SetMissionItemID(const int nMissionItemID) {m_nMissionItemID = nMissionItemID;}
    const int GetMissionItemID() {return m_nMissionItemID;}
        
    void AddStateData(NSString* pID,const int nCategory,NSString *pValue);
    NSString* GetStateData(NSString* pID,const int nCategory);
    
private:
    NSString* m_strName;    
    NSString* m_strCategory;
    int m_nScore;
    int m_nMissionItemID;
    FCStateDataManager m_StateDataManager;
};

#endif
