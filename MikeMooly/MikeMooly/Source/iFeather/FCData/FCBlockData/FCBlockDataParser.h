#ifndef FC_BLOCK_DATA_PARSER
#define FC_BLOCK_DATA_PARSER

#import "FCBlockDataManager.h"

class FCBlockDataParser
{
public:
    void Init();
    void LoadBlockData();
    NSString* dataFilePath();
    FCBlockDataManager* GetBlockDataManager();

private:
    
    FCBlockDataManager *m_pBlockDataManager;
};


#endif
