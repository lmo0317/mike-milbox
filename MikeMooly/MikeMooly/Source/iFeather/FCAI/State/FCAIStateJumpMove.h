#ifndef FC_AI_STATE_JUMP_MOVE
#define FC_AI_STATE_JUMP_MOVE

#import "FCAIState.h"
class FCAIStateJumpMove : public FCAIState
{
public:
    FCAIStateJumpMove();
    ~FCAIStateJumpMove();
    virtual void Process(ccTime dt);
    virtual const float GetUtility(ccTime dt);
    void SetState();
    
private:
    
    int m_nDirection;
};

#endif
