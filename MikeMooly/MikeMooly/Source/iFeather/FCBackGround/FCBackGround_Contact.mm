#import "FCBackGround.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCBackGround::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCObject::BeginContact(fixtureA,fixtureB);
    b2Fixture* pMyFixture = NULL;
    b2Fixture* pOtherFixture = NULL;
    
    if(IsMyFixture(fixtureA))
    {
        pMyFixture = fixtureA;
        pOtherFixture = fixtureB;
    }
    else if(IsMyFixture(fixtureB))
    {
        pMyFixture = fixtureB;
        pOtherFixture = fixtureA;
    }
    else
    {
        assert(1);
        CCLOG(@"BackGround FIXTURE ERROR");
    }
}

void FCBackGround::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCObject::EndContact(fixtureA,fixtureB);
    
    b2Fixture* pMyFixture = NULL;
    b2Fixture* pOtherFixture = NULL;
    
    if(IsMyFixture(fixtureA))
    {
        pMyFixture = fixtureA;
        pOtherFixture = fixtureB;
    }
    else if(IsMyFixture(fixtureB))
    {
        pMyFixture = fixtureB;
        pOtherFixture = fixtureA;
    }
    else
    {
        assert(1);
        CCLOG(@"BackGround FIXTURE ERROR");
    }
    
    
}
