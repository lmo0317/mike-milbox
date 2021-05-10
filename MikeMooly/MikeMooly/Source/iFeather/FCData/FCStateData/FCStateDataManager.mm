#import "FCStateDataManager.h"
 
 void FCStateDataManager::AddStateData(NSString* pID,const int nCategory,NSString* pValue)
 {
     std::map<NSInteger,FCStateData*>::iterator it = m_hashStateData.find(pID.hash);
     if(it == m_hashStateData.end())
     {
         FCStateData* pStateData = new FCStateData;
         pStateData->SetID(pID);
         pStateData->AddValue(nCategory,pValue);
         
         m_hashStateData.insert(std::make_pair(pID.hash,pStateData));
         return;
     }
     
     (*it).second->AddValue(nCategory,pValue);
 }

NSString* FCStateDataManager::GetStateData(NSString *pID,const int nCategory)
{
    std::map<NSInteger,FCStateData*>::iterator it = m_hashStateData.find(pID.hash);
    if(it != m_hashStateData.end())
    {
        FCStateData* pStateData = ((*it).second);
        
        return pStateData->GetValue(nCategory);
    }
    
    return NULL;
}