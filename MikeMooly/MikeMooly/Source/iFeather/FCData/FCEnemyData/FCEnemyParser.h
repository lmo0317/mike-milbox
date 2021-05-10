#ifndef FCENEMYPARSER
#define FCENEMYPARSER

#import "FCEnemyDataManager.h"

class FCEnemyParser
{
public:
    void Init();
    void LoadEnemyData();
    NSString* dataFilePath();
    FCEnemyDataManager* GetEnemyDataManager();

private:
    
    FCEnemyDataManager *m_pEnemyDataManager;
};


#endif
