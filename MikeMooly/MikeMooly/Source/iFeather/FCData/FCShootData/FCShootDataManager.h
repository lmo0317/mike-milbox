#ifndef MikeMooly_FCShootDataManager_h
#define MikeMooly_FCShootDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCShootData.h"

class FCShootDataManager
{
public:
    void AddShootData(FCShootData* pShootData);
    FCShootData* GetShootData(NSString* pName);

private:
    
    std::map<NSInteger ,FCShootData*> m_hashShootData;
};

#endif
