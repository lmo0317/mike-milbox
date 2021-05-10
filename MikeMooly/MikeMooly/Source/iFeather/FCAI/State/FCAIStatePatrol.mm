#import "FCAIStatePatrol.h"
#import "FCAIData.h"
#import "FCEnemy.h"
#import "FCAIStateData.h"
//#import "FCUtil.h"
FCAIStatePatrol::FCAIStatePatrol():
m_nDirection(PATROL_DIRECTION_LEFT)
{
    m_strName = @"PATROL";
}

FCAIStatePatrol::~FCAIStatePatrol()
{
    
}

const float FCAIStatePatrol::GetUtility(ccTime dt)
{
    if(m_pParent)
    {
        FCAIData* pAIData = m_pParent->GetAIData();
        FCAIStateData* pStateData = pAIData->GetStateData(m_strName);
        
        if(pStateData == NULL)
            return 0.f;
        
        float fTime = pStateData->fTime;
        float fProbability = pStateData->fProbability;
        
        m_dCurTime += dt;
        if(m_dCurTime > fTime)
        {
            m_dCurTime = 0;
            float fRand = drand(0,1);
            if(fProbability > fRand)
            {
                return 2.f;
            }
        }
    }
    return 0.f;
}

void FCAIStatePatrol::Process(ccTime dt)
{
    if(m_pParent)
    {
        FCAIData* pAIData = m_pParent->GetAIData();
        
        if(m_pParent->GetContactLeftFixtureToAICount())
        {
            m_nDirection = PATROL_DIRECTION_RIGHT;
        }
        else if(m_pParent->GetContactRightFixtureToAICount())
        {
            m_nDirection = PATROL_DIRECTION_LEFT;
        }
        
        if(pAIData->GetBanister())
        {
            const int nContactLeftBanisterFixture = m_pParent->GetConatactLeftBanisterFixture();
            const int nContactRightBanisterFixture = m_pParent->GetContactRightBanisterFixture();
            //CCLOG(@"LEFT BANISTER = [%d]",nContactLeftBanisterFixture);
            
            if(nContactLeftBanisterFixture == 0)
            {
                m_nDirection = PATROL_DIRECTION_RIGHT;            
            }
            else if(nContactRightBanisterFixture == 0)
            {
                m_nDirection = PATROL_DIRECTION_LEFT;
            }
        }
        
        if(m_nDirection == PATROL_DIRECTION_LEFT)
        {
            m_pParent->MoveLeft();
        }
        else if(m_nDirection == PATROL_DIRECTION_RIGHT)
        {
            m_pParent->MoveRight();
        }
        m_pParent->SetState(STATE_WALK);
    }
    
    FCAIState::Process(dt);
}

void FCAIStatePatrol::SetState()
{
    
}