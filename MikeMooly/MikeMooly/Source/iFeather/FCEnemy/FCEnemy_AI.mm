#import "FCEnemy.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCAIDef.h"
#import "FCAIState.H"
#import "FCAIStateStay.h"
#import "FCAIStatePatrol.h"
#import "FCAIStateJumpMove.h"
#import "FCAIStateAttack.h"
#import "FCAIStateJump.h"

void FCEnemy::CreateAIState()
{
    m_pAIState[AI_STATE_PATROL] = new FCAIStatePatrol;
    m_pAIState[AI_STATE_STAY] = new FCAIStateStay;
    m_pAIState[AI_STATE_JUMP] = new FCAIStateJump;
    m_pAIState[AI_STATE_JUMP_MOVE] = new FCAIStateJumpMove;
    m_pAIState[AI_STATE_ATTACK] = new FCAIStateAttack;
    
    for(int i = 0;i<AI_STATE_MAX;++i)
    {
        m_pAIState[i]->Init(this);
    }
}