 #import "FCHitBoxDataManager.h"

void FCHitBoxDataManager::AddHitBoxData(FCHitBoxData* pHitBoxData)
{
    std::map<NSInteger,FCHitBoxData*>::iterator it = m_hashHitBoxData.find(pHitBoxData->GetName().hash);
    if(it == m_hashHitBoxData.end())
    {
        m_hashHitBoxData.insert(std::make_pair(pHitBoxData->GetName().hash,pHitBoxData));
        return;
    }
    
    FCHitBoxData *pLocalHitBoxData = (*it).second;
    pLocalHitBoxData->Copy(pHitBoxData);
}


FCHitBoxData* FCHitBoxDataManager::GetHitBoxData(NSString* pName)
{  
    std::map<NSInteger,FCHitBoxData*>::iterator it = m_hashHitBoxData.find(pName.hash);
    if(it == m_hashHitBoxData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

