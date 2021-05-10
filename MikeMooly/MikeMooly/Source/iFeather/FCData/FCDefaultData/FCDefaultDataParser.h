#ifndef FC_DEFAULT_DATA_PARSER
#define FC_DEFAULT_DATA_PARSER

#import "FCDefaultDataManager.h"

class FCDefaultDataParser
{
public:
    void Init();
    void LoadDefaultData();
    NSString* dataFilePath();
    FCDefaultDataManager* GetDefaultDataManager();

private:
    
    FCDefaultDataManager *m_pDefaultDataManager;
};


#endif
