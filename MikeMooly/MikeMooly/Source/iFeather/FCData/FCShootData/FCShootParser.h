#ifndef FC_SHOOT_PARSER
#define FC_SHOOT_PARSER

#import "FCShootDataManager.h"

class FCShootParser
{
public:
    void Init();
    void LoadShootData();
    NSString* dataFilePath();
    FCShootDataManager* GetShootDataManager();

private:
    
    FCShootDataManager *m_pShootDataManager;
};


#endif
