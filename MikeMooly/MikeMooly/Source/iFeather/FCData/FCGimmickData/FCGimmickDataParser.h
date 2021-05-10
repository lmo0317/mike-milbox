#ifndef FC_Gimmick_DATA_PARSER
#define FC_Gimmick_DATA_PARSER

#import "FCGimmickDataManager.h"

class FCGimmickDataParser
{
public:
    void Init();
    void LoadGimmickData();
    NSString* dataFilePath();
    FCGimmickDataManager* GetGimmickDataManager();

private:
    
    FCGimmickDataManager *m_pGimmickDataManager;
};


#endif
