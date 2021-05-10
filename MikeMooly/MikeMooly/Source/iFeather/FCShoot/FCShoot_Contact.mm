#import "FCShoot.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCShoot::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
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
        CCLOG(@"FCSHOOT FIXTURE ERROR");    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    if(pPlayer->GetState() != STATE_DEATH)
    {
        bool bPlayerFixture = pGameMain->IsPlayerFixture(pOtherFixture);
        if(bPlayerFixture)
        {
            if(pOtherFixture->IsSensor())
                return;
            
            pPlayer->SetState(STATE_DAMAGE);
        }
    }
}

void FCShoot::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
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
        CCLOG(@"FCSHOOT FIXTURE ERROR");
    }
    
    
}
