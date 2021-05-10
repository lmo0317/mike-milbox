#ifndef MikeMooly_FCHitBox_h
#define MikeMooly_FCHitBox_h

#import "FCObject.h"
#import "FCHitBoxData.h"

class FCHitBox : public FCObject
{
public:
    
    FCHitBox();
    ~FCHitBox();
    
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
    
    void InitHitBoxData();
    void InitHitBoxData(FCHitBoxData* pHitBoxData);
    
private:
    
    float m_fLifeTime;
    ccTime m_dCurTime;
    
    FCHitBoxData* m_pHitBoxData;
};

#endif
