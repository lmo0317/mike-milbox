#import "FCAIStateJumpMove.h"
#import "FCEnemy.h"
//#import "FCUtil.h"

FCAIStateJumpMove::FCAIStateJumpMove():
m_nDirection(PATROL_DIRECTION_LEFT)
{
    m_strName = @"JUMP_MOVE";
}

FCAIStateJumpMove::~FCAIStateJumpMove()
{
    
}

const float FCAIStateJumpMove::GetUtility(ccTime dt)
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
                return 3.f;
            }
        }
    }
    
    return 0.f;
}

void FCAIStateJumpMove::Process(ccTime dt)
{
    if(m_pParent)
    {
        if(m_pParent->GetState() != STATE_JUMP)
        {
            m_pParent->SetState(STATE_JUMP);
        }
        
        if(m_pParent->GetContactLeftFixtureToAICount())
        {
            m_nDirection = PATROL_DIRECTION_RIGHT;
        }
        else if(m_pParent->GetContactRightFixtureToAICount())
        {
            m_nDirection = PATROL_DIRECTION_LEFT;
        }
        
        if(m_pParent->GetJumpCount())
        {
            if(m_nDirection == PATROL_DIRECTION_LEFT)
            {
                m_pParent->JumpMoveLeft();
            }
            else if(m_nDirection == PATROL_DIRECTION_RIGHT)
            {
                m_pParent->JumpMoveRight();
            }   
        }
        else
        {
            if(m_nDirection == PATROL_DIRECTION_LEFT)
            {
                m_pParent->MoveLeft();
            }
            else if(m_nDirection == PATROL_DIRECTION_RIGHT)
            {
                m_pParent->MoveRight();
            }
        }
    }

    
    FCAIState::Process(dt);
}

void FCAIStateJumpMove::SetState()
{
    
}