#import "FCAIState.h"
#import "FCAIData.h"
#import "FCEnemy.h"

FCAIState::FCAIState():
m_pParent(NULL),
m_dCurTime(0)
{
    
}

FCAIState::~FCAIState()
{
    
}

const float FCAIState::GetUtility(ccTime dt)
{
    return 0.f;
}

void FCAIState::Process(ccTime dt)
{
    
}

void FCAIState::Init(FCEnemy* pParent)
{
    m_pParent = pParent;
    
    FCAIData* pAIData = m_pParent->GetAIData();
    FCAIStateData* pStateData = pAIData->GetStateData(m_strName);
    
    if(pStateData == NULL)
        return;
    
    float fTime = pStateData->fTime;
    const bool bPrefix = pStateData->bPrefix;
    
    if(m_dCurTime == 0 && bPrefix)
    {
        m_dCurTime += fTime;
    }
}

void FCAIState::SetState()
{
    
}