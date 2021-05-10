 #import "FCOptionDataManager.h"

void FCOptionDataManager::AddOptionData(FCOptionData* pOptionData)
{
    std::map<NSInteger,FCOptionData*>::iterator it = m_hashOptionData.find(pOptionData->GetName().hash);
    if(it == m_hashOptionData.end())
    {
        m_hashOptionData.insert(std::make_pair(pOptionData->GetName().hash,pOptionData));
        return;
    }
    
    FCOptionData *pLocalOptionData = (*it).second;
    pLocalOptionData->Copy(pOptionData);
}


FCOptionData* FCOptionDataManager::GetOptionData(NSString* pName)
{  
    std::map<NSInteger,FCOptionData*>::iterator it = m_hashOptionData.find(pName.hash);
    if(it == m_hashOptionData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

