#import "FCWorldData.h"

FCWorldData::FCWorldData()
:m_strGroup(NULL),
m_bGroupEnd(false),
m_bGroupFirst(false),
m_nMissionTime(0),
m_nMissionDamage(0)
{
    
}

FCWorldData::~FCWorldData()
{
    
}

void FCWorldData::Copy(FCWorldData* pWorldData)
{
    if(pWorldData == NULL)
        return;
    
    m_strName = pWorldData->GetName();
}

NSString* FCWorldData::GetName()
{
    return m_strName;
}

void FCWorldData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCWorldData::AddSoundPreload(NSString* strSoundPreload)
{
    m_vecSoundPreload.push_back(strSoundPreload);
}