 #import "FCUIWindowDataManager.h"

void FCUIWindowDataManager::AddUIWindowData(FCUIWindowData* pUIWindowData)
{
    std::map<NSInteger,FCUIWindowData*>::iterator it = m_hashUIWindowData.find(pUIWindowData->GetName().hash);
    if(it == m_hashUIWindowData.end())
    {
        m_hashUIWindowData.insert(std::make_pair(pUIWindowData->GetName().hash,pUIWindowData));
        return;
    }
    
    FCUIWindowData *pLocalUIWindowData = (*it).second;
    pLocalUIWindowData->Copy(pUIWindowData);
}


FCUIWindowData* FCUIWindowDataManager::GetUIWindowData(NSString* pName)
{  
    std::map<NSInteger,FCUIWindowData*>::iterator it = m_hashUIWindowData.find(pName.hash);
    if(it == m_hashUIWindowData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

