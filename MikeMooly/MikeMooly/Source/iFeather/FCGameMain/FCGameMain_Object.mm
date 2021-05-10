#import "FCGameMain.h"
//오브젝트 체크

bool FCGameMain::IsPlayer(int nIndex)
{
    if(nIndex == PLAYER)
        return true;
    
    return false;
}

bool FCGameMain::IsEnemy(int nIndex)
{
    switch(nIndex)
    {
        case ENEMY01:
        case ENEMY02:
        case ENEMY03:
        case ENEMY04:
        case ENEMY05:
        case ENEMY06:
        case ENEMY07:
        case ENEMY08:
        case ENEMY09:
        case ENEMY10:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsBlock(int nIndex)
{
    switch(nIndex)
    {
        case BLOCK01:
        case BLOCK02:
        case BLOCK03:
        case BLOCK04:
        case BLOCK05:
        case BLOCK06:
        case BLOCK07:
        case BLOCK08:
        case BLOCK09:
        case BLOCK10:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsPlatForm(int nIndex)
{
    switch(nIndex)
    {
        case PLATFORM01:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsFieldItem(int nIndex)
{
    switch(nIndex)
    {
        case FIELDITEM01:
        case FIELDITEM02:
        case FIELDITEM03:
        case FIELDITEM04:
        case FIELDITEM05:
        case FIELDITEM06:
        case FIELDITEM07:
        case FIELDITEM08:
        case FIELDITEM09:
        case FIELDITEM10:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsShoot(int nIndex)
{
    switch(nIndex)
    {
        case SHOOT01:
            return true;
    }
    return false;
}

bool FCGameMain::IsHitData(int nIndex)
{
    switch(nIndex)
    {
        case HITDATA01:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsEventBoxPortal(int nIndex)
{
    switch(nIndex)
    {
        case EVENT_BOX_PORTAL01:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsEventBoxPosition(int nIndex)
{
    switch(nIndex)
    {
        case EVENT_BOX_POSITION01:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsEventBoxStageClear(int nIndex)
{
    switch(nIndex)
    {
        case EVENT_BOX_STAGE_CLEAR01:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsEventBoxCheckPoint(int nIndex)
{
    switch(nIndex)
    {
        case EVENT_BOX_CHECK_POINT01:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsGimmick(int nIndex)
{
    switch(nIndex)
    {
        case GIMMICK01:
            return true;
    }
    
    return false;
}

bool FCGameMain::IsBackGround(int nIndex)
{
    switch(nIndex)
    {
        case BACK_GROUND01:
            return true;
    }
    
    return false;
}

//오브젝트 행동
//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

void FCGameMain::ObjectInit()
{
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();++it)
    {
        FCObject* pObject = *it;
        pObject->ResetCurAnimationEventInfo();
    }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

void FCGameMain::ObjectClear()
{
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();++it)
    {
        FCObject* pObject = *it;
        delete pObject;
    }
    
    delete m_pLocalPlayer;
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

void FCGameMain::ObjectProcess(ccTime dt)
{
    if(m_pLocalPlayer)
    {
        m_pLocalPlayer->Process(dt);
    }
    
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();)
    {
        FCObject* pObject = *it;
        if(pObject)
        {
            pObject->Process(dt);
            if(pObject->IsDelete())
            {
                pObject->Delete();
                delete pObject;
                it = m_vecObject.erase(it);
                continue;
            }
        }
        
        ++it;
    }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

void FCGameMain::beginContact(b2Contact* contact)
{
    if(m_bGameEnd)
        return;
    
    if(m_bStageClear)
        return;
    
    b2Fixture *fixtureA = contact->GetFixtureA();
    b2Fixture *fixtureB = contact->GetFixtureB();
    
    if(m_pLocalPlayer)
    {
        if(m_pLocalPlayer->IsMyFixture(fixtureA) || m_pLocalPlayer->IsMyFixture(fixtureB))
        {
            m_pLocalPlayer->BeginContact(fixtureA,fixtureB);
        }
    }
    
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();++it)
    {
        FCObject* pObject = *it;
        if(pObject)
        {
            if(pObject->IsMyFixture(fixtureA) || pObject->IsMyFixture(fixtureB))
            {
                pObject->BeginContact(fixtureA,fixtureB);
            }
        }
    }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

void FCGameMain::endContact(b2Contact* contact)
{
    if(m_bGameEnd)
        return;
    
    if(m_bStageClear)
        return;
    
    b2Fixture *fixtureA = contact->GetFixtureA();
    b2Fixture *fixtureB = contact->GetFixtureB();
    
    if(m_pLocalPlayer)
    {
        if(m_pLocalPlayer->IsMyFixture(fixtureA) || m_pLocalPlayer->IsMyFixture(fixtureB))
        {
            m_pLocalPlayer->EndContact(fixtureA,fixtureB);
        }
    }
    
    std::vector<FCObject*>::iterator it = m_vecObject.begin();
    for(;it != m_vecObject.end();++it)
    {
        FCObject* pObject = *it;
        if(pObject)
        {
            if(pObject->IsMyFixture(fixtureA) || pObject->IsMyFixture(fixtureB))
            {
                pObject->EndContact(fixtureA,fixtureB);
            }
        }
    }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

void FCGameMain::CreateLocalPlayerName(NSString* Name)
{
    m_pLocalPlayer = new FCPlayer;
    m_pLocalPlayer->SetName(Name);
    m_pLocalPlayer->Init(_lhelper);
    m_pLocalPlayer->Create(Name);
}

void FCGameMain::CreateLocalPlayerSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    m_pLocalPlayer = new FCPlayer;
    m_pLocalPlayer->SetName(uniqueName);
    m_pLocalPlayer->Init(_lhelper);
    m_pLocalPlayer->Create(pSprite);
}

void FCGameMain::CreateBlockName(NSString* Name)
{
    FCBlock * pBlock = new FCBlock;
    pBlock->SetName(Name);
    pBlock->Init(_lhelper);
    pBlock->Create(Name);
    
    m_vecObject.push_back(pBlock);
}

void FCGameMain::CreateBlockSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCBlock * pBlock = new FCBlock;
    pBlock->SetName(uniqueName);
    pBlock->Init(_lhelper);
    pBlock->Create(pSprite);
    
    m_vecObject.push_back(pBlock);
}

void FCGameMain::CreatePlatFormName(NSString* Name)
{
    FCPlatForm* pPlatForm = new FCPlatForm;
    pPlatForm->SetName(Name);
    pPlatForm->Init(_lhelper);
    pPlatForm->Create(Name);
    
    m_vecObject.push_back(pPlatForm);
}

void FCGameMain::CreatePlatFormSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCPlatForm* pPlatForm = new FCPlatForm;
    pPlatForm->SetName(uniqueName);
    pPlatForm->Init(_lhelper);
    pPlatForm->Create(pSprite);
    
    m_vecObject.push_back(pPlatForm);
}

void FCGameMain::CreateFieldItemName(NSString* Name)
{
    FCFieldItem* pFieldItem = new FCFieldItem;
    pFieldItem->SetName(Name);
    pFieldItem->Init(_lhelper);
    pFieldItem->Create(Name);
    
    m_vecObject.push_back(pFieldItem);
}

void FCGameMain::CreateFieldItemSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCFieldItem* pFieldItem = new FCFieldItem;
    pFieldItem->SetName(uniqueName);
    pFieldItem->Init(_lhelper);
    pFieldItem->Create(pSprite);
    
    m_vecObject.push_back(pFieldItem);
}

void FCGameMain::CreateShootName(NSString* Name)
{
    FCShoot* pShoot = new FCShoot;
    pShoot->SetName(Name);
    pShoot->Init(_lhelper);
    pShoot->Create(Name);
    
    m_vecObject.push_back(pShoot);
}

void FCGameMain::CreateShootSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCShoot* pShoot = new FCShoot;
    pShoot->SetName(uniqueName);
    pShoot->Init(_lhelper);
    pShoot->Create(pSprite);
    
    m_vecObject.push_back(pShoot);
}

void FCGameMain::CreateHitDataName(NSString* Name)
{
    FCHitBox* pHitBox = new FCHitBox;
    pHitBox->SetName(Name);
    pHitBox->Init(_lhelper);
    pHitBox->Create(Name);
    
   m_vecObject.push_back(pHitBox);    
}

void FCGameMain::CreateHitDataSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCHitBox* pHitBox = new FCHitBox;
    pHitBox->SetName(uniqueName);
    pHitBox->Init(_lhelper);
    pHitBox->Create(pSprite);
    
    m_vecObject.push_back(pHitBox);
}

void FCGameMain::CreateEnemyName(NSString* Name)
{
    FCEnemy * pEnemy = new FCEnemy;
    pEnemy->SetName(Name);
    pEnemy->Init(_lhelper);
    pEnemy->Create(Name);
    
    m_vecObject.push_back(pEnemy);
}

void FCGameMain::CreateEnemySprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCEnemy * pEnemy = new FCEnemy;
    pEnemy->SetName(uniqueName);
    pEnemy->Init(_lhelper);
    pEnemy->Create(pSprite);
    
    m_vecObject.push_back(pEnemy);
}

void FCGameMain::CreateEventBoxPortalName(NSString* Name)
{
    FCEventBoxPortal * pEventBoxPortal = new FCEventBoxPortal;
    pEventBoxPortal->SetName(Name);
    pEventBoxPortal->Init(_lhelper);
    pEventBoxPortal->Create(Name);
    
    m_vecObject.push_back(pEventBoxPortal);
}

void FCGameMain::CreateEventBoxPortalSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCEventBoxPortal * pEventBoxPortal = new FCEventBoxPortal;
    pEventBoxPortal->SetName(uniqueName);
    pEventBoxPortal->Init(_lhelper);
    pEventBoxPortal->Create(pSprite);
    
    m_vecObject.push_back(pEventBoxPortal);
}

void FCGameMain::CreateEventBoxPositionName(NSString* Name)
{
    FCEventBoxPosition * pEventBoxPosition = new FCEventBoxPosition;
    pEventBoxPosition->SetName(Name);
    pEventBoxPosition->Init(_lhelper);
    pEventBoxPosition->Create(Name);
    
    m_vecObject.push_back(pEventBoxPosition);
}

void FCGameMain::CreateEventBoxPositionSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCEventBoxPosition * pEventBoxPosition = new FCEventBoxPosition;
    pEventBoxPosition->SetName(uniqueName);
    pEventBoxPosition->Init(_lhelper);
    pEventBoxPosition->Create(pSprite);
    
    m_vecObject.push_back(pEventBoxPosition);
}

void FCGameMain::CreateEventBoxStageClearName(NSString* Name)
{
    FCEventBoxStageClear * pEventBoxStageClear = new FCEventBoxStageClear;
    pEventBoxStageClear->SetName(Name);
    pEventBoxStageClear->Init(_lhelper);
    pEventBoxStageClear->Create(Name);
    
    m_vecObject.push_back(pEventBoxStageClear);
}

void FCGameMain::CreateEventBoxStageClearSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCEventBoxStageClear * pEventBoxStageClear = new FCEventBoxStageClear;
    pEventBoxStageClear->SetName(uniqueName);
    pEventBoxStageClear->Init(_lhelper);
    pEventBoxStageClear->Create(pSprite);
    
    m_vecObject.push_back(pEventBoxStageClear);
}

void FCGameMain::CreateEventBoxCheckPointName(NSString* Name)
{
    FCEventBoxCheckPoint * pEventBoxCheckPoint = new FCEventBoxCheckPoint;
    pEventBoxCheckPoint->SetName(Name);
    pEventBoxCheckPoint->Init(_lhelper);
    pEventBoxCheckPoint->Create(Name);
    
    m_vecObject.push_back(pEventBoxCheckPoint);
}

void FCGameMain::CreateEventBoxCheckPointSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCEventBoxCheckPoint * pEventBoxCheckPoint = new FCEventBoxCheckPoint;
    pEventBoxCheckPoint->SetName(uniqueName);
    pEventBoxCheckPoint->Init(_lhelper);
    pEventBoxCheckPoint->Create(pSprite);
    
    m_vecObject.push_back(pEventBoxCheckPoint);
}

void FCGameMain::CreateGimmickName(NSString* Name)
{
    FCGimmick * pGimmick = new FCGimmick;
    pGimmick->SetName(Name);
    pGimmick->Init(_lhelper);
    pGimmick->Create(Name);
    
    m_vecObject.push_back(pGimmick);
}

void FCGameMain::CreateGimmickSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCGimmick * pGimmick = new FCGimmick;
    pGimmick->SetName(uniqueName);
    pGimmick->Init(_lhelper);
    pGimmick->Create(pSprite);
    
    m_vecObject.push_back(pGimmick);
}

void FCGameMain::CreateBackGroundName(NSString* Name)
{
    FCBackGround * pBackGround = new FCBackGround;
    pBackGround->SetName(Name);
    pBackGround->Init(_lhelper);
    pBackGround->Create(Name);
    
    m_vecObject.push_back(pBackGround);
}

void FCGameMain::CreateBackGroundSprite(LHSprite* pSprite)
{
    NSString *uniqueName = [pSprite uniqueName];
    
    FCBackGround * pBackGround = new FCBackGround;
    pBackGround->SetName(uniqueName);
    pBackGround->Init(_lhelper);
    pBackGround->Create(pSprite);
    
    m_vecObject.push_back(pBackGround);
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

bool FCGameMain::IsPlayerFixture(b2Fixture* pFixture)
{
    return m_pLocalPlayer->IsMyFixture(pFixture);
}

bool FCGameMain::IsPlayerMainFixture(b2Fixture* pFixture)
{
    return m_pLocalPlayer->IsMyMainFixture(pFixture);
}

bool FCGameMain::IsPlayerTopFixture(b2Fixture* pFixture)
{
    return m_pLocalPlayer->IsMyTopFixture(pFixture);
}

bool FCGameMain::IsPlayerBottomFixture(b2Fixture* pFixture)
{
    return m_pLocalPlayer->IsMyBottomFixture(pFixture);
}

bool FCGameMain::IsPlayerLeftFixture(b2Fixture* pFixture)
{
    return m_pLocalPlayer->IsMyLeftFixture(pFixture);
}

bool FCGameMain::IsPlayerRightFixture(b2Fixture* pFixture)
{
    return m_pLocalPlayer->IsMyRightFixture(pFixture);
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

bool FCGameMain::IsBlockFixture(b2Fixture* pFixture)
{
    return IsBlock(GetFixtureTag(pFixture));
}

bool FCGameMain::IsEnemyFixture(b2Fixture* pFixture)
{
    return IsEnemy(GetFixtureTag(pFixture));
}

bool FCGameMain::IsPlatFormFixture(b2Fixture* pFixture)
{
    return IsPlatForm(GetFixtureTag(pFixture));
}

bool FCGameMain::IsFieldItemFixture(b2Fixture* pFixture)
{
    return IsFieldItem(GetFixtureTag(pFixture));
}

bool FCGameMain::IsHitDataFixture(b2Fixture* pFixture)
{
    return IsHitData(GetFixtureTag(pFixture));
}

bool FCGameMain::IsShootFixture(b2Fixture* pFixture)
{
   return IsShoot(GetFixtureTag(pFixture));
}

bool FCGameMain::IsEventBoxPortalFixture(b2Fixture* pFixture)
{
    return IsEventBoxPortal(GetFixtureTag(pFixture));
}

bool FCGameMain::IsEventBoxPositionFixture(b2Fixture* pFixture)
{
    return IsEventBoxPosition(GetFixtureTag(pFixture));
}

bool FCGameMain::IsEventBoxStageClearFixture(b2Fixture* pFixture)
{
    return IsEventBoxStageClear(GetFixtureTag(pFixture));
}

bool FCGameMain::IsEventBoxCheckPointFixture(b2Fixture* pFixture)
{
    return IsEventBoxCheckPoint(GetFixtureTag(pFixture));
}

bool FCGameMain::IsGimmickFixture(b2Fixture* pFixture)
{
    return IsGimmick(GetFixtureTag(pFixture));
}

bool FCGameMain::IsBackGroundFixture(b2Fixture* pFixture)
{
    return IsBackGround(GetFixtureTag(pFixture));
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------

const int FCGameMain::GetFixtureTag(b2Fixture* pFixtrue)
{
    b2Body* pBody = pFixtrue->GetBody();
    LHSprite* pSprite = (LHSprite*)pBody->GetUserData();
    return [pSprite tag];
}

