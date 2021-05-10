#import "FCEventBoxStageClear.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"

void FCEventBoxStageClear::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
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
        CCLOG(@"EVENT BOX STAGE CELAR FIXTURE ERROR");
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain *pGameMain = [pActionLayer GetGameMain];

    bool bPlayerFixture = pGameMain->IsPlayerFixture(pOtherFixture);
    if(bPlayerFixture)
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        FCGameManager* pGameManager = [appDelegate GetGameManager];
        
        NSString* strNextStage = m_pEventBoxStageClearData->GetNextStage();
        if(strNextStage== NULL)
            return;
        
        [pGameManager StageClear:strNextStage];
        Break();
    }
}

void FCEventBoxStageClear::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCEventBox::EndContact(fixtureA,fixtureB);
}