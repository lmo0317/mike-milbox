
#ifndef MikeMooly_FCGameMain_h
#define MikeMooly_FCGameMain_h

#import "FCPlayer.h"
#import "FCBlock.h"
#import "FCEnemy.h"
#import "FCPlatForm.h"
#import "FCFieldItem.h"
#import "FCShoot.h"
#import "FCHitBox.h"
#import "FCDataManager.h"
#import "FCEventBoxPortal.h"
#import "FCEventBoxStageClear.h"
#import "FCEventBoxCheckPoint.h"
#import "FCEventBoxPosition.h"
#import "FCWorldData.h"
#import "FCGimmick.h"
#import "FCBackGround.h"
#import "FCUIWindowManager.h"
#import "StageSelectLayer.h"

class FCGameMain
{
public:
    FCGameMain();
    ~FCGameMain();
    
    void Init(NSString* strWorldName,HUDLayer* pHudLayer);
    void Clear();
    void beginContact(b2Contact *contact); 
    void endContact(b2Contact* contact);
    
    void ObjectClear();
    void ObjectProcess(ccTime dt);
    void InitGameMainData();
    
    void Process(ccTime dt);
    void ObjectInit();
    
    void ccTouchesBegan(NSSet * touches,UIEvent * event);
    void ccTouchesMoved(NSSet * touches,UIEvent * event);
    void ccTouchesEnded(NSSet *touches,UIEvent * event);
    
    void CreateLocalPlayerName(NSString* Name);
    void CreateLocalPlayerSprite(LHSprite* pSprite);
    void CreateBlockName(NSString* Name);
    void CreateBlockSprite(LHSprite* pSprite);
    void CreateEnemyName(NSString* Name);
    void CreateEnemySprite(LHSprite* pSprite);
    void CreatePlatFormName(NSString* Name);
    void CreatePlatFormSprite(LHSprite* pSprite);
    void CreateFieldItemName(NSString* Name);
    void CreateFieldItemSprite(LHSprite* pSprite);
    void CreateShootName(NSString* Name);
    void CreateShootSprite(LHSprite* pSprite);
    void CreateHitDataName(NSString* Name);
    void CreateHitDataSprite(LHSprite* pSprite);
    void CreateGimmickName(NSString* Name);
    void CreateGimmickSprite(LHSprite* pSprite);
    
    void CreateBackGroundName(NSString* Name);
    void CreateBackGroundSprite(LHSprite* pSprite);
    
    void CreateEventBoxPortalName(NSString* Name);
    void CreateEventBoxPortalSprite(LHSprite* pSprite);
    void CreateEventBoxStageClearName(NSString* Name);
    void CreateEventBoxStageClearSprite(LHSprite* pSprite);
    void CreateEventBoxCheckPointName(NSString* Name);
    void CreateEventBoxCheckPointSprite(LHSprite* pSprite);
    void CreateEventBoxPositionName(NSString* Name);
    void CreateEventBoxPositionSprite(LHSprite* pSprite);    
    void CreateSpriteInLevel();
    void CreateObject(const int nTag,NSString* key);
    void CreateSprite(LHSprite* pSprite);
    void CreateSpriteReserve(LHSprite* pSprite);
    void MoveToEventBoxPosition(NSString* strEventBoxPosition);
    
    bool IsPlayerFixture(b2Fixture* pFixture);
    bool IsPlayerMainFixture(b2Fixture* pFixture);
    bool IsPlayerTopFixture(b2Fixture* pFixture);
    bool IsPlayerBottomFixture(b2Fixture* pFixture);
    bool IsPlayerLeftFixture(b2Fixture* pFixture);
    bool IsPlayerRightFixture(b2Fixture* pFixture);

    bool IsEnemyFixture(b2Fixture* pFixture);
    bool IsBlockFixture(b2Fixture* pFixture);
    bool IsPlatFormFixture(b2Fixture* pFixture);
    bool IsFieldItemFixture(b2Fixture* pFixture);
    bool IsShootFixture(b2Fixture* pFixture);
    bool IsHitDataFixture(b2Fixture* pFixture);
    bool IsGimmickFixture(b2Fixture* pFixture);
    bool IsBackGroundFixture(b2Fixture* pFixture);
    bool IsEventBoxPortalFixture(b2Fixture* pFixture);
    bool IsEventBoxPositionFixture(b2Fixture* pFixture);
    bool IsEventBoxStageClearFixture(b2Fixture* pFixture);
    bool IsEventBoxCheckPointFixture(b2Fixture* pFixture);
    
    bool IsPlayer(int nIndex);
    bool IsEnemy(int nIndex);
    bool IsBlock(int nIndex);
    bool IsPlatForm(int nIndex);
    bool IsFieldItem(int nIndex);
    bool IsHitData(int nIndex);
    bool IsGimmick(int nIndex);
    bool IsBackGround(int nIndex);
    bool IsShoot(int nIndex);
    bool IsEventBoxPortal(int nIndex);
    bool IsEventBoxPosition(int nIndex);
    bool IsEventBoxStageClear(int nIndex);
    bool IsEventBoxCheckPoint(int nIndex);
    
    void InputJump();
    void InputStick(CGPoint velocity);    
    void FirstEvent();    
    void SetLevelHelperLoader(MyLevelHelperLoader* pLevelHelper) {_lhelper = pLevelHelper;}    
    void InitWorldData();
    void InitWorldData(FCWorldData* pWorldData);
    void SetScore(const int nScore);
    void AddScore(const int nScore);
    void AddScoreMainWindow(const int nScore);
    void setupAudio();
    void ReserveProcess(ccTime dt);        
    void GameEnd();
    void GameStart();
    void TimeCountCheck();
    void SetCoin(const int nCoin);
    void AddCoin(const int nCoin);
    void SetStageClear(const bool bStageClear) {m_bStageClear = bStageClear;}
    void StageClearProcess(ccTime dt);
    
    const int GetScore() {return m_nScore;}
    const int GetCoin() {return m_nCoin;}
    const int GetFixtureTag(b2Fixture* pFixtrue);
    const bool GetGameEnd() {return m_bGameEnd;}    
    const bool GetStageClear() {return m_bStageClear;}

    FCPlayer* GetLocalPlayer() {return m_pLocalPlayer;}
    FCWorldData* GetWorldData() {return m_pWorldData;}
    FCUIWindowManager* GetWindowManager() {return m_pWindowManager;}    
    FCEventBoxCheckPoint* GetCheckPoint();
    FCEventBoxPosition*   GetEventBoxPosition(NSString* strEventBoxPosition);

    ccTime GetCurTime() {return m_dCurTime;}
    FCObject* GetObjectFromFixture(b2Fixture* pFixture);
    const int GetContinueCount() {return m_nContinueCount;}
    void SetContinueCount(const int nContinueCount);
    void AddContinueCount(const int nContinueCount);
    int GetStageCoin() {return m_nStageCoin;}
    int GetStageDamage() {return m_nStageDamage;}
    void AddStageDamage(const int nStageDamage);
    void PlayCoinLifeUpSound();
    void PlayPortalSound();
    void PlayClearTimeSound();
    void SetCurTime(ccTime dTime);
    void SetStageCoin(int nStageCoin) {m_nStageCoin = nStageCoin;}
    void SetStageDamage(int nStageDamage) {m_nStageDamage = nStageDamage;}
    
    void SetMissionItem(int nIndex,bool bSet);
    const bool GetMissionItem(int nIndex) {return m_bMissionItem[nIndex];}
    
private:
    
    bool m_bGameEnd;
    bool m_bStageClear;
    int m_nScore;
    int m_nCurrentScore;
    int m_nCoin;
    int m_nContinueCount;
    int m_nStageCoin;
    bool m_bMissionItem[3];
    int m_nStageDamage;    
    int m_nClearTime;
    ccTime m_dCurTime;
    ccTime m_dRemainTime;
    NSString* m_strWorldName;

    HUDLayer            *m_pHudLayer;
    FCPlayer            *m_pLocalPlayer;        
    FCWorldData         *m_pWorldData;
    MyLevelHelperLoader *_lhelper;
    FCUIWindowManager   *m_pWindowManager;
    std::vector<LHSprite*> m_vecCreateSpriteReserve;
    std::vector<FCObject*> m_vecObject;
};

#endif
