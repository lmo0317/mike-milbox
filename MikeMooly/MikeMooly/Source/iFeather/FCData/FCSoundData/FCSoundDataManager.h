#ifndef MikeMooly_FCSoundDataManager_h
#define MikeMooly_FCSoundDataManager_h

#include <vector>
#include <map>
#import "FCSoundData.h"

class FCSoundDataManager
{
public:
    void AddSoundData(NSString* pID,const int nCategory,NSString* pValue);
    NSString* GetSoundData(NSString *pID,const int nCategory);

    
private:
    std::map<NSInteger,FCSoundData*> m_hashSoundData;
};

#endif

