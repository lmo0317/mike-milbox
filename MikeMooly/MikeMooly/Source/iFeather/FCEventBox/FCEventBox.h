#ifndef MikeMooly_FCEventBox_h
#define MikeMooly_FCEventBox_h

#import "FCObject.h"
class FCEventBox : public FCObject
{
public:
    FCEventBox();
    ~FCEventBox();
    
    virtual void Init();
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void Process(ccTime dt);

private:
    
};


#endif
