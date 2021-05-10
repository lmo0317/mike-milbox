#import "FCAIStateJump.h"
#import "FCEnemy.h"
//#import "FCUtil.h"

FCAIStateJump::FCAIStateJump():
m_nDirection(PATROL_DIRECTION_LEFT)
{
    m_strName = @"JUMP";
}

FCAIStateJump::~FCAIStateJump()
{
    
}

const float FCAIStateJump::GetUtility(ccTime dt)
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

void FCAIStateJump::Process(ccTime dt)
{
    if(m_pParent)
    {
        /*
        if(m_pParent->GetContactLeftFixtureToAICount())
        {
            m_nDirection = PATROL_DIRECTION_RIGHT;
        }
        else if(m_pParent->GetContactRightFixtureToAICount())
        {
            m_nDirection = PATROL_DIRECTION_LEFT;
        }
        */
        
        /*
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
        */
        
        if(m_pParent->GetJumpCount() == 0)
        {
            m_pParent->Jump();
        }
        
        if(m_pParent->GetState() != STATE_JUMP)
        {
            m_pParent->SetState(STATE_JUMP);
        }
    }

    
    FCAIState::Process(dt);
}

void FCAIStateJump::SetState()
{
    
}