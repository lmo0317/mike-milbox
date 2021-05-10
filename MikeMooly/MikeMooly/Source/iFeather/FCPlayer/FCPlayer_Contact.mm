#import "FCPlayer.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "HUDLayer.h"

void FCPlayer::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{ 
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
        CCLOG(@"FCPLAYER FIXTURE ERROR");
    }
    
    GimmickCheck(pOtherFixture);
    FCCharacter::BeginContact(fixtureA,fixtureB);
}

void FCPlayer::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCCharacter::EndContact(fixtureA,fixtureB);
}

void FCPlayer::GimmickCheck(b2Fixture* pFixture)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    bool bIsGimmickFixture = pGameMain->IsGimmickFixture(pFixture);
    if(bIsGimmickFixture)
    {
        FCGimmick* pGimmick = (FCGimmick*)pGameMain->GetObjectFromFixture(pFixture);
        
        if([pGimmick->GetTarget() isEqualToString:@"PLAYER"])
        {
            if(pGimmick->GetOneShot()) {
                SetState(STATE_DEATH);
            }
            else {
                SetState(STATE_DAMAGE);
            }
        }
        else if([pGimmick->GetTarget() isEqualToString:@"ENEMY"])
        {
            
        }
        else if([pGimmick->GetTarget() isEqualToString:@"ALL"])
        {
            if(pGimmick->GetOneShot()) {
                SetState(STATE_DEATH);
            }
            else {
                SetState(STATE_DAMAGE);                
            }
        }
        
    }
}

