#import "FCShootData.h"


FCShootData::FCShootData()
{
    
}

FCShootData::~FCShootData()
{
    
}

void FCShootData::Copy(FCShootData* pShootData)
{
    if(pShootData == NULL)
        return;
    
    m_strName = pShootData->GetName();
}

NSString* FCShootData::GetName()
{
    return m_strName;
}

void FCShootData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCShootData::SetLifeTime(const float fLifeTime)
{
    m_fLifeTime = fLifeTime;
}

float FCShootData::GetLifeTime()
{
    return m_fLifeTime;
}
