#import "FCEnemy.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCEnemy::SetStateDeath()
{
    if(m_pBody == NULL)
        return;
    
    if(m_pLevelHelper == NULL)
        return;
    
    b2Vec2 velocity = m_pBody->GetLinearVelocity();    
    SetAllFixtureSensor(true);
    const float fY = m_fBounceSpeed / [[LHSettings sharedInstance] lhPtmRatio];
    m_pBody->SetLinearVelocity(b2Vec2(0,fY * GetRatio()));
       
    if(m_strDyingMotionName == NULL)
    {
        m_bDelete = true;
    }
    else
    {
        SetCurMotion(m_strDyingMotionName);        
    }
    
    LHPathNode* pPathNode = [m_pSprite pathNode];
    if(pPathNode)
    {
        [pPathNode removeFromParentAndCleanup:YES];
    }
    
    if(m_bDamageSensor)
    {
        SetAllFixtureSensor(true);
    }
    
    m_nHP = 0;
    SetHP(m_nHP);
    
    FCCharacter::SetStateDeath();
}