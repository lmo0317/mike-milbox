#ifndef MikeMooly_FCActionElementDataManager_h
#define MikeMooly_FCActionElementDataManager_h

#include <vector>
#include <map>
#import "FCActionElementData.h"
class FCActionElementDataManager
{
public:
    FCActionElementData* AddActionElementData();
    std::vector<FCActionElementData*>* GetActionElementDataVector() {return &m_vecActionElementData;}
        
private:
    
    std::vector<FCActionElementData*> m_vecActionElementData;
};

#endif

