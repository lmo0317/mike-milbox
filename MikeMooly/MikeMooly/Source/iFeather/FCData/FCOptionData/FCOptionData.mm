#import "FCOptionData.h"


FCOptionData::FCOptionData():
m_bBGM(false),
m_bFX(false),
m_nControl(0)
{
    
}

FCOptionData::~FCOptionData()
{
    
}

void FCOptionData::Copy(FCOptionData* pSaveData)
{
    if(pSaveData == NULL)
        return;
    
    m_strName = pSaveData->GetName();
}

NSString* FCOptionData::GetName()
{
    return m_strName;
}

void FCOptionData::SetName(NSString* strName)
{
    m_strName = strName;
}
