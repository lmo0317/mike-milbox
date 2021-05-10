#ifndef MikeMooly_FCBlockDataManager_h
#define MikeMooly_FCBlockDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCBlockData.h"

class FCBlockDataManager
{
public:
    void AddBlockData(FCBlockData* pBlockData);
    FCBlockData* GetBlockData(NSString* pName);

private:
    
    std::map<NSInteger ,FCBlockData*> m_hashBlockData;
};

#endif
