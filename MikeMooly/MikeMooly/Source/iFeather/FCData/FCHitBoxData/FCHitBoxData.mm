#import "FCHitBoxData.h"


FCHitBoxData::FCHitBoxData()
{
    
}

FCHitBoxData::~FCHitBoxData()
{
    
}

void FCHitBoxData::Copy(FCHitBoxData* pHitBoxData)
{
    if(pHitBoxData == NULL)
        return;
    
    m_strName = pHitBoxData->GetName();
}

NSString* FCHitBoxData::GetName()
{
    return m_strName;
}

void FCHitBoxData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCHitBoxData::SetLifeTime(const float fLifeTime)
{
    m_fLifeTime = fLifeTime;
}

const float FCHitBoxData::GetLifeTime()
{
    return m_fLifeTime;
}
