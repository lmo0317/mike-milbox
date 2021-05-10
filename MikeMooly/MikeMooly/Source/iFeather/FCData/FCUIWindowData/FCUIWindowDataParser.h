#ifndef FC_UI_WINDOW_DATA_PARSER
#define FC_UI_WINDOW_DATA_PARSER

#import "FCUIWindowDataManager.h"

class FCUIWindowDataParser
{
public:
    void Init();
    void LoadUIWindowData(NSString* strName);
    FCUIWindowDataManager* GetUIWindowDataManager();

private:
    
    FCUIWindowDataManager *m_pUIWindowDataManager;
};


#endif
