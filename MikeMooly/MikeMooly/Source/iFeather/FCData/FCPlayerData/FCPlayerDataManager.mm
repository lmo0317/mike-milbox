 #import "FCPlayerDataManager.h"

void FCPlayerDataManager::AddPlayerData(FCPlayerData* pPlayerData)
{
    std::map<NSInteger,FCPlayerData*>::iterator it = m_hashPlayerData.find(pPlayerData->GetName().hash);
    if(it == m_hashPlayerData.end())
    {
        m_hashPlayerData.insert(std::make_pair(pPlayerData->GetName().hash,pPlayerData));
        return;
    }
    
    FCPlayerData *pLocalPlayerData = (*it).second;
    pLocalPlayerData->Copy(pPlayerData);
}


FCPlayerData* FCPlayerDataManager::GetPlayerData(NSString* pName)
{  
    std::map<NSInteger,FCPlayerData*>::iterator it = m_hashPlayerData.find(pName.hash);
    if(it == m_hashPlayerData.end())
    {
        CCLOG(@"PLAYER DATA NULL");
        return NULL;
    }
    
    return (*it).second;
}

