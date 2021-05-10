#ifndef MikeMooly_FCUIWindowData_h
#define MikeMooly_FCUIWindowData_h

#include <map>
#include <vector>

#import "FCUIControlDataManager.h"

struct FCUIWindowData
{
public:
    
    FCUIWindowData();
    ~FCUIWindowData();
    
    void Copy(FCUIWindowData* pUIWindow);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    FCUIControlData* AddUIControlData(NSString* pID);
    FCUIControlData* GetUIControlData(NSString *pID);
    
    std::map<NSInteger,FCUIControlData*>* GetUIControlDataHash();
    
private:
    NSString* m_strName;
    FCUIControlDataManager m_UIControlDataManager;
};

#endif
