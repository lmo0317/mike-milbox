#import "FCPlayer.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "FCGameManager.h"
#import "ActionLayer.h"

void FCPlayer::Process(ccTime dt)
{
    MoveProcess(dt);
    
    switch(m_nState)
    {
        case STATE_DEATH:
            StateDeathProcess(dt);
            break;
    }
    
    //CCLOG(@"POS X = [%f] Y = [%f]",m_pBody->GetPosition().x,m_pBody->GetPosition().y);
    FCCharacter::Process(dt);
}

void FCPlayer::StateDeathProcess(ccTime dt)
{
    m_dDeathStartTime += dt;
    if(m_dDeathStartTime > m_fDeathTime)
    { 
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        FCGameManager* pGameManager = [appDelegate GetGameManager];
        
        if(pGameManager)
        {
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            FCDataManager* pDataManager = [appDelegate GetDataManager];
            FCDefaultDataManager* pDefaultDataManager = [pDataManager GetDefaultDataManager];
            FCDefaultData* pDefaultData = pDefaultDataManager->GetDefaultData(@"DEFAULT_DATA");
            
            SetHP(pDefaultData->GetHP());
            
            [pGameManager Death];
        }
        
        SetState(STATE_STAY);
    }
}

void FCPlayer::MoveProcessStop(ccTime dt)
{
    switch(m_nState)
    {
        case STATE_STAY:
            break;
        default:
            
            //방향 입력이 없을떄 멈춤
            if(m_vecDirection.x == 0)
            {
                b2Vec2 velocity = m_pBody->GetLinearVelocity();
                m_pBody->SetLinearVelocity(b2Vec2(0,velocity.y));
                return;
            }
            
            break;
    }
}

void FCPlayer::MoveProcess(ccTime dt)
{
    switch(GetState())
    {
        case STATE_DEATH:
        case STATE_DAMAGE:
            return;
            
    }
     
    MoveProcessStop(dt);
    if(m_nJumpCount)
    {
        //점프중
        if(m_vecDirection.x < 0)
        {
            //왼쪽
            JumpMoveLeft();
        }
        else if(m_vecDirection.x > 0)
        {
            //오른쪽
            JumpMoveRight();
        }
    }
    else
    {
        //땅에 있을떄
        if(m_vecDirection.x < 0)
        {
            //왼쪽
            MoveLeft();
            SetState(STATE_WALK);
        }
        else if(m_vecDirection.x > 0)
        {
            //오른쪽
            MoveRight();
            SetState(STATE_WALK);
        }
    }
}