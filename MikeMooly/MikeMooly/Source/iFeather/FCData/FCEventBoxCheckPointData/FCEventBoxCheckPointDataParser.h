#ifndef FC_EVENT_BOX_CheckPoint_DATA_PARSER
#define FC_EVENT_BOX_CheckPoint_DATA_PARSER

#import "FCEventBoxCheckPointDataManager.h"

class FCEventBoxCheckPointDataParser
{
public:
    void Init();
    void LoadEventBoxCheckPointData();
    NSString* dataFilePath();
    FCEventBoxCheckPointDataManager* GetEventBoxCheckPointDataManager();

private:
    
    FCEventBoxCheckPointDataManager *m_pEventBoxCheckPointDataManager;
};


#endif
