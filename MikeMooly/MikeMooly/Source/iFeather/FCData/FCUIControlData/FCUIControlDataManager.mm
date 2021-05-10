#import "FCUIControlDataManager.h"
 
FCUIControlData* FCUIControlDataManager::AddUIControlData(NSString* pID)
{
    std::map<NSInteger,FCUIControlData*>::iterator it = m_hashUIControlData.find(pID.hash);
    if(it == m_hashUIControlData.end())
    {
        FCUIControlData* pUIControlData = new FCUIControlData;
        pUIControlData->SetID(pID);

        m_hashUIControlData.insert(std::make_pair(pID.hash,pUIControlData));
        return pUIControlData;
    }
    
    return NULL;
}

FCUIControlData* FCUIControlDataManager::GetUIControlData(NSString *pID)
{
    std::map<NSInteger,FCUIControlData*>::iterator it = m_hashUIControlData.find(pID.hash);
    if(it != m_hashUIControlData.end())
    {
        return ((*it).second);
    }
    
    return NULL;
}