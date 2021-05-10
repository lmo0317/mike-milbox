#import "FCSoundDataManager.h"
 
 void FCSoundDataManager::AddSoundData(NSString* pID,const int nCategory,NSString* pValue)
 {
     std::map<NSInteger,FCSoundData*>::iterator it = m_hashSoundData.find(pID.hash);
     if(it == m_hashSoundData.end())
     {
         FCSoundData* pSoundData = new FCSoundData;
         pSoundData->SetID(pID);
         pSoundData->AddValue(nCategory,pValue);
         
         m_hashSoundData.insert(std::make_pair(pID.hash,pSoundData));
         return;
     }
     
     (*it).second->AddValue(nCategory,pValue);
 }

NSString* FCSoundDataManager::GetSoundData(NSString *pID,const int nCategory)
{
    std::map<NSInteger,FCSoundData*>::iterator it = m_hashSoundData.find(pID.hash);
    if(it != m_hashSoundData.end())
    {
        FCSoundData* pSoundData = ((*it).second);
        
        return pSoundData->GetValue(nCategory);
    }
    
    return NULL;
}