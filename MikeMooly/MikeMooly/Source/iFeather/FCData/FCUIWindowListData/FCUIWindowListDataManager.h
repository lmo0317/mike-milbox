#ifndef MikeMooly_FCUIWindowListDataManager_h
#define MikeMooly_FCUIWindowListDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCUIWIndowDataParser.h"
#include "FCUIWindowListData.h"

class FCUIWindowListDataManager
{
public:
    void AddUIWindowListData(FCUIWindowListData* pUIWindowListData);
    FCUIWindowListData* GetUIWindowListData(NSString* pName);
    std::map<NSInteger ,FCUIWindowListData*>* GetUIWindowListDataMap() {return &m_hashUIWindowListData;}
    
    void LoadUIWindowData();
    void AddUIWindowDataParser(NSString* strName);
    FCUIWindowDataParser* GetUIWindowDataParser(NSString* strName);

private:
    
    std::map<NSInteger ,FCUIWindowListData*> m_hashUIWindowListData;
    std::map<NSInteger ,FCUIWindowDataParser*> m_hashUIWindowDataParser;
};

#endif
