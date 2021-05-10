#ifndef FCFLATFORM
#define FCFLATFORM


#import "FCObject.h"

class FCPlatForm : public FCObject
{
public:
    
    FCPlatForm();
    ~FCPlatForm();
    
    virtual void Process(ccTime dt);
    virtual void Init(MyLevelHelperLoader * pLevelHelper);
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    
    virtual void Create(NSString* Name);
    virtual void Create(LHSprite* pSprite);
    virtual void Create();
    
    void SetTag();
    void SetState(const int nState);
    
    void AddChild();
    void FirstEvent();
private:
    
    int m_nState;
    b2Vec2 m_vecPrevPos;
};



#endif
