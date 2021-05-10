 #import "FCDefaultDataManager.h"

void FCDefaultDataManager::AddDefaultData(FCDefaultData* pDefaultData)
{
    std::map<NSInteger,FCDefaultData*>::iterator it = m_hashDefaultData.find(pDefaultData->GetName().hash);
    if(it == m_hashDefaultData.end())
    {
        m_hashDefaultData.insert(std::make_pair(pDefaultData->GetName().hash,pDefaultData));
        return;
    }
    
    FCDefaultData *pLocalDefaultData = (*it).second;
    pLocalDefaultData->Copy(pDefaultData);
}


FCDefaultData* FCDefaultDataManager::GetDefaultData(NSString* pName)
{  
    std::map<NSInteger,FCDefaultData*>::iterator it = m_hashDefaultData.find(pName.hash);
    if(it == m_hashDefaultData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

