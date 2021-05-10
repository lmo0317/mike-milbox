#import "FCEventBoxPortal.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "FCGameManager.h"
#import "ActionLayer.h"

void FCEventBoxPortal::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
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
        CCLOG(@"EVENT BOX PORTAL FIXTURE ERROR");
    }
    
    if(m_nState != EVENT_BOX_PORTAL_STATE_STAY)
        return;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    if(pPlayer->GetState() != STATE_DEATH)
    {
        bool bPlayerFixture = pGameMain->IsPlayerFixture(pOtherFixture);
        if(bPlayerFixture)
        {
            //해당 스테이지 로딩
            if(m_pEventBoxPortalData)
            {
                if([m_pEventBoxPortalData->GetType() isEqualToString:@"MAP"])
                {
                    if([pGameManager GetLoadingState] == LOADING_STATE_NONE)
                    {
                        NSString* pMapName = m_pEventBoxPortalData->GetMapName();            
                        if(pGameManager)
                        {
                            [pGameManager WorldChange:pMapName];
                        }
                    }
                }
                else if([m_pEventBoxPortalData->GetType() isEqualToString:@"EVENT_BOX_POSITION"])
                {
                    if([pGameManager GetPortalState] == PORTAL_STATE_NONE)
                    {
                        NSString* pEventBoxPosition = m_pEventBoxPortalData->GetEventBoxPositionName();
                        if(pGameManager)
                        {
                            [pGameManager MoveToEventBoxPosition:pEventBoxPosition];
                        }
                    }
                }
            }
        }
    }
}
void FCEventBoxPortal::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCEventBox::EndContact(fixtureA,fixtureB);
}