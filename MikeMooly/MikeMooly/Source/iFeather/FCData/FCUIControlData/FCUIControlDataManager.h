#ifndef MikeMooly_FCUIControlDataManager_h
#define MikeMooly_FCUICOntrolDataManager_h

#include <vector>
#include <map>
#import "FCUIControlData.h"

class FCUIControlDataManager
{
public:
    FCUIControlData* AddUIControlData(NSString* pID);
    FCUIControlData* GetUIControlData(NSString *pID);
    
    std::map<NSInteger,FCUIControlData*>* GetUIControlDataHash() {return &m_hashUIControlData;}
    
private:
    std::map<NSInteger,FCUIControlData*> m_hashUIControlData;
};

#endif

