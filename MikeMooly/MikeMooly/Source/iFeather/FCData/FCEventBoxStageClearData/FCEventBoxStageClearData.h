#ifndef MikeMooly_FCEventBoxStageClearData_h
#define MikeMooly_FCEventBoxStageClearData_h

#include <map>
#include <vector>
#import "FCStateDataManager.h"

struct FCEventBoxStageClearData
{
public:
    
    FCEventBoxStageClearData();
    ~FCEventBoxStageClearData();
    
    void Copy(FCEventBoxStageClearData* pEventBoxStageClear);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetMapName(NSString* strMapName) {m_strMapName = strMapName;}
    NSString* GetMapName() {return m_strMapName;}
    
    void SetNextStage(NSString* strNextStage) {m_strNextStage = strNextStage;}
    NSString* GetNextStage() {return m_strNextStage;}
    
    void AddStateData(NSString* pID,const int nCategory,NSString *pValue);
    NSString* GetStateData(NSString* pID,const int nCategory);
            
private:
    NSString* m_strName;
    NSString* m_strMapName;
    NSString* m_strNextStage;
    
    FCStateDataManager m_StateDataManager;
};

#endif
