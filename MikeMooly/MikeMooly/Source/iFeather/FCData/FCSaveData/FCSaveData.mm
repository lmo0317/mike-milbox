#import "FCSaveData.h"


FCSaveData::FCSaveData():
m_nLife(0),
m_nHP(0),
m_nContinueCount(0)
{
    
}

FCSaveData::~FCSaveData()
{
    
}

void FCSaveData::Copy(FCSaveData* pSaveData)
{
    if(pSaveData == NULL)
        return;
    
    m_strName = pSaveData->GetName();
}

NSString* FCSaveData::GetName()
{
    return m_strName;
}

void FCSaveData::SetName(NSString* strName)
{
    m_strName = strName;
}

FCSaveWorldData* FCSaveData::AddSaveWorldData(NSString* pID)
{
    return m_SaveWorldDataManager.AddSaveWorldData(pID);
}

FCSaveWorldData* FCSaveData::GetSaveWorldData(NSString* pID)
{
    return m_SaveWorldDataManager.GetSaveWorldData(pID);
}