#ifndef FCPLAYERPARSER
#define FCPLAYERPARSER

#import "FCPlayerDataManager.h"

class FCPlayerParser
{
public:
    void Init();
    void LoadPlayerData();
    NSString* dataFilePath();
    FCPlayerDataManager* GetPlayerDataManager();

private:
    
    FCPlayerDataManager *m_pPlayerDataManager;
};


#endif
