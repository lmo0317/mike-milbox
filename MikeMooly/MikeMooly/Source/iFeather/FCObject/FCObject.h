#ifndef FCOBJECT_H
#define FCOBJECT_H

#import "FCObject_Struct.h"
#import "Box2D.h"
#import "MyLevelHelperLoader.h"
#import "FCMotionData.h"

#include <algorithm>
#include <vector>
#include <map>

class FCObject
{
public:
    
    FCObject();
    ~FCObject();
    
    virtual void Process(ccTime dt);
    virtual void Init();
    virtual void BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB);
    virtual void FirstEvent();

    void Delete();
    void AnimationProcess(ccTime dt);
    void AnimationProcessSound(ccTime dt);
    void AnimationProcessEffect(ccTime dt);
    void AnimationProcessShoot(ccTime dt);
    void AnimationProcessHit(ccTime dt);
    
    void Create(NSString* NAME);
    void Create(LHSprite* pSprite);
    void Create();
    void CreateSensor();
    
    void PlayEffectSound(NSString* strSoundName);
    void PlayEffectParticle(NSString* strParticleName);
    void AddShoot(NSString* pModelName);
    void AddHitData(NSString* pName);
    
    void ResetCurAnimationEventInfo();
    
    void SetName(NSString * strName);
    void SetLevelHelper(MyLevelHelperLoader * pLevelHelper);
    void SetAllFixtureSensor(const bool bSet);
    void SetDirection(CGPoint vecDirection);
    void SetContactTopFixture(const int nContact);
    void SetContactLeftFixture(const int nContact);
    void SetContactRightFixture(const int nContact);
    void SetContactBottomFixture(const int nContact);
    void SetCurMotion(NSString* strMotionName);

    LHSprite* GetSprite();
    b2Body* GetBody();
    NSString* GetName();
    const int GetContactTopFixture();
    const int GetContactLeftFixture();
    const int GetContactRightFixture();
    const int GetContactBottomFixture();
    void GetSensorTouch(int &nLeftSensor,int &nTopSensor,int &nRightSensor,int &nBottomSensor);
    b2Fixture *GetMainFixture();
    NSString * GetCurMotionName();
    b2Fixture* GetBottomFixture();
    b2Fixture* GetTopFixture();
    b2Fixture* GetLeftFixture();
    b2Fixture* GetRightFixture();
    CGPoint GetDirection();
    CGPoint GetPos();
    
    const bool IsMyFixture(b2Fixture* pFixture);
    const bool IsMyTopFixture(b2Fixture *pFixture);
    const bool IsMyBottomFixture(b2Fixture *pFixture);
    const bool IsMyLeftFixture(b2Fixture *pFixture);
    const bool IsMyRightFixture(b2Fixture *pFixture);
    const bool IsMyRightBanisterFixture(b2Fixture *pFixture);
    const bool IsMyLeftBanisterFixture(b2Fixture *pFixture);
    
    const bool IsMyMainFixture(b2Fixture* pFixtrue);
    
    void SetDelete(const bool bDelete) {m_bDelete = bDelete;}
    const bool IsDelete() {return m_bDelete;}
    
    void SetCreateSensor(const bool bCreate) {m_bCreateSensor = bCreate;}
    bool IsCreateSensor() {return m_bCreateSensor;}
    
    const bool IsEndFrame();
    const int GetFrame();
    
    const int GetContactTopFixtureCount() {return m_nContactTopFixture;}
    const int GetContactLeftFixtureCount() {return m_nContactLeftFixture;}
    const int GetContactRightFixtureCount() {return m_nContactRightFixture;}
    const int GetContactBottomFixtureCount() {return m_nContactBottomFixture;}
    
    const int GetContactTopFixtureToAICount() {return m_nContactTopFixtureToAI;}
    const int GetContactLeftFixtureToAICount() {return m_nContactLeftFixtureToAI;}
    const int GetContactRightFixtureToAICount() {return m_nContactRightFixtureToAI;}
    const int GetContactBottomFixtureToAICount() {return m_nContactBottomFixtureToAI;}
    
    const int GetConatactLeftBanisterFixture() {return m_nContactLeftBanisterFixture;}
    const int GetContactRightBanisterFixture() {return m_nContactRightBanisterFixture;}
    
    void SetTarget(NSString* strTarget) {m_strTarget = strTarget;}
    NSString* GetTarget() {return m_strTarget;}
    
    void SetOneShot(const bool bOneShot) {m_bOneShot = bOneShot;}
    const bool GetOneShot() {return m_bOneShot;}
    
    const bool IsMyChildSpriteFixture(b2Fixture *pFixture);

protected:
    
    MyLevelHelperLoader * m_pLevelHelper;
    LHSprite * m_pSprite;
    b2Body * m_pBody;
    
    b2Fixture *m_pMainFixture;
    b2Fixture *m_pBottomFixture;
    b2Fixture *m_pTopFixture;
    b2Fixture *m_pRightFixture;
    b2Fixture *m_pLeftFixture;
    
    b2Fixture *m_pLeftBanisterFixture;
    b2Fixture *m_pRightBanisterFixture;
    
    CGPoint m_vecDirection;
    ccTime m_dCurTime;
    ccTime m_dCurAnimationTime;

    int m_nContactTopFixture;
    int m_nContactLeftFixture;
    int m_nContactRightFixture;
    int m_nContactBottomFixture;

    int m_nContactTopFixtureToPlayer;
    int m_nContactLeftFixtureToPlayer;
    int m_nContactRightFixtureToPlayer;
    int m_nContactBottomFixtureToPlayer;
    
    int m_nContactTopFixtureToAI;
    int m_nContactLeftFixtureToAI;
    int m_nContactRightFixtureToAI;
    int m_nContactBottomFixtureToAI;
    
    int m_nContactLeftBanisterFixture;
    int m_nContactRightBanisterFixture;
    
    NSString* m_strCurMotionName;
    NSString* m_strPreveMotionName;
    NSString* m_strPreveSoundName;
    NSString* m_strCurSoundName;
    NSString* m_strTarget;
    
    bool m_bOneShot;
    AnimationInfo m_sCurAnimationInfo;
    FCMotionData m_pMotionData;

    bool m_bDelete;
    bool m_bCreateSensor;
    
    NSString* m_strName;
    LHSprite* m_pChildSprite;
};
#endif