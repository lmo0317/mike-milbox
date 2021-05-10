#ifndef MikeMooly_FCEventBoxStageClear_h
#define MikeMooly_FCEventBoxStageClear_h

#import "FCEventBox.h"
#import "FCEventBoxStageClearData.h"
#import "FCEventBoxStageClearDef.h"

class FCEventBoxStageClear : public FCEventBox
{
public:
    FCEventBoxStageClear();
    ~FCEventBoxStageClear();
    
    void Init(MyLevelHelperLoader * pLevelHelper);
    void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    void Process(ccTime dt);
    
    void Create(NSString* Name);
    void Create(LHSprite* pSprite);
    void Create();
    void SetTag();
    
    void InitEventBoxStageClearData();
    void InitEventBoxStageClearData(FCEventBoxStageClearData* pEventBoxStageClearData);
    
    void SetState(const int nState);
    void Break();
    
private:
    
    int m_nState;
    FCEventBoxStageClearData* m_pEventBoxStageClearData;
};


#endif
