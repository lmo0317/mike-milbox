#ifndef FC_SAVE_DATA_PARSER
#define FC_SAVE_DATA_PARSER

#import "FCSaveDataManager.h"
#import "FCSaveWorldDataManager.h"
#import "GDataXMLNode.h"

class FCSaveDataParser
{
public:
    void Init();
    void LoadSaveData();
    void SaveSaveData();
    void SaveDataElement(FCSaveData* pSaveData,GDataXMLElement * pSaveDataTemplate);
    NSString* dataFilePath(const bool forSave);
    FCSaveDataManager* GetSaveDataManager();

private:
    
    FCSaveDataManager *m_pSaveDataManager;
};


#endif
