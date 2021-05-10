#ifndef FC_Motion_Parser
#define FC_Motion_Parser

#import "FCMotionDataManager.h"

class FCMotionParser
{
public:
    void Init();
    void LoadMotionData();
    NSString* dataFilePath();
    FCMotionDataManager* GetMotionDataManager();

private:
    
    FCMotionDataManager *m_pMotionDataManager;
};


#endif
