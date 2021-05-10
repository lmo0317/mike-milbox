#ifndef FC_OPTION_DATA_PARSER
#define FC_OPTION_DATA_PARSER

#import "FCOptionDataManager.h"
#import "GDataXMLNode.h"

class FCOptionDataParser
{
public:
    void Init();
    void LoadOptionData();
    void SaveOptionData();
    void SaveDataElement(FCOptionData* pOptionData,GDataXMLElement * pOptionDataTemplate);
    NSString* dataFilePath(bool forSave);
    FCOptionDataManager* GetOptionDataManager();

private:
    
    FCOptionDataManager *m_pOptionDataManager;
};


#endif
