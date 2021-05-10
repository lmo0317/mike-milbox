#ifndef MikeMooly_FCDataManager_h
#define MikeMooly_FCDataManager_h

#import "FCPlayerDataManager.h"
#import "FCEnemyDataManager.h"
#import "FCAIDataManager.h"
#import "FCShootDataManager.h"
#import "FCMotionDataManager.h"
#import "FCHitBoxDataManager.h"
#import "FCBLockDataManager.h"
#import "FCFIeldItemDataManager.h"
#import "FCEventBoxPortalDataManager.h"
#import "FCEventBoxCheckPointDataManager.h"
#import "FCWorldDataManager.h"
#import "FCUIWindowListDataManager.h"
#import "FCEventBoxStageClearDataManager.h"
#import "FCActionDataManager.h"
#import "FCSaveDataManager.h"
#import "FCDefaultDataManager.h"
#import "FCGimmickDataManager.h"
#import "FCOptionDataManager.h"

#import "FCPlayerParser.h"
#import "FCEnemyParser.h"
#import "FCShootParser.h"
#import "FCMotionParser.h"
#import "FCAIParser.h"
#import "FCHitBoxDataParser.h"
#import "FCBlockDataParser.h"
#import "FCFieldItemDataParser.h"
#import "FCEventBoxPortalDataParser.h"
#import "FCEventBoxCheckPointDataParser.h"
#import "FCWorldDataParser.h"
#import "FCUIWindowListDataParser.h"
#import "FCEventBoxStageClearDataParser.h"
#import "FCActionDataParser.h"
#import "FCSaveDataParser.h"
#import "FCDefaultDataParser.h"
#import "FCGimmickDataParser.h"
#import "FCOptionDataParser.h"

@interface FCDataManager : NSObject 
{
    FCPlayerParser *m_pPlayerParser;
    FCEnemyParser *m_pEnemyParser;
    FCAIParser *m_pAIParser;
    FCShootParser *m_pShootParser;
    FCMotionParser *m_pMotionParser;
    FCHitBoxDataParser *m_pHitBoxDataParser;
    FCBlockDataParser *m_pBlockDataParser;
    FCFieldItemDataParser *m_pFieldItemDataParser;
    FCEventBoxPortalDataParser *m_pEventBoxPortalDataParser;
    FCWorldDataParser *m_pWorldDataParser;
    FCEventBoxStageClearDataParser *m_pEventBoxStageClearDataParser;
    FCActionDataParser* m_pActionDataParser;
    FCSaveDataParser* m_pSaveDataParser;
    FCDefaultDataParser* m_pDefaultDataParser;
    FCGimmickDataParser* m_pGimmickDataParser;
    FCEventBoxCheckPointDataParser* m_pEventBoxCheckPointDataParser;
    
    FCUIWindowListDataParser *m_pUIWindowListDataParser;
    FCOptionDataParser* m_pOptionDataParser;
}

-(void) Init;
-(void) Finish;
-(FCPlayerDataManager*) GetPlayerDataManager;
-(FCEnemyDataManager*) GetEnemyDataManager;
-(FCAIDataManager*) GetAIDataManager;
-(FCShootDataManager*) GetShootDataManager;
-(FCMotionDataManager*) GetMotionDataManager;
-(FCHitBoxDataManager*) GetHitBoxDataManager;
-(FCBlockDataManager*) GetBlockDataManager;
-(FCFieldItemDataManager*) GetFieldItemDataManager;
-(FCEventBoxPortalDataManager*) GetEventBoxPortalDataManager;
-(FCWorldDataManager*) GetWorldDataManager;
-(FCUIWindowListDataManager*) GetUIWindowListDataManager;
-(FCEventBoxStageClearDataManager*) GetEventBoxStageClearDataManager;
-(FCActionDataManager*) GetActionDataManager;
-(FCSaveDataManager*) GetSaveDataManager;
-(FCDefaultDataManager*) GetDefaultDataManager;
-(FCGimmickDataManager*) GetGimmickDataManager;
-(FCEventBoxCheckPointDataManager*) GetEventBoxCheckPointDataManager;
-(FCOptionDataManager*) GetOptionDataManager;

//------------------------------------------------------------------------------
-(FCSaveDataParser*) GetSaveDataParser;
-(FCOptionDataParser*) GetOptionDataParser;

@end
#endif
