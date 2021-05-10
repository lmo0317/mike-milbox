 #import "FCShootDataManager.h"

void FCShootDataManager::AddShootData(FCShootData* pShootData)
{
    std::map<NSInteger,FCShootData*>::iterator it = m_hashShootData.find(pShootData->GetName().hash);
    if(it == m_hashShootData.end())
    {
        m_hashShootData.insert(std::make_pair(pShootData->GetName().hash,pShootData));
        return;
    }
    
    FCShootData *pLocalShootData = (*it).second;
    pLocalShootData->Copy(pShootData);
}


FCShootData* FCShootDataManager::GetShootData(NSString* pName)
{  
    std::map<NSInteger,FCShootData*>::iterator it = m_hashShootData.find(pName.hash);
    if(it == m_hashShootData.end())
    {
        CCLOG(@"SHOOT DATA NULL");
        return NULL;
    }
    
    return (*it).second;
}

