#ifndef FCENEMY
#define FCENEMY

#import "FCEnemyData.h"
#import "FCAIData.h"
#import "FCCharacter.h"
#import "FCAIState.h"

class FCEnemy : public FCCharacter
{
public:
    
    FCEnemy();
    ~FCEnemy();
    
    virtual void Process(ccTime dt);
    virtual void Init(MyLevelHelperLoader * pLevelHelper);
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void SetStateDeath();
    
    virtual void StateDeathProcess(ccTime dt);
    void SetTag();

    virtual void Create(NSString* Name);
    virtual void Create(LHSprite* pSprite);
    virtual void Create();
    
    void AIProcess(ccTime dt);
    void CreateAIState();
    const bool IsAIFixture(b2Fixture* pFixture);
    const bool IsContactCheckFixture(b2Fixture* pFixture);

    
    void InitEnemyData();
    void InitEnemyData(FCEnemyData* pEnemyData);
    
    void InitAIData();
    void InitAIData(FCAIData* pAIData);    
    void SetCanDeath(const bool bDeath);
    const bool GetCanDeath();
    
    void SetCulling(const int nCulling);
    const int GetCulling();
    
    void SetDamageSensor(const bool bDamageSensor) {m_bDamageSensor = bDamageSensor;}
    const bool GetDamageSensor() {return m_bDamageSensor;}

    FCAIData* GetAIData();
    
    void PlayerCheck(b2Fixture* pFixture);
    void EnemyCheck(b2Fixture* pFixture);
    void GimmickCheck(b2Fixture* pFixture);
    
    void HitDataCheck(b2Fixture* pFixture);

private:
    
    bool m_bCanDeath;
    bool m_bOneShot;
    int  m_nCulling;
    bool m_bAI;
    bool m_bDamageSensor;
    
    FCAIState* m_pAIState[AI_STATE_MAX];
    FCAIState* m_pBestState;
    
    FCEnemyData* m_pEnemyData;
    FCAIData* m_pAIData;
};



#endif
