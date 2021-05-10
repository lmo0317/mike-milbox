#ifndef FC_UI_WINDOW_LIST_DATA_PARSER
#define FC_UI_WINDOW_LIST_DATA_PARSER

#import "FCUIWindowListDataManager.h"

class FCUIWindowListDataParser
{
public:
    void Init();
    void LoadUIWindowListData();
    void LoadUIWindowData();
    NSString* dataFilePath();
    FCUIWindowListDataManager* GetUIWindowListDataManager();

private:
    
    FCUIWindowListDataManager *m_pUIWindowListDataManager;
};


#endif
