#import "FCPlayer.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "FCGameManager.h"

void FCPlayer::SetStateDeath()
{
    if(m_pBody == NULL)
        return;
    
    if(m_pLevelHelper == NULL)
        return;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    
    //죽을 경우 체크 포인트 데미지 저장
    pGameMain->AddStageDamage(1);
    int nStageDamage = pGameMain->GetStageDamage();
    [pGameManager SetCheckPointDamage:nStageDamage];
    
    
    m_nHP = 0;
    SetHP(m_nHP);
    b2Vec2 velocity = m_pBody->GetLinearVelocity();    
    SetAllFixtureSensor(true);
    const float fY = m_fJumpSpeed / [[LHSettings sharedInstance] lhPtmRatio];
    
    m_pBody->SetLinearVelocity(b2Vec2(0,fY * GetRatio()));
    SetCurMotion(m_strDyingMotionName);
    FCCharacter::SetStateDeath();
}

void FCPlayer::SetStateDamage()
{
    if(m_bInvincible)
        return;
    
    FCCharacter::SetStateDamage();
    
    
    if(GetState() != STATE_DEATH)
    {
        b2Vec2 velocity = m_pBody->GetLinearVelocity();
        const float fY = m_fDamageBounceSpeed / [[LHSettings sharedInstance] lhPtmRatio];
        
        m_pBody->SetLinearVelocity(b2Vec2(0,fY * GetRatio()));
        PlayInvincibleEvent();
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    pGameMain->AddStageDamage(1);
}