#ifndef MikeMooly_FCHitBoxDataManager_h
#define MikeMooly_FCHitBoxDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCHitBoxData.h"

class FCHitBoxDataManager
{
public:
    void AddHitBoxData(FCHitBoxData* pHitBoxData);
    FCHitBoxData* GetHitBoxData(NSString* pName);

private:
    
    std::map<NSInteger ,FCHitBoxData*> m_hashHitBoxData;
};

#endif
