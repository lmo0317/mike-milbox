#import "FCEventBoxPortalData.h"


FCEventBoxPortalData::FCEventBoxPortalData()
{
    
}

FCEventBoxPortalData::~FCEventBoxPortalData()
{
    
}

void FCEventBoxPortalData::Copy(FCEventBoxPortalData* pEventBoxPortalData)
{
    if(pEventBoxPortalData == NULL)
        return;
    
    m_strName = pEventBoxPortalData->GetName();
}

NSString* FCEventBoxPortalData::GetName()
{
    return m_strName;
}

void FCEventBoxPortalData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCEventBoxPortalData::AddStateData(NSString* pID,const int nCategory,NSString *pValue)
{
    m_StateDataManager.AddStateData(pID,nCategory,pValue);
}

NSString* FCEventBoxPortalData::GetStateData(NSString* pID,const int nCategory)
{
    return m_StateDataManager.GetStateData(pID,nCategory);
}