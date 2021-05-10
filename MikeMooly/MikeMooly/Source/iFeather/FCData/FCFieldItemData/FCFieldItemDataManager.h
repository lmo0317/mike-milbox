#ifndef MikeMooly_FCFieldItemDataManager_h
#define MikeMooly_FCFieldItemDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCFieldItemData.h"

class FCFieldItemDataManager
{
public:
    void AddFieldItemData(FCFieldItemData* pFieldItemData);
    FCFieldItemData* GetFieldItemData(NSString* pName);

private:
    
    std::map<NSInteger ,FCFieldItemData*> m_hashFieldItemData;
};

#endif
