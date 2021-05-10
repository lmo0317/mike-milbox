#ifndef MikeMooly_FCWorldDataManager_h
#define MikeMooly_FCWorldDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCWorldData.h"

class FCWorldDataManager
{
public:
    void AddWorldData(FCWorldData* pWorldData);
    FCWorldData* GetWorldData(NSString* pName);
    
    std::map<NSInteger ,FCWorldData*>* GetWorldDatMap() {return &m_hashWorldData;}

private:
    
    std::map<NSInteger ,FCWorldData*> m_hashWorldData;
};

#endif
