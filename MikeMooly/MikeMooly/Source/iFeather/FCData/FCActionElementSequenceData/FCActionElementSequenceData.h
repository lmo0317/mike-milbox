#ifndef MikeMooly_FCActionElementSequenceData_h
#define MikeMooly_FCActionElementSequenceData_h

#include <vector>
#include <map>
#import "FCActionElementDataManager.h"
class FCActionElementSequenceData
{
public:
    
    FCActionElementSequenceData();
    ~FCActionElementSequenceData();
    
    FCActionElementDataManager* GetACtionElementDataManager() {return m_pActionElementDataManager;}
    
private:
    
    FCActionElementDataManager* m_pActionElementDataManager;
};

#endif
