#ifndef FCFIELDITEM
#define FCFIELDITEM


#import "FCObject.h"
#import "FCFieldItemDef.h"
#import "FCFieldItemData.h"

class FCFieldItem : public FCObject
{
public:
    
    FCFieldItem();
    ~FCFieldItem();
    
    virtual void Process(ccTime dt);
    virtual void Init(MyLevelHelperLoader * pLevelHelper);
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    
    
    virtual void Create(NSString* Name);
    virtual void Create(LHSprite *pSprite);
    virtual void Create();
    
    void SetTag();
    void SetState(const int nState);
    void Break();
    
    void InitFieldItemData();
    void InitFieldItemData(FCFieldItemData* pFieldItemData);
    
    void AddFieldItemEffect();
    void FirstEvent();
    
private:
    
    int m_nState;
    b2Vec2 m_vecPrevPos;    
    FCFieldItemData* m_pFieldItemData;
};



#endif
