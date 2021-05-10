#import "FCAIStateAttack.h"
#import "FCEnemy.h"

FCAIStateAttack::FCAIStateAttack()
{
    m_strName = @"ATTACK";
}

FCAIStateAttack::~FCAIStateAttack()
{
    
}

const float FCAIStateAttack::GetUtility(ccTime dt)
{
    if(m_pParent)
    {
        FCAIData* pAIData = m_pParent->GetAIData();
        FCAIStateData* pStateData = pAIData->GetStateData(m_strName);
        
        if(pStateData == NULL)
            return 0.f;
        
        float fTime = pStateData->fTime;
        float fProbability = pStateData->fProbability;
        
        m_dCurTime += dt;        
        if(m_dCurTime > fTime)
        {
            m_dCurTime = 0;
            float fRand = drand(0,1);
            if(fProbability > fRand)
            {
                return 4.f;
            }
        }
    }
    
    return 0.f;
}

void FCAIStateAttack::SetState()
{
    if(m_pParent)
    {
        m_pParent->SetState(STATE_ATTACK);
    }
}

void FCAIStateAttack::Process(ccTime dt)
{
    
    FCAIState::Process(dt);
}