#import "FCPlatForm.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCPlatForm::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCObject::BeginContact(fixtureA,fixtureB);
    b2Fixture* pMyFixture = NULL;
    b2Fixture* pOtherFixture = NULL;
    
    if(IsMyChildSpriteFixture(fixtureA))
    {
        pMyFixture = fixtureA;
        pOtherFixture = fixtureB;
    }
    else if(IsMyChildSpriteFixture(fixtureB))
    {
        pMyFixture = fixtureB;
        pOtherFixture = fixtureA;
    }
    else
    {
        return;
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    if(pPlayer->IsMyLeftFixture(pOtherFixture))
    {
        m_nContactLeftFixtureToPlayer += 1;
    }
    
    if(pPlayer->IsMyTopFixture(pOtherFixture))
    {
        m_nContactTopFixtureToPlayer += 1;
    }
    
    if(pPlayer->IsMyBottomFixture(pOtherFixture))
    {
        m_nContactBottomFixtureToPlayer += 1;
    }
    
    if(pPlayer->IsMyRightFixture(pOtherFixture))
    {
        
        m_nContactRightFixtureToPlayer += 1;
    }
}

void FCPlatForm::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCObject::EndContact(fixtureA,fixtureB);
    
    b2Fixture* pMyFixture = NULL;
    b2Fixture* pOtherFixture = NULL;
    
    if(IsMyChildSpriteFixture(fixtureA))
    {
        pMyFixture = fixtureA;
        pOtherFixture = fixtureB;
    }
    else if(IsMyChildSpriteFixture(fixtureB))
    {
        pMyFixture = fixtureB;
        pOtherFixture = fixtureA;
    }
    else
    {
        assert(1);
        CCLOG(@"FCPLATFORM FIXTURE ERROR");
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    if(pPlayer->IsMyLeftFixture(pOtherFixture))
    {
        m_nContactLeftFixtureToPlayer -= 1;
    }
    
    if(pPlayer->IsMyTopFixture(pOtherFixture))
    {
        m_nContactTopFixtureToPlayer -= 1;
    }
    
    if(pPlayer->IsMyBottomFixture(pOtherFixture))
    {
        m_nContactBottomFixtureToPlayer -= 1;
    }
    
    if(pPlayer->IsMyRightFixture(pOtherFixture))
    {
        m_nContactRightFixtureToPlayer -= 1;
    }
}
