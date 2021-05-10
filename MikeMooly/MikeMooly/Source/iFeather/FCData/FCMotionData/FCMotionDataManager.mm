 #import "FCMotionDataManager.h"

void FCMotionDataManager::AddMotionData(FCMotionData* pMotionData)
{
    std::map<NSInteger,FCMotionData*>::iterator it = m_hashMotionData.find(pMotionData->GetName().hash);
    if(it == m_hashMotionData.end())
    {
        m_hashMotionData.insert(std::make_pair(pMotionData->GetName().hash,pMotionData));
        return;
    }
    
    FCMotionData* pLocalMotionData = (*it).second;
    pLocalMotionData->Copy(pMotionData);
}


FCMotionData* FCMotionDataManager::GetMotionData(NSString* pName)
{  
    std::map<NSInteger,FCMotionData*>::iterator it = m_hashMotionData.find(pName.hash);
    if(it == m_hashMotionData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}