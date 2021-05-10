#import "FCAIStateStay.h"
#import "FCEnemy.h"

FCAIStateStay::FCAIStateStay()
{
    m_strName = @"STAY";
}

FCAIStateStay::~FCAIStateStay()
{
    
}

const float FCAIStateStay::GetUtility(ccTime dt)
{
    return 1.f;
}

void FCAIStateStay::Process(ccTime dt)
{
 
    FCAIState::Process(dt);
}

void FCAIStateStay::SetState()
{
    //if(m_pParent)
    //{
    //    m_pParent->SetState(STATE_STAY);
    //}
}