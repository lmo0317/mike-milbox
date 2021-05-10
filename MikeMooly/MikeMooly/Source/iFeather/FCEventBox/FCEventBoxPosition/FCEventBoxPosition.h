#ifndef MikeMooly_FCEventBoxPosition_h
#define MikeMooly_FCEventBoxPosition_h

#import "FCEventBox.h"
//#import "FCEventBoxPositionData.h"

class FCEventBoxPosition : public FCEventBox
{
public:
    FCEventBoxPosition();
    ~FCEventBoxPosition();
    
    void Init(MyLevelHelperLoader * pLevelHelper);
    void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    void Process(ccTime dt);
    
    void Create(NSString* Name);
    void Create(LHSprite* pSprite);
    void Create();
    void SetTag();
    
    //void InitEventBoxPositionData();
    //void InitEventBoxPositionData(FCEventBoxPositionData* pEventBoxPositionData);
    
private:
    
    //FCEventBoxPositionData* m_pEventBoxPositionData;
};


#endif
