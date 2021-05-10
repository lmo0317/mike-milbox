#ifndef MikeMooly_FCGimmickDataManager_h
#define MikeMooly_FCGimmickDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCGimmickData.h"

class FCGimmickDataManager
{
public:
    void AddGimmickData(FCGimmickData* pGimmickData);
    FCGimmickData* GetGimmickData(NSString* pName);

private:
    
    std::map<NSInteger ,FCGimmickData*> m_hashGimmickData;
};

#endif
