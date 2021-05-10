#ifndef FC_AI_PARSER
#define FC_AI_PARSER

#import "FCAIDataManager.h"

class FCAIParser
{
public:
    void Init();
    void LoadAIData();
    NSString* dataFilePath();
    FCAIDataManager* GetAIDataManager();

private:
    
    FCAIDataManager *m_pAIDataManager;
};


#endif
