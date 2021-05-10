#ifndef MikeMooly_FCShoot_h
#define MikeMooly_FCShoot_h

#import "FCObject.h"
#import "FCShootData.h"

class FCShoot : public FCObject
{
public:
    
    FCShoot();
    ~FCShoot();
    
    virtual void Process(ccTime dt);
    virtual void Init(MyLevelHelperLoader * pLevelHelper);
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    
    virtual void Create(NSString* Name);
    virtual void Create(LHSprite *pSprite);
    virtual void Create();
    
    void SetTag();
    void SetLifeTime(const float fLifeTime);
    const float GetLifeTime();
    
    void InitShootData();
    void InitShootData(FCShootData* pShootData);
    
private:
    
    float m_fLifeTime;
    ccTime m_dCurTime;
    
    FCShootData* m_pShootData;
};

#endif
