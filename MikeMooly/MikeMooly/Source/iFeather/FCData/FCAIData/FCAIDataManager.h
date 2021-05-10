#ifndef MikeMooly_FCAIDataManager_h
#define MikeMooly_FCAIDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCAIData.h"

class FCAIDataManager
{
public:
    void AddAIData(FCAIData* pAIData);
    FCAIData* GetAIData(NSString* pName);

private:
    
    std::map<NSInteger ,FCAIData*> m_hashAIData;
};

#endif
