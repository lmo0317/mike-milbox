#ifndef MikeMooly_FCBackGround_h
#define MikeMooly_FCBackGround_h

#import "FCObject.h"
//#import "FCBackGroundData.h"

class FCBackGround : public FCObject
{
public:
    
    FCBackGround();
    ~FCBackGround();
    
    virtual void Process(ccTime dt);
    virtual void Init(MyLevelHelperLoader * pLevelHelper);
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    
    virtual void Create(NSString* Name);
    virtual void Create(LHSprite *pSprite);
    virtual void Create();
    
    void SetTag();
    
    //void InitBackGroundData();
    //void InitBackGroundData(FCBackGroundData* pBackGroundData);
        
private:
    ccTime m_dCurTime;
    //FCBackGroundData* m_pBackGroundData;
};

#endif
