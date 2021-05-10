#ifndef MikeMooly_FCActionElementSequenceDataManager_h
#define MikeMooly_FCActionElementSequenceDataManager_h

#include <vector>
#include <map>
#import "FCActionElementSequenceData.h"

class FCActionElementSequenceDataManager
{
public:
    FCActionElementSequenceData* AddActionElementSequenceData();
    std::vector<FCActionElementSequenceData*>* GetActionElementSequenceDataVector() {return &m_vecActionElementSequenceData;}
    
private:
    
    std::vector<FCActionElementSequenceData*> m_vecActionElementSequenceData;
};

#endif

