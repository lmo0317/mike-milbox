#ifndef FC_FIELD_ITEM_DATA_PARSER
#define FC_FIELD_ITEM_DATA_PARSER

#import "FCFieldItemDataManager.h"

class FCFieldItemDataParser
{
public:
    void Init();
    void LoadFieldItemData();
    NSString* dataFilePath();
    FCFieldItemDataManager* GetFieldItemDataManager();

private:
    
    FCFieldItemDataManager *m_pFieldItemDataManager;
};


#endif
