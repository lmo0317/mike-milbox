#ifndef MikeMooly_FCEventBoxPortal_h
#define MikeMooly_FCEventBoxPortal_h

#import "FCEventBox.h"
#import "FCEventBoxPortalData.h"
#import "FCEventBoxPortalDef.h"

class FCEventBoxPortal : public FCEventBox
{
public:
    FCEventBoxPortal();
    ~FCEventBoxPortal();
    
    void Init(MyLevelHelperLoader * pLevelHelper);
    void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    void Process(ccTime dt);
    
    void Create(NSString* Name);
    void Create(LHSprite* pSprite);
    void Create();
    void SetTag();
    
    void InitEventBoxPortalData();
    void InitEventBoxPortalData(FCEventBoxPortalData* pEventBoxPortalData);
    
    void SetState(const int nState);
    
private:
    
    FCEventBoxPortalData* m_pEventBoxPortalData;
    int m_nState;
};


#endif
