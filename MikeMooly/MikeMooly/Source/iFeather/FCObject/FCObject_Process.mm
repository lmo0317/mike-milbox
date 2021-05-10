#import "FCObject.h"


void FCObject::Process(ccTime dt)
{
    //object 생성후 최근의 시간
    m_dCurTime += dt;
    
    //animation 진행 시간
    m_dCurAnimationTime += dt;
    AnimationProcess(dt);
}

void FCObject::AnimationProcessSound(ccTime dt)
{ 
    //if(m_pMotionData == NULL)
    //    return;
    
    std::vector<FCMotionDataSound*>* pMotionDataSound = m_pMotionData.GetMotionDataSound(); 
    std::vector<FCMotionDataSound*>::iterator it = pMotionDataSound->begin();
    for(;it != pMotionDataSound->end();)
    {
        FCMotionDataSound* data = (*it);
        
        if(m_dCurAnimationTime > (data->nFrame * m_sCurAnimationInfo.fSpeed))
        {
            PlayEffectSound(data->pValue);
            it = pMotionDataSound->erase(it);
            continue;
        }
        it++;
    }
}

void FCObject::AnimationProcessEffect(ccTime dt)
{
    //if(m_pMotionData == NULL)
    //    return;

    std::vector<FCMotionDataEffect*>* pMotionDataEffect = m_pMotionData.GetMotionDataEffect();
    std::vector<FCMotionDataEffect*>::iterator it = pMotionDataEffect->begin();
    
    for(;it != pMotionDataEffect->end();)
    {
        FCMotionDataEffect* data = (*it);
        
        if(m_dCurAnimationTime > (data->nFrame * m_sCurAnimationInfo.fSpeed))
        {
            PlayEffectParticle(data->pValue);
            it = pMotionDataEffect->erase(it);
            continue;
        }
        it++;
    }
}

void FCObject::AnimationProcessHit(ccTime dt)
{
    std::vector<FCMotionDataHit*>* pMotionDataHit = m_pMotionData.GetMotionDataHit();
    std::vector<FCMotionDataHit*>::iterator it = pMotionDataHit->begin();
    
    for(;it != pMotionDataHit->end();)
    {
        FCMotionDataHit* data = (*it);
        
        if(m_dCurAnimationTime > (data->nFrame * m_sCurAnimationInfo.fSpeed))
        {
            AddHitData(data->pModelName);
            //PlayEffectParticle(data->pValue);
            it = pMotionDataHit->erase(it);
            continue;
        }
        it++;
    }    
}

void FCObject::AnimationProcessShoot(ccTime dt)
{
    //if(m_pMotionData == NULL)
    //    return;

    std::vector<FCMotionDataShoot*>* pMotionDataShoot = m_pMotionData.GetMotionDataShoot();
    std::vector<FCMotionDataShoot*>::iterator it = pMotionDataShoot->begin();
    for(;it != pMotionDataShoot->end();)
    {
        FCMotionDataShoot* data = (*it);
          
        if(m_dCurAnimationTime > (data->nFrame * m_sCurAnimationInfo.fSpeed))
        {
            CCLOG(@"ADD SHOOT");
            AddShoot(data->pModelName);
            it = pMotionDataShoot->erase(it);
            continue;
        }
        it++;
    }   
}

void FCObject::AnimationProcess(ccTime dt)
{
    AnimationProcessSound(dt);
    AnimationProcessEffect(dt);
    AnimationProcessShoot(dt);
    AnimationProcessHit(dt);
    
    const ccTime cLastTime  = m_sCurAnimationInfo.fSpeed * m_sCurAnimationInfo.nFrame;
    if(m_dCurAnimationTime > cLastTime && m_sCurAnimationInfo.bLoop)
    {
        ResetCurAnimationEventInfo();  
    }
}
