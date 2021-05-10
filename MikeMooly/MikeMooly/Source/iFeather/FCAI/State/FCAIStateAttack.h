#ifndef FC_AI_STATE_ATTACK
#define FC_AI_STATE_ATTACK

#import "FCAIState.h"
class FCAIStateAttack : public FCAIState
{
public:
    FCAIStateAttack();
    ~FCAIStateAttack();
    virtual void Process(ccTime dt);
    virtual const float GetUtility(ccTime dt);
    void SetState();
    
private:
    
};

#endif
