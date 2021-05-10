#import "FCSaveWorldDataManager.h"

FCSaveWorldDataManager::FCSaveWorldDataManager()
{
    
}

FCSaveWorldDataManager::~FCSaveWorldDataManager()
{
    
}

FCSaveWorldData* FCSaveWorldDataManager::AddSaveWorldData(NSString* pID)
{
    std::map<NSInteger,FCSaveWorldData*>::iterator it = m_hashSaveWorldData.find(pID.hash);
    if(it == m_hashSaveWorldData.end())
    {
        FCSaveWorldData* pSaveWorldData = new FCSaveWorldData;
        pSaveWorldData->SetID(pID);
        
        m_hashSaveWorldData.insert(std::make_pair(pID.hash,pSaveWorldData));
        return pSaveWorldData;
    }
    
    return NULL;
}

FCSaveWorldData* FCSaveWorldDataManager::GetSaveWorldData(NSString *pID)
{
    std::map<NSInteger,FCSaveWorldData*>::iterator it = m_hashSaveWorldData.find(pID.hash);
    if(it != m_hashSaveWorldData.end())
    {
        return ((*it).second);
    }
    
    return NULL;
}

void FCSaveWorldDataManager::ClearSaveWorldData()
{
    std::map<NSInteger,FCSaveWorldData*>::iterator it = m_hashSaveWorldData.begin();
    for(;it != m_hashSaveWorldData.end();++it)
    {
        FCSaveWorldData* pSaveWorldData = it->second;
        pSaveWorldData->SetLock(false);
        pSaveWorldData->SetMissionDamage(false);
        pSaveWorldData->SetMissionTime(false);
        pSaveWorldData->SetMissionItem(false);
        
        if([pSaveWorldData->GetID() isEqualToString:@"farm_1"]) {
            pSaveWorldData->SetOpen(1);
        }
        else {
            pSaveWorldData->SetOpen(0);
        }
    }
}

const int FCSaveWorldDataManager::GetPercent()
{
    int nTotalCount = 0;
    int nStarCount = 0;
    std::map<NSInteger,FCSaveWorldData*>::iterator it = m_hashSaveWorldData.begin();
    for(;it != m_hashSaveWorldData.end();++it)
    {
        FCSaveWorldData* pSaveWorldData = it->second;
        
        if(pSaveWorldData->GetMissionItem())
        {
            nStarCount++;
        }
        nTotalCount++;
        
        if(pSaveWorldData->GetMissionTime())
        {
            nStarCount++;
        }        
        nTotalCount++;
        
        if(pSaveWorldData->GetMissionDamage())
        {
            nStarCount++;
        }        
        nTotalCount++;
    }
    
    return ((float)nStarCount / nTotalCount) * 100;
}