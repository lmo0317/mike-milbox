#ifndef MikeMooly_FCStateDataManager_h
#define MikeMooly_FCStateDataManager_h

#include <vector>
#include <map>
#import "FCStateData.h"

class FCStateDataManager
{
public:
    void AddStateData(NSString* pID,const int nCategory,NSString* pValue);
    NSString* GetStateData(NSString *pID,const int nCategory);

    
private:
    std::map<NSInteger,FCStateData*> m_hashStateData;
};

#endif

