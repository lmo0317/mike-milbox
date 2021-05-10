#import "FCFieldItemData.h"


FCFieldItemData::FCFieldItemData():
m_strCategory(NULL),
m_nMissionItemID(0)
{
    
}

FCFieldItemData::~FCFieldItemData()
{
    
}

void FCFieldItemData::Copy(FCFieldItemData* pFieldItemData)
{
    if(pFieldItemData == NULL)
        return;
    
    m_strName = pFieldItemData->GetName();
}

void FCFieldItemData::AddStateData(NSString* pID,const int nCategory,NSString *pValue)
{
    m_StateDataManager.AddStateData(pID,nCategory,pValue);
}

NSString* FCFieldItemData::GetStateData(NSString* pID,const int nCategory)
{
    return m_StateDataManager.GetStateData(pID,nCategory);
}