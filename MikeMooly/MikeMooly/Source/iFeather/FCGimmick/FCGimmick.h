#ifndef MikeMooly_FCGimmick_h
#define MikeMooly_FCGimmick_h

#import "FCObject.h"
#import "FCGimmickData.h"

class FCGimmick : public FCObject
{
public:
    
    FCGimmick();
    ~FCGimmick();
    
    virtual void Process(ccTime dt);
    virtual void Init(MyLevelHelperLoader * pLevelHelper);
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    
    virtual void Create(NSString* Name);
    virtual void Create(LHSprite *pSprite);
    virtual void Create();
    
    void SetTag();
    
    void InitGimmickData();
    void InitGimmickData(FCGimmickData* pGimmickData);
        
private:
    ccTime m_dCurTime;
    FCGimmickData* m_pGimmickData;
};

#endif
