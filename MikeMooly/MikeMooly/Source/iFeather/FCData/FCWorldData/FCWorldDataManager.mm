 #import "FCWorldDataManager.h"

void FCWorldDataManager::AddWorldData(FCWorldData* pWorldData)
{
    std::map<NSInteger,FCWorldData*>::iterator it = m_hashWorldData.find(pWorldData->GetName().hash);
    if(it == m_hashWorldData.end())
    {
        m_hashWorldData.insert(std::make_pair(pWorldData->GetName().hash,pWorldData));
        return;
    }
    
    FCWorldData *pLocalWorldData = (*it).second;
    pLocalWorldData->Copy(pWorldData);
}


FCWorldData* FCWorldDataManager::GetWorldData(NSString* pName)
{  
    std::map<NSInteger,FCWorldData*>::iterator it = m_hashWorldData.find(pName.hash);
    if(it == m_hashWorldData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

