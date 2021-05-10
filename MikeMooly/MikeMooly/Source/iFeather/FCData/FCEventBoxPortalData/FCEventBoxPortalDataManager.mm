 #import "FCEventBoxPortalDataManager.h"

void FCEventBoxPortalDataManager::AddEventBoxPortalData(FCEventBoxPortalData* pEventBoxPortalData)
{
    std::map<NSInteger,FCEventBoxPortalData*>::iterator it = m_hashEventBoxPortalData.find(pEventBoxPortalData->GetName().hash);
    if(it == m_hashEventBoxPortalData.end())
    {
        m_hashEventBoxPortalData.insert(std::make_pair(pEventBoxPortalData->GetName().hash,pEventBoxPortalData));
        return;
    }
    
    FCEventBoxPortalData *pLocalEventBoxPortalData = (*it).second;
    pLocalEventBoxPortalData->Copy(pEventBoxPortalData);
}


FCEventBoxPortalData* FCEventBoxPortalDataManager::GetEventBoxPortalData(NSString* pName)
{  
    std::map<NSInteger,FCEventBoxPortalData*>::iterator it = m_hashEventBoxPortalData.find(pName.hash);
    if(it == m_hashEventBoxPortalData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

