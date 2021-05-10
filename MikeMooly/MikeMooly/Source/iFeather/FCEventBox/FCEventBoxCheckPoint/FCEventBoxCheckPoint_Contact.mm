#import "FCEventBoxCheckPoint.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"

void FCEventBoxCheckPoint::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
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
        CCLOG(@"EVENT BOX CHECK POINT FIXTURE ERROR");
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain *pGameMain = [pActionLayer GetGameMain];
    FCGameManager* pGameManager = [appDelegate GetGameManager];

    bool bPlayerFixture = pGameMain->IsPlayerFixture(pOtherFixture);
    if([pGameManager GetCheckPoint] == false)
    {
        if(bPlayerFixture)
        {
            [pGameManager SetCheckPoint:true];
            
            ccTime dCurrentTime = pGameMain->GetCurTime();
            int nStageCoin = pGameMain->GetStageCoin();
            int nStageDamage = pGameMain->GetStageDamage();
            
            [pGameManager SetCheckPointTime:dCurrentTime];
            [pGameManager SetCheckPointCoin:nStageCoin];
            [pGameManager SetCheckPointDamage:nStageDamage];
            
            for(int i=0;i<3;i++)
            {
                bool bMissionItem = pGameMain->GetMissionItem(i);
                CCLOG(@"CHECK_POINT SAVE MISSION ITEM = [%d]",bMissionItem);
                [pGameManager SetCheckPointMissionItem:i set:bMissionItem];
            }
            
            Break();
        }
    }
}

void FCEventBoxCheckPoint::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCEventBox::EndContact(fixtureA,fixtureB);
}