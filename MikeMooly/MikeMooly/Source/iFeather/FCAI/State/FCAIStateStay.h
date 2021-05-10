#ifndef FC_AI_STATE_STAY
#define FC_AI_STATE_STAY

#import "FCAIState.h"
class FCAIStateStay : public FCAIState
{
public:
    FCAIStateStay();
    ~FCAIStateStay();
    virtual void Process(ccTime dt);
    virtual const float GetUtility(ccTime dt);
    
    void SetState();
    
private:
    
};

#endif
