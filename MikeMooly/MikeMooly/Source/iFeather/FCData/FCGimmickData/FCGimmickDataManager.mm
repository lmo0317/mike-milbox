 #import "FCGimmickDataManager.h"

void FCGimmickDataManager::AddGimmickData(FCGimmickData* pGimmickData)
{
    std::map<NSInteger,FCGimmickData*>::iterator it = m_hashGimmickData.find(pGimmickData->GetName().hash);
    if(it == m_hashGimmickData.end())
    {
        m_hashGimmickData.insert(std::make_pair(pGimmickData->GetName().hash,pGimmickData));
        return;
    }
    
    FCGimmickData *pLocalGimmickData = (*it).second;
    pLocalGimmickData->Copy(pGimmickData);
}


FCGimmickData* FCGimmickDataManager::GetGimmickData(NSString* pName)
{  
    std::map<NSInteger,FCGimmickData*>::iterator it = m_hashGimmickData.find(pName.hash);
    if(it == m_hashGimmickData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

