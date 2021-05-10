#import "FCFieldItem.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCFieldItem::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
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
        CCLOG(@"FIELD ITEM FIXTURE ERROR");
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    bool bIsPlayerMainFixture = pGameMain->IsPlayerMainFixture(pOtherFixture);
    if(bIsPlayerMainFixture)
    {
        //paleyr 머리 충돌 체크
        if([m_pFieldItemData->GetCategory() isEqualToString:@"NONE"] == false)
        {
            //none field item은 작동 안함
            Break();
        }
    }

}

void FCFieldItem::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
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
        CCLOG(@"FIELD ITEM FIXTURE ERROR");
    }
    
 
}
