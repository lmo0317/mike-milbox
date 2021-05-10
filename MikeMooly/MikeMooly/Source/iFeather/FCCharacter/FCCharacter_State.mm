#import "FCCharacter.h"
#import "LHSettings.h"


void FCCharacter::CreateCharacterState()
{
    m_pCharacterState[STATE_NONE] = new FCCharacterStateNone;
    m_pCharacterState[STATE_STAY] = new FCCharacterStateStay;
    m_pCharacterState[STATE_WALK] = new FCCharacterStateWalk;
    m_pCharacterState[STATE_RUN] = new FCCharacterStateRun;
    m_pCharacterState[STATE_JUMP] = new FCCharacterStateJump;
    m_pCharacterState[STATE_JUMP2] = new FCCharacterStateJump2;
    m_pCharacterState[STATE_FLY] = new FCCharacterStateFly;
    m_pCharacterState[STATE_FALL] = new FCCharacterStateFall;
    m_pCharacterState[STATE_LANDING] = new FCCharacterStateLanding;
    m_pCharacterState[STATE_DAMAGE] = new FCCharacterStateDamage;
    m_pCharacterState[STATE_SKY_DAMAGE] = new FCCharacterStateSkyDamage;
    m_pCharacterState[STATE_DEATH] = new FCCharacterStateDeath;
    m_pCharacterState[STATE_BOUNCE] = new FCCharacterStateBounce;
    m_pCharacterState[STATE_ATTACK] = new FCCharacterStateAttack;
}

NSString* FCCharacter::GetStateString()
{
    return GetStateString(m_nState);
}

NSString* FCCharacter::GetStateString(const int nState)
{
    switch(m_nState)
    {
        case STATE_WALK:        return @"STATE_WALK";
        case STATE_NONE:        return @"STATE_NONE";
        case STATE_STAY:        return @"STATE_STAY";
        case STATE_RUN:         return @"STATE_RUN";
        case STATE_JUMP:        return @"STATE_JUMP";
        case STATE_JUMP2:       return @"STATE_JUMP2";
        case STATE_FLY:         return @"STATE_FLY";
        case STATE_FALL:        return @"STATE_FALL";
        case STATE_LANDING:     return @"STATE_LANDING";
        case STATE_DAMAGE:      return @"STATE_DAMAGE";
        case STATE_SKY_DAMAGE:  return @"STATE_SKY_DAMAGE";
        case STATE_DEATH:       return @"STATE_DEATH";
        case STATE_BOUNCE:      return @"STATE_BOUNCE";
        case STATE_ATTACK:      return @"STATE_ATTACK";
    }
    
    return @"STATE_NONE";    
}

void FCCharacter::SetState(const int nState)
{
    if(nState == STATE_DAMAGE)
    {
        if(m_bInvincible)
            return;
    }
    
    
    if(m_pCharacterState[m_nState]->SetState(nState) == false)
    {
        return;
    }
    
    m_nState = nState;    
    //CCLOG(@"SET STATE [%@]",GetStateString(nState));
    switch(nState)
    {
        case STATE_WALK:
            SetStateWalk();
            break;
        case STATE_JUMP:
            SetStateJump();
            break;
        case STATE_FALL:
            SetStateFall();
            break;
        case STATE_JUMP2:
            SetStateJump2();
            break;
        case STATE_STAY:
            SetStateStay();
            break;
        case STATE_DAMAGE:
            SetStateDamage();
            break;
        case STATE_SKY_DAMAGE:
            SetStateSkyDamage();
            break;
        case STATE_DEATH:
            SetStateDeath();
            break;
        case STATE_BOUNCE:
            SetStateBounce();
            break;
        case STATE_ATTACK:
            SetStateAttack();
            break;
    }
}


void FCCharacter::SetStateRun()
{
}

void FCCharacter::SetStateFall()
{
    SetCurMotion(m_strFallMotionName);
}

void FCCharacter::SetStateBounce()
{
    if(m_pBody == NULL)
        return;
    
    if(m_pLevelHelper == NULL)
        return;
    
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    const float fY = m_fBounceSpeed / [[LHSettings sharedInstance] lhPtmRatio];
    m_pBody->SetLinearVelocity(b2Vec2(0,fY * GetRatio()));        
    SetCurMotion(m_strJumpMotionName);
}

void FCCharacter::SetStateAttack()
{
    if(m_pBody == NULL)
        return;
    
    if(m_pLevelHelper == NULL)
        return;
    
    SetCurMotion(m_strAttackMotionName); 
}

void FCCharacter::SetStateJump()
{
    if(m_pBody == NULL)
        return;
    
    if(m_pLevelHelper == NULL)
        return;
    
    //바닥을 밟고 있지 않으면 점프 할수 없음
    if(m_nContactBottomFixture == false)
        return;
    
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    const float fY = m_fJumpSpeed / [[LHSettings sharedInstance] lhPtmRatio];
    
    m_pBody->SetLinearVelocity(b2Vec2(0,fY * GetRatio()));        
    SetCurMotion(m_strJumpMotionName);
}

void FCCharacter::SetStateJump2()
{
    if(m_pBody == NULL)
        return;
    
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    const float fY = (m_fJump2Speed / [[LHSettings sharedInstance] lhPtmRatio]);
    
    m_pBody->SetLinearVelocity(b2Vec2(0,fY * GetRatio()));            
    SetCurMotion(m_strJump2MotionName);
}

void FCCharacter::SetStateStay()
{
    m_nJumpCount = 0;
    
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    m_pBody->SetLinearVelocity(b2Vec2(0,velocity.y));
    
    if(m_strStayMotionName)
    {
        SetCurMotion(m_strStayMotionName);
    }
}

void FCCharacter::SetStateWalk()
{
    m_nJumpCount = 0;
    SetCurMotion(m_strWalkMotionName);
}

void FCCharacter::SetStateFly()
{
    
}

void FCCharacter::SetStateDamage()
{
    if(m_nState == STATE_DEATH)
        return;
    
    SetHP(m_nHP - 1);
    if(m_nHP <= 0)
    {
        SetState(STATE_DEATH);
    }
    else
    {
        SetCurMotion(m_strDamageMotionName);
    }
}

void FCCharacter::SetStateSkyDamage()
{
    
}

void FCCharacter::SetStateDeath()
{
}
