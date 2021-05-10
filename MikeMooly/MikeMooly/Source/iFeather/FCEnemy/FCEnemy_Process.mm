#import "FCEnemy.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCEnemy::Process(ccTime dt)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    b2Vec2 vecPlayerPos;
    if(pPlayer)
    {
        vecPlayerPos = pPlayer->GetBody()->GetPosition();
    }
    
    const int nCulling = GetCulling();
    if(nCulling > 0)
    {
        if(GetBody())
        {
            b2Vec2 vecObjectPos = GetBody()->GetPosition();
            b2Vec2 vecLength = vecPlayerPos - vecObjectPos;
            float fLength = vecLength.Length();
            
            if(fLength > nCulling)
            {
                return;
            }
        }
    }
    
    switch(m_nState)
    {
        case STATE_DEATH:
            StateDeathProcess(dt);
            break;
    }
    
    if(m_nState != STATE_DEATH)
    {
        if(m_bAI)
        {
            AIProcess(dt);
        }
    }
    
    FCCharacter::Process(dt);
}

void FCEnemy::StateDeathProcess(ccTime dt)
{
    if(IsEndFrame())
    {
        m_bDelete = true;
    }
}

void FCEnemy::AIProcess(ccTime dt)
{
    float fBestValue = 0.f;
    
    for(int i = 0;i<AI_STATE_MAX;++i)
    {
        const float fValue = m_pAIState[i]->GetUtility(dt);
        //CCLOG(@"AI VALUE = [%f]",fValue);
        if(fBestValue < fValue)
        {
            fBestValue = fValue;
            m_pBestState = m_pAIState[i];
        }
    }
    
    //상태가 바뀔때 마다
    if(fBestValue)
    {
        m_pBestState->SetState();
    }
    
    //AI 선택 됨
    if(m_pBestState)
    {
        m_pBestState->Process(dt);
    }
}
