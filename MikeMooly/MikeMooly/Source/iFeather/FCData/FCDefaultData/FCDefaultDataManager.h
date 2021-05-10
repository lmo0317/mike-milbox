#ifndef MikeMooly_FCDefaultDataManager_h
#define MikeMooly_FCDefaultDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCDefaultData.h"

class FCDefaultDataManager
{
public:
    void AddDefaultData(FCDefaultData* pDefaultData);
    FCDefaultData* GetDefaultData(NSString* pName);

private:
    
    std::map<NSInteger ,FCDefaultData*> m_hashDefaultData;
};

#endif
