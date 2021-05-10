#import "FCUIStageSelectWindow.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "FCGameManager.h"
#import "ActionLayer.h"

#ifdef LITE
    NSString* pMapName[STAGE_COUNT][MAP_COUNT] = {{@"farm_1",@"farm_2",@"farm_3",@"farm_4",@"farm_5",@"farm_6"}};
#else
    NSString* pMapName[STAGE_COUNT][MAP_COUNT] = {{@"farm_1",@"farm_2",@"farm_3",@"farm_4",@"farm_5",@"farm_6"},
        {@"jungle_1",@"jungle_2",@"jungle_3",@"jungle_4",@"jungle_5",@"jungle_6"},
        {@"warehouse_1",@"warehouse_2",@"warehouse_3",@"warehouse_4",@"warehouse_5",@"warehouse_6"},
        {@"cave_1",@"cave_2",@"cave_3",@"cave_4",@"cave_5",@"cave_6"}
    };
#endif

FCUIStageSelectWindow::FCUIStageSelectWindow()
{
    
}

FCUIStageSelectWindow::~FCUIStageSelectWindow()
{
    
}

void FCUIStageSelectWindow::Init(CCLayer* pParentLayer)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCUIWindowListDataManager* pUIWindowListDataManager = [pDataManager GetUIWindowListDataManager];
    m_pParser = pUIWindowListDataManager->GetUIWindowDataParser(@"StageSelectWindow");
    m_pWindowData = m_pParser->GetUIWindowDataManager()->GetUIWindowData(@"StageSelectWindow");
    FCUIWindow::Init(pParentLayer);
}

void FCUIStageSelectWindow::Create()
{
    FCUIWindow::Create();
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    if(strSaveSlot == NULL)
        return;
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    if(pSaveData == NULL)
        return;
    
    for(int i = 0;i<3;++i)
    {
        NSString* strLiteButton = [NSString stringWithFormat:@"lite_message%d",i];
        m_pLiteButton[i] = GetControl(strLiteButton);
    }

    
    for(int i=0;i<STAGE_COUNT;i++)
    {
        for(int j=0;j<MAP_COUNT;j++)
        {
            NSString* strButton  = [NSString stringWithFormat:@"menu_%02d_%02d",i,j];
            m_pButton[i][j] = GetControl(strButton);
            
            NSString* strNumber = [NSString stringWithFormat:@"number_%02d_%02d",i,j];
            m_pNumber[i][j] = GetControl(strNumber);
            
            for(int k = 0; k <3;++k)
            {
                NSString* strStar = [NSString stringWithFormat:@"star_%02d_%02d_%02d",i,j,k];
                m_pStar[i][j][k] = GetControl(strStar);
                m_pStar[i][j][k]->SetFirstTexture();
            }
            
            FCSaveWorldData* pSaveWorldData = pSaveData->GetSaveWorldData(pMapName[i][j]);
            if(pSaveWorldData == NULL)
            {
                m_pButton[i][j]->SetState(CONTROL_BUTTON_STATE_NONE);
                continue;
            }
            
            if(pSaveWorldData->GetOpen())
            {
                if(m_pNumber[i][j])
                {
                    m_pNumber[i][j]->SetShow(true);
                }
                m_pButton[i][j]->SetState(CONTROL_BUTTON_STATE_NONE);
            }
            else
            {
                if(m_pNumber[i][j])
                {
                    m_pNumber[i][j]->SetShow(false);
                }
                m_pButton[i][j]->SetState(CONTROL_BUTTON_STATE_DISABLE);
            }
        }
    }
    
    for(int i = 0;i<4;++i)
    {
        NSString* strName = [NSString stringWithFormat:@"title_%02d",i];
        m_pTitle[i] = GetControl(strName);
    }
    
    m_pMark = GetControl(@"mark");

    InitMark();
}

void FCUIStageSelectWindow::Process(ccTime dt)
{

    
    FCUIWindow::Process(dt);
}

void FCUIStageSelectWindow::TouchBegan(CGPoint point)
{
    if(m_bShow == false)
        return;
        
    FCUIWindow::TouchBegan(point);
}

void FCUIStageSelectWindow::TouchMoved(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    FCUIWindow::TouchMoved(point);
}

void FCUIStageSelectWindow::TouchEnded(CGPoint point)
{
    if(m_bShow == false)
        return;
    
    for(int i=0;i<4;++i)
    {
        if(m_pTitle[i]->IsInRect(point))
        {
            if(m_pTitle[i]->GetState() == CONTROL_BUTTON_STATE_SELECT)
            {
                AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];        
                FCGameManager* pGameManager = [appDelegate GetGameManager];
                [pGameManager WorldChange:@"title"];
                return;
            } 
        }
    }
    
#ifdef LITE
    for(int i=0;i<3;++i)
    {
        if(m_pLiteButton[i])
        {
            if(m_pLiteButton[i]->IsInRect(point))
            {
                if(m_pLiteButton[i]->GetState() == CONTROL_BUTTON_STATE_SELECT)
                {
                    NSURL *url = [[NSURL alloc] initWithString: @"http://itunes.apple.com/us/app/mike-milkbox/id533130493?mt=8"];
                    [[UIApplication sharedApplication] openURL:url];
                    return;
                }
            }
        }
        
    }
#endif

    for(int i=0;i<STAGE_COUNT;++i)
    {
        for(int j=0;j<MAP_COUNT;++j)
        {
            if(m_pButton[i][j] == NULL)
                continue;
            
            if(m_pButton[i][j]->GetState() == CONTROL_BUTTON_STATE_SELECT)
            {
                if(m_pButton[i][j]->IsInRect(point))
                {
                    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    NSString* strMapName = pMapName[i][j];            
                    FCGameManager* pGameManager = [appDelegate GetGameManager];
                    if(pGameManager)
                    {
                        [pGameManager WorldChange:strMapName];
                    }
                    
                    return;
                }
            }
        }
    }
    
    FCUIWindow::TouchEnded(point);
}

void FCUIStageSelectWindow::ResetStar()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    if(strSaveSlot == NULL)
        return;
    
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    if(pSaveData == NULL)
        return;
    
    for(int i=0;i<STAGE_COUNT;i++)
    {
        for(int j=0;j<MAP_COUNT;j++)
        {
            for(int k = 0; k <3;++k)
            {
                m_pStar[i][j][k]->SetFirstTexture();
            }
        
            FCSaveWorldData* pSaveWorldData = pSaveData->GetSaveWorldData(pMapName[i][j]);
            if(pSaveWorldData == NULL)
                continue;
            
            if(pSaveWorldData->GetMissionTime())
            {
                m_pStar[i][j][0]->SetSecondTexture();
            }
            
            if(pSaveWorldData->GetMissionItem())
            {
                m_pStar[i][j][1]->SetSecondTexture();
            }
            
            if(pSaveWorldData->GetMissionDamage())
            {
                m_pStar[i][j][2]->SetSecondTexture();            
            }
            
            if(pSaveWorldData->GetOpen())
            {
                if(m_pNumber[i][j]) {
                    m_pNumber[i][j]->SetShow(true);
                }
            }
            else
            {
                if(m_pNumber[i][j]) {
                    m_pNumber[i][j]->SetShow(false);
                }
            }
        }
    }
}

void FCUIStageSelectWindow::SetShow(const bool bShow)
{
    FCUIWindow::SetShow(bShow);
    ResetStar();
}

void FCUIStageSelectWindow::InitMark()
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCGameManager* pGameManager = [appDelegate GetGameManager];

    NSString* strGameWorld = [pGameManager GetGameWorld];
    if(strGameWorld)
    {
        for(int i=0;i<STAGE_COUNT;i++)
        {
            for(int j= 0;j<MAP_COUNT;j++)
            {
                if([pMapName[i][j] isEqualToString:strGameWorld])
                {
                    CCSprite* pSprite = m_pButton[i][j]->GetSprite();
                    CGPoint pos = [pSprite position];
                    
                    m_pMark->SetPos(pos);
                }
            }
        }
    }
}

void FCUIStageSelectWindow::Reset()
{
    FCUIWindow::Reset();

    InitMark();
    ResetStar();
}