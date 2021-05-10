#ifndef MikeMooly_FCOptionDataManager_h
#define MikeMooly_FCOptionDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCOptionData.h"

class FCOptionDataManager
{
public:
    void AddOptionData(FCOptionData* pOptionData);
    FCOptionData* GetOptionData(NSString* pName);
    
    std::map<NSInteger ,FCOptionData*>* GetOptionDataMap() {return &m_hashOptionData;}

private:
    
    std::map<NSInteger ,FCOptionData*> m_hashOptionData;
};

#endif
