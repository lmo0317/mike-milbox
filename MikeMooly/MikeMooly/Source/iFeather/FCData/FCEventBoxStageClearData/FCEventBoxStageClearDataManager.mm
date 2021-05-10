 #import "FCEventBoxStageClearDataManager.h"

void FCEventBoxStageClearDataManager::AddEventBoxStageClearData(FCEventBoxStageClearData* pEventBoxStageClearData)
{
    std::map<NSInteger,FCEventBoxStageClearData*>::iterator it = m_hashEventBoxStageClearData.find(pEventBoxStageClearData->GetName().hash);
    if(it == m_hashEventBoxStageClearData.end())
    {
        m_hashEventBoxStageClearData.insert(std::make_pair(pEventBoxStageClearData->GetName().hash,pEventBoxStageClearData));
        return;
    }
    
    FCEventBoxStageClearData *pLocalEventBoxStageClearData = (*it).second;
    pLocalEventBoxStageClearData->Copy(pEventBoxStageClearData);
}


FCEventBoxStageClearData* FCEventBoxStageClearDataManager::GetEventBoxStageClearData(NSString* pName)
{  
    std::map<NSInteger,FCEventBoxStageClearData*>::iterator it = m_hashEventBoxStageClearData.find(pName.hash);
    if(it == m_hashEventBoxStageClearData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

