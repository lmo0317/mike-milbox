#import "FCDataManager.h"

@implementation FCDataManager

-(void) Init
{    
    m_pPlayerParser = new FCPlayerParser;
    m_pPlayerParser->Init();
    m_pPlayerParser->LoadPlayerData();
    
    m_pEnemyParser = new FCEnemyParser;
    m_pEnemyParser->Init();
    m_pEnemyParser->LoadEnemyData();
    
    m_pAIParser = new FCAIParser;
    m_pAIParser->Init();
    m_pAIParser->LoadAIData();
    
    m_pShootParser = new FCShootParser;
    m_pShootParser->Init();
    m_pShootParser->LoadShootData();
    
    m_pMotionParser = new FCMotionParser;
    m_pMotionParser->Init();
    m_pMotionParser->LoadMotionData();
    
    m_pHitBoxDataParser = new FCHitBoxDataParser;
    m_pHitBoxDataParser->Init();
    m_pHitBoxDataParser->LoadHitBoxData();
    
    m_pBlockDataParser = new FCBlockDataParser;
    m_pBlockDataParser->Init();
    m_pBlockDataParser->LoadBlockData();
    
    m_pFieldItemDataParser = new FCFieldItemDataParser;
    m_pFieldItemDataParser->Init();
    m_pFieldItemDataParser->LoadFieldItemData();
    
    m_pEventBoxPortalDataParser = new FCEventBoxPortalDataParser;
    m_pEventBoxPortalDataParser->Init();
    m_pEventBoxPortalDataParser->LoadEventBoxPortalData();
    
    
    m_pEventBoxCheckPointDataParser = new FCEventBoxCheckPointDataParser;
    m_pEventBoxCheckPointDataParser->Init();
    m_pEventBoxCheckPointDataParser->LoadEventBoxCheckPointData();
    
    m_pWorldDataParser = new FCWorldDataParser;
    m_pWorldDataParser->Init();
    m_pWorldDataParser->LoadWorldData();
    
    m_pUIWindowListDataParser = new FCUIWindowListDataParser;
    m_pUIWindowListDataParser->Init();
    m_pUIWindowListDataParser->LoadUIWindowListData();
    m_pUIWindowListDataParser->LoadUIWindowData();
    
    m_pEventBoxStageClearDataParser = new FCEventBoxStageClearDataParser;
    m_pEventBoxStageClearDataParser->Init();
    m_pEventBoxStageClearDataParser->LoadEventBoxStageClearData();
    
    m_pActionDataParser = new FCActionDataParser;
    m_pActionDataParser->Init();
    m_pActionDataParser->LoadActionData();
    
    m_pSaveDataParser = new FCSaveDataParser;
    m_pSaveDataParser->Init();
    m_pSaveDataParser->LoadSaveData();
    
    m_pDefaultDataParser = new FCDefaultDataParser;
    m_pDefaultDataParser->Init();
    m_pDefaultDataParser->LoadDefaultData();
    
    m_pGimmickDataParser = new FCGimmickDataParser;
    m_pGimmickDataParser->Init();
    m_pGimmickDataParser->LoadGimmickData();
    
    m_pOptionDataParser = new FCOptionDataParser;
    m_pOptionDataParser->Init();
    m_pOptionDataParser->LoadOptionData();
}

-(void) Finish
{
    
}

//------------------------------------------------------------------------------
-(FCPlayerDataManager*) GetPlayerDataManager
{
    return m_pPlayerParser->GetPlayerDataManager();
}

-(FCEnemyDataManager*) GetEnemyDataManager
{
    return m_pEnemyParser->GetEnemyDataManager();
}

-(FCAIDataManager*) GetAIDataManager
{
    return m_pAIParser->GetAIDataManager();
}

-(FCShootDataManager*) GetShootDataManager
{
    return m_pShootParser->GetShootDataManager();
}

-(FCMotionDataManager*) GetMotionDataManager
{
    return m_pMotionParser->GetMotionDataManager();
}

-(FCHitBoxDataManager*) GetHitBoxDataManager
{
    return m_pHitBoxDataParser->GetHitBoxDataManager();
}

-(FCBlockDataManager*) GetBlockDataManager
{
    return m_pBlockDataParser->GetBlockDataManager();
}

-(FCFieldItemDataManager*) GetFieldItemDataManager
{
    return m_pFieldItemDataParser->GetFieldItemDataManager();
}

-(FCEventBoxPortalDataManager*) GetEventBoxPortalDataManager
{
    return m_pEventBoxPortalDataParser->GetEventBoxPortalDataManager();
}

-(FCWorldDataManager*) GetWorldDataManager
{
    return m_pWorldDataParser->GetWorldDataManager();
}

-(FCUIWindowListDataManager*) GetUIWindowListDataManager
{
    return m_pUIWindowListDataParser->GetUIWindowListDataManager();
}

-(FCEventBoxStageClearDataManager*) GetEventBoxStageClearDataManager
{
    return m_pEventBoxStageClearDataParser->GetEventBoxStageClearDataManager();
}

-(FCActionDataManager*) GetActionDataManager
{
    return m_pActionDataParser->GetActionDataManager();
}

-(FCSaveDataManager*) GetSaveDataManager
{
    return m_pSaveDataParser->GetSaveDataManager();
}

-(FCDefaultDataManager*) GetDefaultDataManager
{
    return m_pDefaultDataParser->GetDefaultDataManager();
}

-(FCGimmickDataManager*) GetGimmickDataManager
{
    return m_pGimmickDataParser->GetGimmickDataManager();
}

-(FCEventBoxCheckPointDataManager*) GetEventBoxCheckPointDataManager
{
    return m_pEventBoxCheckPointDataParser->GetEventBoxCheckPointDataManager();
}

-(FCOptionDataManager*) GetOptionDataManager
{
    return m_pOptionDataParser->GetOptionDataManager();
}

//------------------------------------------------------------------------------
-(FCSaveDataParser*) GetSaveDataParser
{
    return m_pSaveDataParser;
}

-(FCOptionDataParser*) GetOptionDataParser
{
    return m_pOptionDataParser;
}

@end