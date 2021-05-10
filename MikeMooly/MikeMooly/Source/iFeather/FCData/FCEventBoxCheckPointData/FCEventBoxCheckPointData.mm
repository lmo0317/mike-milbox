#import "FCEventBoxCheckPointData.h"


FCEventBoxCheckPointData::FCEventBoxCheckPointData()
{
    
}

FCEventBoxCheckPointData::~FCEventBoxCheckPointData()
{
    
}

void FCEventBoxCheckPointData::Copy(FCEventBoxCheckPointData* pEventBoxCheckPointData)
{
    if(pEventBoxCheckPointData == NULL)
        return;
    
    m_strName = pEventBoxCheckPointData->GetName();
}

NSString* FCEventBoxCheckPointData::GetName()
{
    return m_strName;
}

void FCEventBoxCheckPointData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCEventBoxCheckPointData::AddStateData(NSString* pID,const int nCategory,NSString *pValue)
{
    m_StateDataManager.AddStateData(pID,nCategory,pValue);
}

NSString* FCEventBoxCheckPointData::GetStateData(NSString* pID,const int nCategory)
{
    return m_StateDataManager.GetStateData(pID,nCategory);
}