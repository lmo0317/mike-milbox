#ifndef MikeMooly_FCEventBoxStageClearDataManager_h
#define MikeMooly_FCEventBoxStageClearDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCEventBoxStageClearData.h"

class FCEventBoxStageClearDataManager
{
public:
    void AddEventBoxStageClearData(FCEventBoxStageClearData* pEventBoxStageClearData);
    FCEventBoxStageClearData* GetEventBoxStageClearData(NSString* pName);

private:
    
    std::map<NSInteger ,FCEventBoxStageClearData*> m_hashEventBoxStageClearData;
};

#endif
