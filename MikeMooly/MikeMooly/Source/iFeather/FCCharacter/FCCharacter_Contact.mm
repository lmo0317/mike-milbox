#import "FCCharacter.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCCharacter::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCObject::BeginContact(fixtureA,fixtureB);
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    //field item 체크 하지 않음
    if(pGameMain->IsFieldItemFixture(fixtureA) || pGameMain->IsFieldItemFixture(fixtureB))
        return;
    
    if(fixtureA == m_pBottomFixture || fixtureB == m_pBottomFixture)
    {
        m_nContactBottomFixture += 1;
    }
    
    if(fixtureA == m_pTopFixture || fixtureB == m_pTopFixture)
    {
        m_nContactTopFixture += 1;
    }
    
    if(fixtureA == m_pLeftFixture || fixtureB == m_pLeftFixture)
    {
        m_nContactLeftFixture += 1;
    }
    
    if(fixtureA == m_pRightFixture || fixtureB == m_pRightFixture)
    {
        m_nContactRightFixture += 1;
    }
    
    if(fixtureA == m_pLeftBanisterFixture || fixtureB == m_pLeftBanisterFixture)
    {
        m_nContactLeftBanisterFixture += 1;
    }
    
    if(fixtureA == m_pRightBanisterFixture || fixtureB == m_pRightBanisterFixture)
    {
        m_nContactRightBanisterFixture += 1;
    }
}

void FCCharacter::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{  
    FCObject::EndContact(fixtureA,fixtureB);
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    //field item은 체크하지 않는다
    if(pGameMain->IsFieldItemFixture(fixtureA) || pGameMain->IsFieldItemFixture(fixtureB))
        return;
    
    if(fixtureA == m_pBottomFixture || fixtureB == m_pBottomFixture)
    {
        m_nContactBottomFixture -= 1;
    }
    
    if(fixtureA == m_pTopFixture || fixtureB == m_pTopFixture)
    {
        m_nContactTopFixture -= 1;
    }
    
    if(fixtureA == m_pLeftFixture || fixtureB == m_pLeftFixture)
    {
        m_nContactLeftFixture -= 1;
    }
    
    if(fixtureA == m_pRightFixture || fixtureB == m_pRightFixture)
    {
        m_nContactRightFixture -= 1;
    }
    
    if(fixtureA == m_pLeftBanisterFixture || fixtureB == m_pLeftBanisterFixture)
    {
        m_nContactLeftBanisterFixture -= 1;
    }
    
    if(fixtureA == m_pRightBanisterFixture || fixtureB == m_pRightBanisterFixture)
    {
        m_nContactRightBanisterFixture -= 1;
    }
}