#ifndef FC_WORLD_DATA_PARSER
#define FC_WORLD_DATA_PARSER

#import "FCWorldDataManager.h"

class FCWorldDataParser
{
public:
    void Init();
    void LoadWorldData();
    NSString* dataFilePath();
    FCWorldDataManager* GetWorldDataManager();

private:
    
    FCWorldDataManager *m_pWorldDataManager;
};


#endif
