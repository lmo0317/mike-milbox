#ifndef FCBLOCK
#define FCBLOCK

#import "FCObject.h"
#import "FCBlockDef.h"
#import "FCBlockData.h"

class FCBlock : public FCObject
{
public:
    
    FCBlock();
    ~FCBlock();
    
    virtual void Process(ccTime dt);
    virtual void Init(MyLevelHelperLoader * pLevelHelper);
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void Create(NSString* Name);
    virtual void Create(LHSprite* pSprite);
    virtual void Create();
    
    void SetTag();
    void SetState(const int nState);
    void InitBlockData();
    void InitBlockData(FCBlockData* pBlockData);
    void AddScore();    
    void SetHP(const int nHP) {m_nHP = nHP;}
    
    const int GetHP() { return m_nHP;}
    
private:

    void Break();
    void MakeFieldItem();
    int  m_nState;
    int  m_nHP;
    bool m_bMakeFieldItem;
    
    NSString* m_strBreakMotion;
    NSString* m_strStayMotion;
    FCBlockData* m_pBlockData;
};


#endif
