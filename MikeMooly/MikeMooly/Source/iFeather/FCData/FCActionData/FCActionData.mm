#import "FCActionData.h"


FCActionData::FCActionData():
m_nRepeat(0)
{
    
}

FCActionData::~FCActionData()
{
    
}

void FCActionData::Copy(FCActionData* pActionData)
{
    if(pActionData == NULL)
        return;
    
    m_strName = pActionData->GetName();
}

NSString* FCActionData::GetName()
{
    return m_strName;
}

void FCActionData::SetName(NSString* strName)
{
    m_strName = strName;
}

FCActionElementSequenceData* FCActionData::AddActionElementSequenceData()
{
    return m_ActionElementSequenceDataManager.AddActionElementSequenceData();
}