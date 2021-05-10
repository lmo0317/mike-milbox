#ifndef FCPLAYER_H
#define FCPLAYER_H

#import "FCCharacter.h"
#import "FCPlayerData.h"

class FCPlayer : public FCCharacter
{
public:
    
    FCPlayer();
    ~FCPlayer();
    virtual void Process(ccTime dt);
    virtual void Init(MyLevelHelperLoader * pLevelHelper);
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void StateDeathProcess(ccTime dt);
    
    void InputJump();
    void InputStick(CGPoint velocity);
    
    virtual void SetStateDeath();
    virtual void SetStateDamage();
    virtual void Create(NSString* Name);
    virtual void Create(LHSprite* pSprite);
    virtual void Create();
    
    void InitPlayerData(FCPlayerData* pPlayerData);
    
    void SetDeathTime(const float fDeathTime) {m_fDeathTime = fDeathTime;}
    const float GetDeathTime() {return m_fDeathTime;}
    
    void InitData();
    void SetHP(const int nHP);
    
    void SetLife(const int nLife);
    void AddLife(const int nLife);
    const int GetLife() {return m_nLife;}
    
    void InitCheckPoint();
    void GimmickCheck(b2Fixture* pFixture);
    
private:
    
    void MoveProcess(ccTime dt);
    void MoveProcessStop(ccTime dt);
    FCPlayerData* m_pPlayerData;
    
    float m_fDeathTime;
    int m_nLife;
};

#endif