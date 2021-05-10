#ifndef FCCHARACTER_DEF_H
#define FCCHARACTER_DEF_H

enum {
  STATE_NONE,
    STATE_STAY,
    STATE_WALK,
    STATE_RUN,
    STATE_JUMP,
    STATE_JUMP2,
    STATE_FLY,
    STATE_FALL,
    STATE_LANDING,
    STATE_DAMAGE,
    STATE_SKY_DAMAGE,
    STATE_DEATH,
    STATE_BOUNCE,
    STATE_ATTACK,
    STATE_MAX
};

#define c_nHP               1
#define c_fWalkSpeed        140.f
#define c_fJumpMoveSpeed    115.f
#define c_fJumpSpeed        430.f
#define c_fJump2Speed       300.f
#define c_tDeathTime        3.f

#define c_fDamageBounceSpeed  600.f
#define c_fBounceSpeed      300.f
#define c_fInvincibleTime   1.f



#endif