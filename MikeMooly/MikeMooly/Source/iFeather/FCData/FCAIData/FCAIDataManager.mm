 #import "FCAIDataManager.h"

void FCAIDataManager::AddAIData(FCAIData* pAIData)
{
    std::map<NSInteger,FCAIData*>::iterator it = m_hashAIData.find(pAIData->GetName().hash);
    if(it == m_hashAIData.end())
    {
        m_hashAIData.insert(std::make_pair(pAIData->GetName().hash,pAIData));
        return;
    }
    
    FCAIData *pLocalAIData = (*it).second;
    pLocalAIData->Copy(pAIData);
}


FCAIData* FCAIDataManager::GetAIData(NSString* pName)
{  
    std::map<NSInteger,FCAIData*>::iterator it = m_hashAIData.find(pName.hash);
    if(it == m_hashAIData.end())
    {
        CCLOG(@"AI DATA NULL");
        return NULL;
    }
    
    return (*it).second;
}

