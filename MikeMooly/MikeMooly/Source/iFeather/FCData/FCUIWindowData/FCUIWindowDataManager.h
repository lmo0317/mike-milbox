#ifndef MikeMooly_FCUIWindowDataManager_h
#define MikeMooly_FCUIWindowDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCUIWindowData.h"

class FCUIWindowDataManager
{
public:
    void AddUIWindowData(FCUIWindowData* pUIWindowData);
    FCUIWindowData* GetUIWindowData(NSString* pName);

private:
    
    std::map<NSInteger ,FCUIWindowData*> m_hashUIWindowData;
};

#endif
