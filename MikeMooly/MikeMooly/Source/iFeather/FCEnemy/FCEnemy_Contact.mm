#import "FCEnemy.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCEnemy::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{ 
    FCCharacter::BeginContact(fixtureA,fixtureB);
    
    if(GetState() == STATE_DEATH)
        return;
    
    b2Fixture* pMyFixture = NULL;
    b2Fixture* pOtherFixture = NULL;
    
    if(IsMyFixture(fixtureA))
    {
        pMyFixture = fixtureA;
        pOtherFixture = fixtureB;
    }
    else if(IsMyFixture(fixtureB))
    {
        pMyFixture = fixtureB;
        pOtherFixture = fixtureA;
    }
    else
    {
        assert(1);
        CCLOG(@"FCENEMY FIXTURE ERROR");
    }
    
    //ai 무시 해야되는 fixture 인지 검사한다
    if(IsAIFixture(pOtherFixture))
    {
        if(pMyFixture == m_pBottomFixture)
        {
            m_nContactBottomFixtureToAI += 1;
        }
        else if(pMyFixture == m_pTopFixture)
        {
            m_nContactTopFixtureToAI += 1;
        }
        else if(pMyFixture == m_pLeftFixture)
        {
            m_nContactLeftFixtureToAI += 1;
        }
        else if(pMyFixture == m_pRightFixture)
        {
            m_nContactRightFixtureToAI += 1;
        }
    }

    if(IsContactCheckFixture(pMyFixture) == false)
        return;

    PlayerCheck(pOtherFixture);
    GimmickCheck(pOtherFixture);
    HitDataCheck(pOtherFixture);
}

void FCEnemy::HitDataCheck(b2Fixture* pFixture)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain *pGameMain = [pActionLayer GetGameMain];
    
    bool bHitDataFixture = pGameMain->IsHitDataFixture(pFixture);
    if(bHitDataFixture)
    {
        SetState(STATE_DAMAGE);
        return;
    }
}

void FCEnemy::GimmickCheck(b2Fixture* pFixture)
{
    //paleyr와 충돌 체크
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain *pGameMain = [pActionLayer GetGameMain];

    //CCLOG(@"CATEGORY = [%d]",pGameMain->GetFixtureTag(pFixture));
    bool bIsGimmickFixture = pGameMain->IsGimmickFixture(pFixture);
    if(bIsGimmickFixture)
    {
        FCGimmick* pGimmick = (FCGimmick*)pGameMain->GetObjectFromFixture(pFixture);
        
        if([pGimmick->GetTarget() isEqualToString:@"PLAYER"])
        {
            
        }
        else if([pGimmick->GetTarget() isEqualToString:@"ENEMY"])
        {
            if(pGimmick->GetOneShot()) {
                SetState(STATE_DEATH);
            }
            else  {
                SetState(STATE_DAMAGE);
            }
        }
        else if([pGimmick->GetTarget() isEqualToString:@"ALL"])
        {
            if(pGimmick->GetOneShot()) {
                SetState(STATE_DEATH);
            }
            else {
                SetState(STATE_DAMAGE);
            }
        }
    }
}

void FCEnemy::PlayerCheck(b2Fixture* pFixture)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain *pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    bool bPlayerFixture = pGameMain->IsPlayerFixture(pFixture);
    if(bPlayerFixture == false)
        return;
    
    //banister sensor 일경우 무시
    if(pPlayer->IsMyLeftBanisterFixture(pFixture) || pPlayer->IsMyRightBanisterFixture(pFixture))
        return;
    
    if(pPlayer->GetState() != STATE_DEATH)
    {
        b2Fixture* pEnemyTopFixture = GetTopFixture();
        if(pEnemyTopFixture)
        {
            b2Vec2 vecPlayerBodyPos = pPlayer->GetBody()->GetPosition();
            b2Vec2 vecEnemyTopFixturePos = pEnemyTopFixture->GetAABB(0).GetCenter();
            
            if(vecPlayerBodyPos.y >= vecEnemyTopFixturePos.y)
            {
                if(m_bCanDeath)
                {
                    //몬스터를 밟아 없앨경우
                    pPlayer->SetState(STATE_BOUNCE);
                    SetState(STATE_DAMAGE);
                    
                    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
                    FCGameMain* pGameMain = [pActionLayer GetGameMain];
                    
                    const int nScore = m_pEnemyData->GetScore();
                    pGameMain->AddScore(nScore);
                    //CCLOG(@"SCORE = [%d]",nScore);
                    return;
                }
            }
        }
        
        if(pFixture->IsSensor())
            return;
        
        if(m_bOneShot)
        {
            pPlayer->SetState(STATE_DEATH); 
        }
        else
        {
            pPlayer->SetState(STATE_DAMAGE);                
        }
    }
}

void FCEnemy::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{
    FCCharacter::EndContact(fixtureA,fixtureB);
    
    b2Fixture* pMyFixture = NULL;
    b2Fixture* pOtherFixture = NULL;
    
    if(IsMyFixture(fixtureA))
    {
        pMyFixture = fixtureA;
        pOtherFixture = fixtureB;
    }
    else if(IsMyFixture(fixtureB))
    {
        pMyFixture = fixtureB;
        pOtherFixture = fixtureA;
    }
    else
    {
        assert(1);
        CCLOG(@"FCENEMY FIXTURE ERROR");
    }
    
    //플레이어 fixture가 아닐경우
    if(IsAIFixture(pOtherFixture))
    {
        if(pMyFixture == m_pBottomFixture)
        {
            m_nContactBottomFixtureToAI -= 1;
        }
        else if(pMyFixture == m_pTopFixture)
        {
            m_nContactTopFixtureToAI -= 1;
        }
        else if(pMyFixture == m_pLeftFixture)
        {
            m_nContactLeftFixtureToAI -= 1;
        }
        else if(pMyFixture == m_pRightFixture)
        {
            m_nContactRightFixtureToAI -= 1;
        }
    }
}

const bool FCEnemy::IsAIFixture(b2Fixture* pFixture)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();

    if(pPlayer->IsMyFixture(pFixture))
        return false;
    
    if(pGameMain->IsFieldItemFixture(pFixture))
        return false;
    
    if(pGameMain->IsHitDataFixture(pFixture))
        return false;
    
    if(pGameMain->IsGimmickFixture(pFixture))
        return false;
    
    return true;
}

const bool FCEnemy::IsContactCheckFixture(b2Fixture* pFixture)
{
    if(m_pBottomFixture == pFixture)
    {
        return false;
    }
    
    if(m_pTopFixture == pFixture)
    {
        return false;
    }
    
    if(m_pRightFixture == pFixture)
    {
        return false;
    }
    
    if(m_pLeftFixture == pFixture)
    {
        return false;
    }
    
    if(m_pLeftBanisterFixture == pFixture)
    {
        return false;
    }
    
    if(m_pRightBanisterFixture == pFixture)
    {
        return false;
    }
    
    return true;
}