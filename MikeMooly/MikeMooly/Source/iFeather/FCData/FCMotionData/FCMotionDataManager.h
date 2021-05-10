#ifndef MikeMooly_FCMotionDataManager_h
#define MikeMooly_FCMotionDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCMotionData.h"

class FCMotionDataManager
{
public:
    void AddMotionData(FCMotionData* pEnemyData);
    FCMotionData* GetMotionData(NSString* pName);

private:
    
    std::map<NSInteger ,FCMotionData*> m_hashMotionData;
};

#endif
