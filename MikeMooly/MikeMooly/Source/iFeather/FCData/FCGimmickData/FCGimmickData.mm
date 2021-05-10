#import "FCGimmickData.h"


FCGimmickData::FCGimmickData():
m_bOneShot(false)
{
    
}

FCGimmickData::~FCGimmickData()
{
    
}

void FCGimmickData::Copy(FCGimmickData* pGimmickData)
{
    if(pGimmickData == NULL)
        return;
    
    m_strName = pGimmickData->GetName();
}

NSString* FCGimmickData::GetName()
{
    return m_strName;
}

void FCGimmickData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCGimmickData::SetLifeTime(const float fLifeTime)
{
    m_fLifeTime = fLifeTime;
}

const float FCGimmickData::GetLifeTime()
{
    return m_fLifeTime;
}
