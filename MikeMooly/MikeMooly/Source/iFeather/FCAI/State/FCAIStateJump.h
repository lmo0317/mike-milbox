#ifndef FC_AI_STATE_JUMP
#define FC_AI_STATE_JUMP

#import "FCAIState.h"
class FCAIStateJump : public FCAIState
{
public:
    FCAIStateJump();
    ~FCAIStateJump();
    virtual void Process(ccTime dt);
    virtual const float GetUtility(ccTime dt);
    
    void SetState();
    
private:
    
    int m_nDirection;
};

#endif
