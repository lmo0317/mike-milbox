#ifndef MikeMooly_FCActionDataManager_h
#define MikeMooly_FCActionDataManager_h

#include <algorithm>
#include <map>
#include <vector>
#include "FCActionData.h"

class FCActionDataManager
{
public:
    void AddActionData(FCActionData* pActionData);
    FCActionData* GetActionData(NSString* pName);
    
    id GetActionSequence(NSString * pName);
    id GetActionElement(FCActionElementSequenceData* pActionElementSequenceData);

private:
    
    std::map<NSInteger ,FCActionData*> m_hashActionData;
};

#endif
