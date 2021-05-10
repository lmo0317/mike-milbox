#ifndef MikeMooly_FCEventBoxPortalData_h
#define MikeMooly_FCEventBoxPortalData_h

#include <map>
#include <vector>
#import "FCStateDataManager.h"

struct FCEventBoxPortalData
{
public:
    
    FCEventBoxPortalData();
    ~FCEventBoxPortalData();
    
    void Copy(FCEventBoxPortalData* pEventBoxPortal);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetMapName(NSString* strMapName) {m_strMapName = strMapName;}
    NSString* GetMapName() {return m_strMapName;}

    void SetEventBoxPositionName(NSString* strEventBoxPositionName) {m_strEventBoxPositionName = strEventBoxPositionName;}
    NSString* GetEventBoxPositionName() {return m_strEventBoxPositionName;}
    
    void SetType(NSString* strType) {m_strType = strType;}
    NSString* GetType() {return m_strType;}
    
    void AddStateData(NSString* pID,const int nCategory,NSString *pValue);
    NSString* GetStateData(NSString* pID,const int nCategory);
            
private:
    NSString* m_strName;
    NSString* m_strMapName;
    NSString* m_strType;
    NSString* m_strEventBoxPositionName;
    
    FCStateDataManager m_StateDataManager;
};

#endif
