#ifndef MikeMooly_FCEventBoxCheckPoint_h
#define MikeMooly_FCEventBoxCheckPoint_h

#import "FCEventBox.h"
#import "FCEventBoxCheckPointData.h"
#import "FCEventBoxCheckPointDef.h"

class FCEventBoxCheckPoint : public FCEventBox
{
public:
    FCEventBoxCheckPoint();
    ~FCEventBoxCheckPoint();
    
    void Init(MyLevelHelperLoader * pLevelHelper);
    void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    void Process(ccTime dt);
    
    void Create(NSString* Name);
    void Create(LHSprite* pSprite);
    void Create();
    void SetTag();
    
    void InitEventBoxCheckPointData();
    void InitEventBoxCheckPointData(FCEventBoxCheckPointData* pEventBoxCheckPointData);
    
    void Break();
    void SetState(const int nState);
    
private:
    
    FCEventBoxCheckPointData* m_pEventBoxCheckPointData;
    int m_nState;

};


#endif
