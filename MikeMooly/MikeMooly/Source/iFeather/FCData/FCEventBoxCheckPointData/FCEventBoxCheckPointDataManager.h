#ifndef MikeMooly_FCEventBoxCheckPointDataManager_h
#define MikeMooly_FCEventBoxCheckPointDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCEventBoxCheckPointData.h"

class FCEventBoxCheckPointDataManager
{
public:
    
    void AddEventBoxCheckPointData(FCEventBoxCheckPointData* pEventBoxCheckPointData);
    FCEventBoxCheckPointData* GetEventBoxCheckPointData(NSString* pName);
     
private:
    
    std::map<NSInteger,FCEventBoxCheckPointData*> m_hashEventBoxCheckPointData;
    
};

#endif