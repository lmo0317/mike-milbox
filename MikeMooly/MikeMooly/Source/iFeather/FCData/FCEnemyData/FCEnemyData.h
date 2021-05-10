#ifndef MikeMooly_FCEnemyData_h
#define MikeMooly_FCEnemyData_h

#import "FCStateDataManager.h"
#include <map>
#include <vector>

struct FCEnemyData 
{
public:
    
    FCEnemyData();
    ~FCEnemyData();
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetAIName(NSString* strAIName);
    NSString* GetAIName();
    
    void Copy(FCEnemyData* pEnemyData);
    void SetWalkMotionName(NSString* strWalkMotionName);
    void SetStayMotionName(NSString* strStayMotionName);
    void SetDamageMotionName(NSString* strDamageMotionName);
    void SetJumpMotionName(NSString* strJumpMotoinName);
    void SetJump2MotionName(NSString* strJump2MOtionName);
    void SetFallMotionName(NSString* strFallMotionName);
    void SetDyingMotionName(NSString* strDyingMotoinName);
    void SetAttackMotionName(NSString* strAttackMotionName);
    
    void SetHP(const int nHP);
    void SetWalkSpeed(const float fWalkSpeed);
    void SetJumpMoveSpeed(const float fJumpMoveSpeed);
    void SetJumpSpeed(const float fJumpSpeed);
    void SetJump2Speed(const float fJump2Speed);
    void SetBounceSpeed(const float fBounceSpeed);
    void SetDamageBounceSpeed(const float fDamageBounceSpeed);
    
    const int GetHP();
    const float GetWalkSpeed();
    const float GetJumpMoveSpeed();
    const float GetJumpSpeed();
    const float GetJump2Speed();
    const float GetBounceSpeed();
    const float GetDamageBounceSpeed();
    
    NSString* GetWalkMotionName();
    NSString* GetStayMotionName();
    NSString* GetDamageMotionName();
    NSString* GetJumpMotionName();
    NSString* GetJump2MotionName();
    NSString* GetFallMotionName();
    NSString* GetDyingMotionName();
    NSString* GetAttackMotionName();
    
    void SetCanDeath(const bool bDeath);
    const bool GetCanDeath();
    
    void SetCulling(const int nCulling);
    const int GetCulling();
    
    void SetDamageSensor(const bool bDamageSensor) {m_bDamageSensor = bDamageSensor;}
    const bool GetDamageSensor() {return m_bDamageSensor;}

    void AddStateData(NSString* pID,const int nCategory,NSString *pValue);
    NSString* GetStateData(NSString* pID,const int nCategory);
    
    void SetScore(const int nScore) {m_nScore = nScore;}
    const int GetScore() {return m_nScore;}

private:
    NSString* m_strName;
    NSString* m_strAIName;
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
    float m_fBounceSpeed;
    float m_fDamageBounceSpeed;

    int m_nHP;    
    int m_nCulling;    
    int m_nScore;

    bool m_bCanDeath;
    bool m_bDamageSensor;

    FCStateDataManager m_StateDataManager;
};

#endif
