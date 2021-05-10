 #import "FCEventBoxCheckPointDataManager.h"

void FCEventBoxCheckPointDataManager::AddEventBoxCheckPointData(FCEventBoxCheckPointData* pEventBoxCheckPointData)
{
    std::map<NSInteger,FCEventBoxCheckPointData*>::iterator it = m_hashEventBoxCheckPointData.find(pEventBoxCheckPointData->GetName().hash);
    if(it == m_hashEventBoxCheckPointData.end())
    {
        m_hashEventBoxCheckPointData.insert(std::make_pair(pEventBoxCheckPointData->GetName().hash,pEventBoxCheckPointData));
        return;
    }
    
    FCEventBoxCheckPointData *pLocalEventBoxCheckPointData = (*it).second;
    pLocalEventBoxCheckPointData->Copy(pEventBoxCheckPointData);
}


FCEventBoxCheckPointData* FCEventBoxCheckPointDataManager::GetEventBoxCheckPointData(NSString* pName)
{  
    std::map<NSInteger,FCEventBoxCheckPointData*>::iterator it = m_hashEventBoxCheckPointData.find(pName.hash);
    if(it == m_hashEventBoxCheckPointData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

