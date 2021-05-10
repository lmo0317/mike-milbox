#import "FCBlockData.h"


FCBlockData::FCBlockData()
{
    
}

FCBlockData::~FCBlockData()
{
    
}

void FCBlockData::Copy(FCBlockData* pBlockData)
{
    if(pBlockData == NULL)
        return;
    
    m_strName = pBlockData->GetName();
}

NSString* FCBlockData::GetName()
{
    return m_strName;
}

void FCBlockData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCBlockData::AddStateData(NSString* pID,const int nCategory,NSString *pValue)
{
    m_StateDataManager.AddStateData(pID,nCategory,pValue);
}

NSString* FCBlockData::GetStateData(NSString* pID,const int nCategory)
{
    return m_StateDataManager.GetStateData(pID,nCategory);
}