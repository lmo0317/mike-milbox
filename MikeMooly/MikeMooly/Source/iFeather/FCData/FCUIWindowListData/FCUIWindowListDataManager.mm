 #import "FCUIWindowListDataManager.h"

void FCUIWindowListDataManager::AddUIWindowListData(FCUIWindowListData* pUIWindowListData)
{
    std::map<NSInteger,FCUIWindowListData*>::iterator it = m_hashUIWindowListData.find(pUIWindowListData->GetName().hash);
    if(it == m_hashUIWindowListData.end())
    {
        m_hashUIWindowListData.insert(std::make_pair(pUIWindowListData->GetName().hash,pUIWindowListData));
        return;
    }
    
    FCUIWindowListData *pLocalUIWindowListData = (*it).second;
    pLocalUIWindowListData->Copy(pUIWindowListData);
}


FCUIWindowListData* FCUIWindowListDataManager::GetUIWindowListData(NSString* pName)
{  
    std::map<NSInteger,FCUIWindowListData*>::iterator it = m_hashUIWindowListData.find(pName.hash);
    if(it == m_hashUIWindowListData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

void FCUIWindowListDataManager::LoadUIWindowData()
{
    std::map<NSInteger ,FCUIWindowListData*>::iterator it =  m_hashUIWindowListData.begin();
    for(;it != m_hashUIWindowListData.end();++it)
    {
        FCUIWindowListData* pUIWindowListData = (*it).second;
        NSString* pName = pUIWindowListData->GetName();
        AddUIWindowDataParser(pName);
        
    }
}

void FCUIWindowListDataManager::AddUIWindowDataParser(NSString* strName)
{
    std::map<NSInteger,FCUIWindowDataParser*>::iterator it = m_hashUIWindowDataParser.find(strName.hash);
    if(it == m_hashUIWindowDataParser.end())
    {
        FCUIWindowDataParser* pUIWindowDataParser = new FCUIWindowDataParser;
        pUIWindowDataParser->Init();
        pUIWindowDataParser->LoadUIWindowData(strName);
        
        m_hashUIWindowDataParser.insert(std::make_pair(strName.hash,pUIWindowDataParser));
        return;
    }
}

FCUIWindowDataParser* FCUIWindowListDataManager::GetUIWindowDataParser(NSString* strName)
{
    std::map<NSInteger,FCUIWindowDataParser*>::iterator it = m_hashUIWindowDataParser.find(strName.hash);
    if(it != m_hashUIWindowDataParser.end())
    {
        return (*it).second;
    }
    
    return NULL;
}