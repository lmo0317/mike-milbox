#ifndef FC_EVENT_BOX_PORTAL_DATA_PARSER
#define FC_EVENT_BOX_PORTAL_DATA_PARSER

#import "FCEventBoxPortalDataManager.h"

class FCEventBoxPortalDataParser
{
public:
    void Init();
    void LoadEventBoxPortalData();
    NSString* dataFilePath();
    FCEventBoxPortalDataManager* GetEventBoxPortalDataManager();

private:
    
    FCEventBoxPortalDataManager *m_pEventBoxPortalDataManager;
};


#endif
