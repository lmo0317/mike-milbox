#ifndef FCCHARACTER_H
#define FCCHARACTER_H

#import "FCObject.h"
#import "FCCharacterState.h"
#import "FCCharacterStateStay.h"
#import "FCCharacterStateWalk.h"
#import "FCCharacterStateRun.h"
#import "FCCHaracterStateBounce.h"
#import "FCCharacterStateJump.h"
#import "FCCharacterStateJump2.h"
#import "FCCharacterStateFly.h"
#import "FCCharacterStateFall.h"
#import "FCCharacterStateLanding.h"
#import "FCCharacterStateDamage.h"
#import "FCCharacterStateSkyDamage.h"
#import "FCCharacterStateDeath.h"
#import "FCCharacterStateAttack.h"
#import "FCCharacterStateNone.h"

class FCCharacter : public FCObject
{
public:
    
    FCCharacter();
    ~FCCharacter();
    
    virtual void Init();
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void Process(ccTime dt);
    virtual void InvincibleProcess(ccTime dt);
    virtual void SetHP(const int nHP);
    
    void CreateCharacterState();
    void SetState(const int nState);
    void SetWalkMotionName(NSString* strWalkMotion);         
    void SetStayMotionName(NSString* strStayMotionName);     
    void SetDamageMotionName(NSString* strDamageMotionName); 
    void SetJumpMotionName(NSString* strJumpMotionName);     
    void SetJump2MotionName(NSString* strJump2MotionName);   
    void SetFallMotionName(NSString* strFallMotionName);     
    void SetDyingMotionName(NSString* strDyingMotionName);
    void SetAttackMotionName(NSString* strAttackMotionName);
    void Jump();
    void JumpMoveLeft();
    void JumpMoveRight();
    void MoveLeft();
    void MoveRight();
    void SetWalkSpeed(const float fWalkSpeed);
    void SetJumpMoveSpeed(const float fJumpMoveSpeed);
    void SetJumpSpeed(const float fJumpSpeed);
    void SetJump2Speed(const float fJump2Speed);
    void SetBounceSpeed(const float fBounceSpeed);
    void SetDamageBounceSpeed(const float fDamageBounceSpeed);
    void SetJumpMaxCount(const int nJumpMaxCount) {m_nJumpMaxCount = nJumpMaxCount;}
    void PlayInvincibleEvent();
    
    const int GetState() {return m_nState;}
    const int GetJumpCount() {return m_nJumpCount;}
    const int GetHP() {return m_nHP;}
    
    NSString* GetStateString();
    NSString* GetStateString(const int nState);
    
    void SetInvincible(const bool bInvincible) {m_bInvincible = bInvincible;}
    const bool GetInvincible() {return m_bInvincible;}
    
    void SetInvincibleTime(const float fTime) {m_dInvincibleTime = fTime;}
    const float GetInvincibleTime() {return m_dInvincibleTime;}
    
    void SetOpacity(const int nOpacity) {m_nOpacity = nOpacity;}
    const int GetOpacity() {return m_nOpacity;}
    
    void SetOpacityDirection(const int nDirection) {m_nOpacityDirection = nDirection;}
    const int GetOpacityDirection() {return m_nOpacityDirection;}
    
    void SetBounceDirection(const int nDirection) {m_nBounceDirection = nDirection;}
    const int GetBounceDirection() {return m_nBounceDirection;}

protected:
    virtual void SetStateDeath();
    virtual void SetStateRun();
    virtual void SetStateJump();
    virtual void SetStateWalk();
    virtual void SetStateFly();
    virtual void SetStateFall();
    virtual void SetStateJump2();
    virtual void SetStateStay();
    virtual void SetStateDamage();
    virtual void SetStateSkyDamage();
    virtual void SetStateBounce();
    virtual void SetStateAttack();

    virtual void StateDeathProcess(ccTime dt);
    virtual void StateStayProcess(ccTime dt);
    virtual void StateRunProcess(ccTime dt);
    virtual void StateJumpProcess(ccTime dt);
    virtual void StateJump2Process(ccTime dt);
    virtual void StateWalkProcess(ccTime dt);
    virtual void StateFallProcess(ccTime dt);
    virtual void StateFlyProcess(ccTime dt);
    virtual void StateDamageProcess(ccTime dt);
    virtual void StateSkyDamageProcess(ccTime dt);
    virtual void StateBounceProcess(ccTime dt);
    virtual void StateAttackProcess(ccTime dt);

    bool m_bInvincible;
    int m_nState;
    int m_nJumpCount;
    int m_nHP;
    int m_nJumpMaxCount;
    int m_nOpacity;
    int m_nOpacityDirection;
    int m_nBounceDirection;
    
    float m_fWalkSpeed;
    float m_fJumpMoveSpeed;
    float m_fJumpSpeed;
    float m_fJump2Speed;
    float m_fBounceSpeed;
    float m_fDamageBounceSpeed;
    
    NSString* m_strWalkMotionName;
    NSString* m_strStayMotionName;
    NSString* m_strDamageMotionName;
    NSString* m_strJumpMotionName;
    NSString* m_strJump2MotionName;
    NSString* m_strFallMotionName;
    NSString* m_strDyingMotionName;
    NSString* m_strAttackMotionName;
    
    ccTime m_dDeathStartTime;
    ccTime m_dInvincibleTime;
    FCCharacterState *m_pCharacterState[STATE_MAX];
};

#endif
