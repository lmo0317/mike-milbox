#ifndef MikeMooly_FCEventBoxCheckPointData_h
#define MikeMooly_FCEventBoxCheckPointData_h

#include <map>
#include <vector>
#import "FCStateDataManager.h"

struct FCEventBoxCheckPointData
{
public:
    
    FCEventBoxCheckPointData();
    ~FCEventBoxCheckPointData();
    
    void Copy(FCEventBoxCheckPointData* pEventBoxCheckPoint);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetMapName(NSString* strMapName) {m_strMapName = strMapName;}
    NSString* GetMapName() {return m_strMapName;}
            
    void AddStateData(NSString* pID,const int nCategory,NSString *pValue);
    NSString* GetStateData(NSString* pID,const int nCategory);

private:
    NSString* m_strName;
    NSString* m_strMapName;
    
    FCStateDataManager m_StateDataManager;
};

#endif
