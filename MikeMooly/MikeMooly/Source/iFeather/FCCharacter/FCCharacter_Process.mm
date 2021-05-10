#import "FCCharacter.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "HUDLayer.h"
#import "../iFeatherDef.h"

void FCCharacter::Process(ccTime dt)
{       
    switch(m_nState)
    {
        case STATE_STAY:
            StateStayProcess(dt);
            break;
        case STATE_RUN:
            StateRunProcess(dt);
            break;
        case STATE_JUMP:
            StateJumpProcess(dt);
            break;
        case STATE_JUMP2:
            StateJump2Process(dt);
            break;
        case STATE_WALK:
            StateWalkProcess(dt);
            break;
        case STATE_FALL:
            StateFallProcess(dt);
            break;
        case STATE_FLY:
            StateFlyProcess(dt);
            break;
        case STATE_DAMAGE:
            StateDamageProcess(dt);
            break;
        case STATE_SKY_DAMAGE:
            StateSkyDamageProcess(dt);
            break;
        case STATE_DEATH:
            StateDeathProcess(dt);
            break;
        case STATE_BOUNCE:
            StateBounceProcess(dt);
            break;
        case STATE_ATTACK:
            StateAttackProcess(dt);
            break;
    }
    
    InvincibleProcess(dt);
    FCObject::Process(dt);
}

void FCCharacter::InvincibleProcess(ccTime dt)
{
    if(m_bInvincible == false)
        return;
    
    if(m_dInvincibleTime > 0.f)
    {
        m_dInvincibleTime -= dt;
        
        if(m_nOpacityDirection == 1)
        {
            m_nOpacity += 50;
            if(m_nOpacity > 255)
            {
                m_nOpacityDirection *= -1;
                m_nOpacity = 255;
            }
        }
        else if(m_nOpacityDirection == -1)
        {
            m_nOpacity -= 50;
            if(m_nOpacity < 0)
            {
                m_nOpacityDirection *= -1;
                m_nOpacity = 0;
            }
        }
        
        [m_pSprite setOpacity:m_nOpacity];        
    }
    
    if(m_dInvincibleTime <= 0.f)
    {
        m_bInvincible = false;
        m_nOpacityDirection = -1;
        m_nOpacity = 255;
        [m_pSprite setOpacity:m_nOpacity];
    }
}

void FCCharacter::StateStayProcess(ccTime dt)
{
    
}

void FCCharacter::StateRunProcess(ccTime dt)
{
    
}

void FCCharacter::StateJumpProcess(ccTime dt)
{
    if(m_pBody == NULL)
        return;
    
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    if(velocity.y < 0)
    {
        //아래로 떨어지는 중 fall로 상태를 바꾼다
        SetState(STATE_FALL);
    }
}

void FCCharacter::StateJump2Process(ccTime dt)
{
    if(m_pBody == NULL)
        return;
    
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    if(velocity.y < 0)
    {
        SetState(STATE_FALL);
    }
}

void FCCharacter::StateWalkProcess(ccTime dt)
{
    if(m_pBody == NULL)
        return;
    
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    if(b2Abs(velocity.x) < ALMOST_ZERO && b2Abs(m_vecDirection.x) <ALMOST_ZERO)
    {
        SetState(STATE_STAY);
    }
}

void FCCharacter::StateFallProcess(ccTime dt)
{
    if(m_nContactBottomFixture)
    {
        SetState(STATE_STAY);
    }
}

void FCCharacter::StateFlyProcess(ccTime dt)
{
    
}

void FCCharacter::StateDamageProcess(ccTime dt)
{
    if(IsEndFrame())
    {
        SetState(STATE_STAY);
    }
}

void FCCharacter::StateSkyDamageProcess(ccTime dt)
{
    
}

void FCCharacter::StateDeathProcess(ccTime dt)
{
}

void FCCharacter::StateBounceProcess(ccTime dt)
{
    b2Vec2 velocity = m_pBody->GetLinearVelocity();
    if(velocity.y < 0)
    {
        //아래로 떨어지는 중 fall로 상태를 바꾼다
        SetState(STATE_FALL);
    }
}

void FCCharacter::StateAttackProcess(ccTime dt)
{
    if(IsEndFrame())
    {
        SetState(STATE_STAY);
    }
}
