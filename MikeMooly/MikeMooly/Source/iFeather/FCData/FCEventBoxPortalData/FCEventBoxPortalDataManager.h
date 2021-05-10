#ifndef MikeMooly_FCEventBoxPortalDataManager_h
#define MikeMooly_FCEventBoxPortalDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCEventBoxPortalData.h"

class FCEventBoxPortalDataManager
{
public:
    void AddEventBoxPortalData(FCEventBoxPortalData* pEventBoxPortalData);
    FCEventBoxPortalData* GetEventBoxPortalData(NSString* pName);

private:
    
    std::map<NSInteger ,FCEventBoxPortalData*> m_hashEventBoxPortalData;
};

#endif
