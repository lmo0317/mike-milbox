#import "FCCharacter.h"
#import "LHSettings.h"

FCCharacter::FCCharacter():
m_bInvincible(false),
m_nState(STATE_NONE),
m_nJumpCount(0),
m_nHP(c_nHP),
m_nJumpMaxCount(2),
m_nOpacity(0),
m_nOpacityDirection(-1),
m_nBounceDirection(1),
m_fWalkSpeed(c_fWalkSpeed),
m_fJumpMoveSpeed(c_fJumpMoveSpeed),
m_fJumpSpeed(c_fJumpSpeed),
m_fJump2Speed(c_fJump2Speed),
m_fBounceSpeed(c_fBounceSpeed),
m_fDamageBounceSpeed(c_fDamageBounceSpeed),
m_dDeathStartTime(0),
m_dInvincibleTime(0)
{
    CreateCharacterState();
    m_strWalkMotionName = @"";
    m_strStayMotionName = @"";
    m_strDamageMotionName = @"";
    m_strJumpMotionName = @"";
    m_strJump2MotionName = @"";
    m_strFallMotionName = @"";
    m_strDyingMotionName = @"";
    m_strAttackMotionName = @"";
}

FCCharacter::~FCCharacter()
{
    
}

void FCCharacter::Init()
{
    FCObject::Init();
}

void FCCharacter::MoveLeft()
{
    m_pSprite.flipX = YES;
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    const float fX = -m_fWalkSpeed / [[LHSettings sharedInstance] lhPtmRatio];
    
    m_pBody->SetLinearVelocity(b2Vec2(fX * GetRatio(),velocity.y));
}

void FCCharacter::MoveRight()
{
    m_pSprite.flipX = NO;
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    const float fX = m_fWalkSpeed / [[LHSettings sharedInstance] lhPtmRatio];
    
    m_pBody->SetLinearVelocity(b2Vec2(fX * GetRatio(),velocity.y));
}

void FCCharacter::JumpMoveLeft()
{
    m_pSprite.flipX = YES;
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    const float fX = -m_fJumpMoveSpeed / [[LHSettings sharedInstance] lhPtmRatio];
    
    m_pBody->SetLinearVelocity(b2Vec2(fX * GetRatio(),velocity.y));
}

void FCCharacter::JumpMoveRight()
{
    m_pSprite.flipX = NO;
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    const float fX = m_fJumpMoveSpeed / [[LHSettings sharedInstance] lhPtmRatio];
    
    m_pBody->SetLinearVelocity(b2Vec2(fX * GetRatio(),velocity.y));
}

void FCCharacter::Jump()
{
    m_pSprite.flipX = NO;
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    
    m_pBody->SetLinearVelocity(b2Vec2(0,velocity.y));    
}

void FCCharacter::SetWalkMotionName(NSString* strWalkMotion)
{
    m_strWalkMotionName = strWalkMotion;
}

void FCCharacter::SetStayMotionName(NSString* strStayMotionName)
{
    m_strStayMotionName = strStayMotionName;
}

void FCCharacter::SetDamageMotionName(NSString* strDamageMotionName) 
{
    m_strDamageMotionName = strDamageMotionName;
}

void FCCharacter::SetJumpMotionName(NSString* strJumpMotionName) 
{
    m_strJumpMotionName = strJumpMotionName;
}

void FCCharacter::SetJump2MotionName(NSString* strJump2MotionName) 
{
    m_strJump2MotionName = strJump2MotionName;
}

void FCCharacter::SetFallMotionName(NSString* strFallMotionName) 
{
    m_strFallMotionName = strFallMotionName;
}

void FCCharacter::SetDyingMotionName(NSString* strDyingMotionName) 
{
    m_strDyingMotionName = strDyingMotionName;
}

void FCCharacter::SetAttackMotionName(NSString* strAttackMotionName)
{
    m_strAttackMotionName = strAttackMotionName;    
}

void FCCharacter::SetHP(const int nHP)
{
    m_nHP = nHP;
}

void FCCharacter::SetWalkSpeed(const float fWalkSpeed)
{
    m_fWalkSpeed = fWalkSpeed;
}

void FCCharacter::SetJumpMoveSpeed(const float fJumpMoveSpeed)
{
    m_fJumpMoveSpeed = fJumpMoveSpeed;
}

void FCCharacter::SetJumpSpeed(const float fJumpSpeed)
{
    m_fJumpSpeed = fJumpSpeed;
}

void FCCharacter::SetJump2Speed(const float fJump2Speed)
{
    m_fJump2Speed = fJump2Speed;
}

void FCCharacter::SetBounceSpeed(const float fBounceSpeed)
{
    m_fBounceSpeed = fBounceSpeed;
}

void FCCharacter::SetDamageBounceSpeed(const float fDamageBounceSpeed)
{
    m_fDamageBounceSpeed = fDamageBounceSpeed;
}

void FCCharacter::PlayInvincibleEvent()
{
    SetInvincible(true);
    SetInvincibleTime(c_fInvincibleTime);
    SetOpacity(255);
    SetOpacityDirection(-1);
}