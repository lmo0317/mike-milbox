#ifndef FC_AI_STATE
#define FC_AI_STATE

#import "FCCharacter.h"
#import "FCAIDef.h"

class FCEnemy;
class FCAIState
{
public:
    FCAIState();
    ~FCAIState();
    
    void Init(FCEnemy* pParent);
    virtual void SetState();
    virtual void Process(ccTime dt);
    virtual const float GetUtility(ccTime dt);
    
protected:
    
    FCEnemy* m_pParent;
    NSString* m_strName;
    ccTime m_dCurTime;
};

#endif
