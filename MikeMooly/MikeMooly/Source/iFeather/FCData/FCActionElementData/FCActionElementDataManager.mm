#import "FCActionElementDataManager.h"
 
FCActionElementData* FCActionElementDataManager::AddActionElementData()
{    
    FCActionElementData* pActionElementData = new FCActionElementData;
    m_vecActionElementData.push_back(pActionElementData);
    return pActionElementData;
}