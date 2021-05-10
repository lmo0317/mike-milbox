#ifndef MikeMooly_FCPlayerDataManager_h
#define MikeMooly_FCPlayerDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCPlayerData.h"

class FCPlayerDataManager
{
public:
    void AddPlayerData(FCPlayerData* pPlayerData);
    FCPlayerData* GetPlayerData(NSString* pName);

private:
    
    std::map<NSInteger ,FCPlayerData*> m_hashPlayerData;
};

#endif
