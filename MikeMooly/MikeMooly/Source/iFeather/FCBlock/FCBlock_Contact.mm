#import "FCBlock.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCBlock::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{ 
    //player의 top 
    //block의 bottom
    
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
        CCLOG(@"FCBLOCK FIXTURE ERROR");
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    b2Vec2 velocity = pPlayer->GetBody()->GetLinearVelocity();
    bool bIsPlayerTopFixture = pGameMain->IsPlayerTopFixture(pOtherFixture);
    
    if(bIsPlayerTopFixture && (pPlayer->GetState() == STATE_JUMP || pPlayer->GetState() == STATE_JUMP2))
    {
        //paleyr 머리 충돌 체크
        Break();
    }
    
    //Enemy와 충돌 체크
    bool bIsEnemyFixture = pGameMain->IsEnemyFixture(pOtherFixture);
    if(bIsEnemyFixture)
    {
        
    }
    
    FCObject::BeginContact(fixtureA,fixtureB);
}

void FCBlock::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCObject::EndContact(fixtureA,fixtureB);
}