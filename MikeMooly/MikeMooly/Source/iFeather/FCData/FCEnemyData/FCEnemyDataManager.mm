 #import "FCEnemyDataManager.h"

void FCEnemyDataManager::AddEnemyData(FCEnemyData* pEnemyData)
{
    std::map<NSInteger,FCEnemyData*>::iterator it = m_hashEnemyData.find(pEnemyData->GetName().hash);
    if(it == m_hashEnemyData.end())
    {
        m_hashEnemyData.insert(std::make_pair(pEnemyData->GetName().hash,pEnemyData));
        return;
    }
    
    FCEnemyData* pLocalEnemyData = (*it).second;
    pLocalEnemyData->Copy(pEnemyData);
}


FCEnemyData* FCEnemyDataManager::GetEnemyData(NSString* pName)
{  
    std::map<NSInteger,FCEnemyData*>::iterator it = m_hashEnemyData.find(pName.hash);
    if(it == m_hashEnemyData.end())
    {
        CCLOG(@"ENEMY DATA NULL");
        return NULL;
    }
    
    return (*it).second;
}