#ifndef MikeMooly_FCSaveDataManager_h
#define MikeMooly_FCSaveDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCSaveData.h"

class FCSaveDataManager
{
public:
    void AddSaveData(FCSaveData* pSaveData);
    FCSaveData* GetSaveData(NSString* pName);
    
    std::map<NSInteger ,FCSaveData*>* GetSaveDataMap() {return &m_hashSaveData;}

private:
    
    std::map<NSInteger ,FCSaveData*> m_hashSaveData;
};

#endif
