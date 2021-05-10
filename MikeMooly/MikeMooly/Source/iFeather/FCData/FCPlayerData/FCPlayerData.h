#ifndef MikeMooly_FCPlayerData_h
#define MikeMooly_FCPlayerData_h

#import "FCStateDataManager.h"
#include <map>
#include <vector>

struct FCPlayerData 
{
public:
    
    FCPlayerData();
    ~FCPlayerData();
    
    void Copy(FCPlayerData* pPlayerData);
    void SetName(NSString* strName);
    void SetWalkMotionName(NSString* strWalkMotionName);
    void SetStayMotionName(NSString* strStayMotionName);
    void SetDamageMotionName(NSString* strDamageMotionName);
    void SetJumpMotionName(NSString* strJumpMotoinName);
    void SetJump2MotionName(NSString* strJump2MOtionName);
    void SetFallMotionName(NSString* strFallMotionName);
    void SetDyingMotionName(NSString* strDyingMotoinName);
    void SetAttackMotionName(NSString* strAttackMotionName);
    
    void SetWalkSpeed(const float fWalkSpeed);
    void SetJumpMoveSpeed(const float fJumpMoveSpeed);
    void SetJumpSpeed(const float fJumpSpeed);
    void SetJump2Speed(const float fJump2Speed);
    void SetDeathTime(const float fDeathTime);
    void SetBounceSpeed(const float fBounceSpeed);
    void SetDamageBounceSpeed(const float fDamageBounceSpeed);
    void SetJumpMaxCount(const int nJumpMaxCount) {m_nJumpMaxCount = nJumpMaxCount;}
    
    const float GetWalkSpeed();
    const float GetJumpMoveSpeed();
    const float GetJumpSpeed();
    const float GetJump2Speed();
    const float GetDeathTime();
    const float GetBounceSpeed();
    const float GetDamageBounceSpeed();
    const int GetJumpMaxCount() {return m_nJumpMaxCount;}
    
    NSString* GetName();
    NSString* GetWalkMotionName();
    NSString* GetStayMotionName();
    NSString* GetDamageMotionName();
    NSString* GetJumpMotionName();
    NSString* GetJump2MotionName();
    NSString* GetFallMotionName();
    NSString* GetDyingMotionName();
    NSString* GetAttackMotionName();
    
    void AddStateData(NSString* pID,const int nCategory,NSString *pValue);
    NSString* GetStateData(NSString* pID,const int nCategory);
    
private:
    NSString* m_strName;
    NSString* m_strWalkMotionName;
    NSString* m_strStayMotionName;
    NSString* m_strDamageMotionName;
    NSString* m_strJumpMotionName;
    NSString* m_strJump2MotionName;
    NSString* m_strFallMotionName;
    NSString* m_strDyingMotionName;
    NSString* m_strAttackMotionName;
    
    float m_fWalkSpeed;
    float m_fJumpMoveSpeed;
    float m_fJumpSpeed;
    float m_fJump2Speed;
    float m_fDeathTime;
    float m_fBounceSpeed;
    float m_fDamageBounceSpeed;
    float m_nJumpMaxCount;
    FCStateDataManager m_StateDataManager;
};

#endif
