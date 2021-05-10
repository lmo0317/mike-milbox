#import "FCEventBoxPosition.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "FCGameManager.h"
#import "ActionLayer.h"

void FCEventBoxPosition::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCEventBox::BeginContact(fixtureA,fixtureB);
    
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
        CCLOG(@"EVENT BOX Position FIXTURE ERROR");
    }
}
void FCEventBoxPosition::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCEventBox::EndContact(fixtureA,fixtureB);
}