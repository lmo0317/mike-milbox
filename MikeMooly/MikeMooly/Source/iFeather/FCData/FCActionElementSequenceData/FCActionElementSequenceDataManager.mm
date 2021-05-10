#import "FCActionElementSequenceDataManager.h"

FCActionElementSequenceData* FCActionElementSequenceDataManager::AddActionElementSequenceData()
{    
    FCActionElementSequenceData* pActionElementSequenceData = new FCActionElementSequenceData;
    m_vecActionElementSequenceData.push_back(pActionElementSequenceData);
    return pActionElementSequenceData;
}