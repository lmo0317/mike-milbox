#import "FCDefaultData.h"


FCDefaultData::FCDefaultData():
m_nLife(0),
m_nHP(0),
m_nContinueCount(0)
{
    
}

FCDefaultData::~FCDefaultData()
{
    
}

void FCDefaultData::Copy(FCDefaultData* pDefaultData)
{
    if(pDefaultData == NULL)
        return;
    
    m_strName = pDefaultData->GetName();
}

NSString* FCDefaultData::GetName()
{
    return m_strName;
}

void FCDefaultData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCDefaultData::AddSoundData(NSString* pID,const int nCategory,NSString *pValue)
{
    m_SoundDataManager.AddSoundData(pID,nCategory,pValue);
}

NSString* FCDefaultData::GetSoundData(NSString* pID,const int nCategory)
{
    return m_SoundDataManager.GetSoundData(pID,nCategory);
}