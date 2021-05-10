#ifndef FC_HIT_BOX_DATA_PARSER
#define FC_HIT_BOX_DATA_PARSER

#import "FCHitBoxDataManager.h"

class FCHitBoxDataParser
{
public:
    void Init();
    void LoadHitBoxData();
    NSString* dataFilePath();
    FCHitBoxDataManager* GetHitBoxDataManager();

private:
    
    FCHitBoxDataManager *m_pHitBoxDataManager;
};


#endif
