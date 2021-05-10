#ifndef FC_AI_STATE_PATROL
#define FC_AI_STATE_PATROL

#import "FCAIState.h"
class FCAIStatePatrol : public FCAIState
{
public:
    FCAIStatePatrol();
    ~FCAIStatePatrol();
    virtual void Process(ccTime dt);
    virtual const float GetUtility(ccTime dt);
    
    void SetState();
private:
    
    int m_nDirection;
};

#endif
