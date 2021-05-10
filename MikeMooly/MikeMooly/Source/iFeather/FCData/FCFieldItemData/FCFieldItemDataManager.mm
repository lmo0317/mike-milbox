 #import "FCFieldItemDataManager.h"

void FCFieldItemDataManager::AddFieldItemData(FCFieldItemData* pFieldItemData)
{
    std::map<NSInteger,FCFieldItemData*>::iterator it = m_hashFieldItemData.find(pFieldItemData->GetName().hash);
    if(it == m_hashFieldItemData.end())
    {
        m_hashFieldItemData.insert(std::make_pair(pFieldItemData->GetName().hash,pFieldItemData));
        return;
    }
    
    FCFieldItemData *pLocalFieldItemData = (*it).second;
    pLocalFieldItemData->Copy(pFieldItemData);
}


FCFieldItemData* FCFieldItemDataManager::GetFieldItemData(NSString* pName)
{  
    std::map<NSInteger,FCFieldItemData*>::iterator it = m_hashFieldItemData.find(pName.hash);
    if(it == m_hashFieldItemData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

