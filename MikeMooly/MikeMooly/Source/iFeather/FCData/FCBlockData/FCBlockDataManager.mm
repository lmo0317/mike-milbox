 #import "FCBlockDataManager.h"

void FCBlockDataManager::AddBlockData(FCBlockData* pBlockData)
{
    std::map<NSInteger,FCBlockData*>::iterator it = m_hashBlockData.find(pBlockData->GetName().hash);
    if(it == m_hashBlockData.end())
    {
        m_hashBlockData.insert(std::make_pair(pBlockData->GetName().hash,pBlockData));
        return;
    }
    
    FCBlockData *pLocalBlockData = (*it).second;
    pLocalBlockData->Copy(pBlockData);
}


FCBlockData* FCBlockDataManager::GetBlockData(NSString* pName)
{  
    std::map<NSInteger,FCBlockData*>::iterator it = m_hashBlockData.find(pName.hash);
    if(it == m_hashBlockData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

