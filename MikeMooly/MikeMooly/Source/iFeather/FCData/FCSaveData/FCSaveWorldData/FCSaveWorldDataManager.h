#ifndef MikeMooly_FCSaveWorldDataManager_h
#define MikeMooly_FCSaveWorldDataManager_h

#include <vector>
#include <map>
#import "FCSaveWorldData.h"

class FCSaveWorldDataManager
{    
public:
    FCSaveWorldDataManager();
    ~FCSaveWorldDataManager();

    FCSaveWorldData* AddSaveWorldData(NSString* pID);
    FCSaveWorldData* GetSaveWorldData(NSString *pID);
    std::map<NSInteger,FCSaveWorldData*>* GetSaveWorldDataHash() {return &m_hashSaveWorldData;}
    const int GetPercent();
    void ClearSaveWorldData();
    
private:
    std::map<NSInteger,FCSaveWorldData*> m_hashSaveWorldData;
};


#endif
