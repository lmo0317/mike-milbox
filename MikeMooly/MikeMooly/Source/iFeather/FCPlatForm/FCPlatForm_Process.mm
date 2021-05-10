#import "FCPlatForm.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCPlatForm::Process(ccTime dt)
{

    float fDeltaX = m_pBody->GetPosition().x - m_vecPrevPos.x;
    float fDeltaY = m_pBody->GetPosition().y - m_vecPrevPos.y;
    float fAgnle = m_pBody->GetAngle();
    
    if(m_nContactBottomFixtureToPlayer)
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
        FCGameMain* pGameMain = [pActionLayer GetGameMain];
        FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
        
        b2Vec2 vecPosition;
        vecPosition.x = pPlayer->GetBody()->GetPosition().x + fDeltaX;
        vecPosition.y = pPlayer->GetBody()->GetPosition().y + fDeltaY;
        pPlayer->GetBody()->SetTransform(vecPosition,0);
    }
    
    if(m_pChildSprite)
    {
        b2Vec2 vecPosition;
        vecPosition.x = m_pBody->GetPosition().x;
        vecPosition.y = m_pBody->GetPosition().y;
        
        m_pChildSprite.body->SetTransform(vecPosition,fAgnle);
    }
    
    m_vecPrevPos = m_pBody->GetPosition();
    FCObject::Process(dt);
}