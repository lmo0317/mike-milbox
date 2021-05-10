#ifndef FC_ACTION_DATA_PARSER
#define FC_ACTION_DATA_PARSER

#import "FCActionDataManager.h"

class FCActionDataParser
{
public:
    void Init();
    void LoadActionData();
    NSString* dataFilePath();
    FCActionDataManager* GetActionDataManager();

private:
    
    FCActionDataManager *m_pActionDataManager;
};


#endif
