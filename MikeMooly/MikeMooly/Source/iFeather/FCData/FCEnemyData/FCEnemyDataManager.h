#ifndef MikeMooly_FCEnemyDataManager_h
#define MikeMooly_FCEnemyDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCEnemyData.h"

class FCEnemyDataManager
{
public:
    void AddEnemyData(FCEnemyData* pEnemyData);
    FCEnemyData* GetEnemyData(NSString* pName);

private:
    
    std::map<NSInteger ,FCEnemyData*> m_hashEnemyData;
};

#endif
