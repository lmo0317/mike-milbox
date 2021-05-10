 #import "FCSaveDataManager.h"

void FCSaveDataManager::AddSaveData(FCSaveData* pSaveData)
{
    std::map<NSInteger,FCSaveData*>::iterator it = m_hashSaveData.find(pSaveData->GetName().hash);
    if(it == m_hashSaveData.end())
    {
        m_hashSaveData.insert(std::make_pair(pSaveData->GetName().hash,pSaveData));
        return;
    }
    
    FCSaveData *pLocalSaveData = (*it).second;
    pLocalSaveData->Copy(pSaveData);
}


FCSaveData* FCSaveDataManager::GetSaveData(NSString* pName)
{  
    std::map<NSInteger,FCSaveData*>::iterator it = m_hashSaveData.find(pName.hash);
    if(it == m_hashSaveData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

