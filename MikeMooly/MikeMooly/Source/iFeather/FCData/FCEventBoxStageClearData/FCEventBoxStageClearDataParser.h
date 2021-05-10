#ifndef FC_EVENT_BOX_STATE_CLEAR_DATA_PARSER
#define FC_EVENT_BOX_STAGE_CLEAR_DATA_PARSER

#import "FCEventBoxStageClearDataManager.h"

class FCEventBoxStageClearDataParser
{
public:
    void Init();
    void LoadEventBoxStageClearData();
    NSString* dataFilePath();
    FCEventBoxStageClearDataManager* GetEventBoxStageClearDataManager();

private:
    
    FCEventBoxStageClearDataManager *m_pEventBoxStageClearDataManager;
};


#endif
