#import "FCMotionData.h"

void FCMotionData::AddEffectData(const int nFrame,NSString* pValue)
{
    FCMotionDataEffect* pEffect = new FCMotionDataEffect;
    pEffect->nFrame = nFrame;
    pEffect->pValue = pValue;
    
    m_vecMotionDataEffect.push_back(pEffect);
}
void FCMotionData::AddSoundData(const int nFrame,NSString* pValue)
{
    FCMotionDataSound* pSound = new FCMotionDataSound;
    pSound->nFrame = nFrame;
    pSound->pValue = pValue;
    
    m_vecMotionDataSound.push_back(pSound);
}

void FCMotionData::AddShootData(const int nFrame,NSString* pModelName)
{
    FCMotionDataShoot* pShoot = new FCMotionDataShoot;
    pShoot->nFrame = nFrame;
    pShoot->pModelName = pModelName;
    
    m_vecMotionDataShoot.push_back(pShoot);
}

void FCMotionData::AddHitData(const int nFrame,NSString* pModelName)
{
    FCMotionDataHit* pHitData = new FCMotionDataHit;
    pHitData->nFrame = nFrame;
    pHitData->pModelName = pModelName;
    
    m_vecMotionDataHit.push_back(pHitData);    
}


void FCMotionData::Copy(FCMotionData* pAIData)
{
    if(pAIData == NULL)
        return;
    
    m_strName = pAIData->GetName();
}

NSString* FCMotionData::GetName()
{
    return m_strName;
}

void FCMotionData::SetName(NSString* strName)
{
    m_strName = strName;
}


std::vector<FCMotionDataEffect*>* FCMotionData::GetMotionDataEffect()
{
    return &m_vecMotionDataEffect;
}
std::vector<FCMotionDataSound*>*  FCMotionData::GetMotionDataSound()
{
    return &m_vecMotionDataSound;
}
std::vector<FCMotionDataShoot*>*  FCMotionData::GetMotionDataShoot()
{
    return &m_vecMotionDataShoot;
}
std::vector<FCMotionDataHit*>* FCMotionData::GetMotionDataHit()
{
    return &m_vecMotionDataHit;
}