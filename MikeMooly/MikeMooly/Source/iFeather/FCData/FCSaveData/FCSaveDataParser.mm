#import "FCSaveDataParser.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCSaveDataParser::Init()
{
    m_pSaveDataManager = new FCSaveDataManager;
}

NSString * FCSaveDataParser::dataFilePath(const bool forSave)
{    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                         NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"SaveDataTemplate.xml"];
    if (forSave || [[ NSFileManager defaultManager] fileExistsAtPath:documentsPath]) 
    {
        return documentsPath;
    }
    else 
    {
        return [[NSBundle mainBundle] pathForResource:@"SaveDataTemplate" ofType:@"xml"];
    }
}
    

FCSaveDataManager* FCSaveDataParser::GetSaveDataManager()
{
    
    return m_pSaveDataManager;
}

void FCSaveDataParser::LoadSaveData()
{
    NSString *filePath = dataFilePath(false);
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    
    //decrypt----------------------------------------------------------------------------------
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCEncryption* pEncryption = [appDelegate GetEncryption];
    xmlData = [pEncryption decryptDES:xmlData];
    //-----------------------------------------------------------------------------------------
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
                                                           options:0 error:&error];
    if(doc == nil) 
    { 
        return; 
    }
    
    NSArray *pSaves = [doc.rootElement elementsForName:@"SAVE_DATA"];
    for (GDataXMLElement *pSave in pSaves) 
    {
        FCSaveData* pSaveData = new FCSaveData;
        //name
        NSArray *names = [pSave elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pSaveData->SetName(strName);
        }
        
        NSArray *pLife = [pSave elementsForName:@"LIFE"];
        if (pLife.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pLife objectAtIndex:0];
            const int nLife = pValue.stringValue.intValue;
            
            pSaveData->SetLife(nLife);
        }
        
        NSArray *pHeart = [pSave elementsForName:@"HEART"];
        if(pHeart.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pHeart objectAtIndex:0];
            const int nHeart = pValue.stringValue.intValue;
            
            pSaveData->SetHP(nHeart);
        }
        
        NSArray *pContinueCount = [pSave elementsForName:@"CONTINUE_COUNT"];
        if(pContinueCount.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pContinueCount objectAtIndex:0];
            const int nContinueCount = pValue.stringValue.intValue;
            
            pSaveData->SetContinueCount(nContinueCount);
        }
        
        NSArray *pConin = [pSave elementsForName:@"COIN"];
        if(pConin.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pConin objectAtIndex:0];
            const int nCoin = pValue.stringValue.intValue;
            
            pSaveData->SetCoin(nCoin);
        }
        
        NSArray *pScore = [pSave elementsForName:@"SCORE"];
        if(pScore.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pScore objectAtIndex:0];
            const int nScore = pValue.stringValue.intValue;
            
            pSaveData->SetScore(nScore);
        }
        
        NSArray *pWorlds = [pSave elementsForName:@"WORLD"];
        for(GDataXMLElement *pWorld in pWorlds)
        {
            NSString *pID = [[(GDataXMLNode *)[pWorld attributeForName:@"id"] stringValue] retain];
            int nOpen = [(GDataXMLNode *)[pWorld attributeForName:@"open"] stringValue].intValue;
            int nLock = [(GDataXMLNode *)[pWorld attributeForName:@"lock"] stringValue].intValue;
            
            int bMissionTime    = [(GDataXMLNode *)[pWorld attributeForName:@"mission_time"] stringValue].intValue;
            int bMissionDamage  = [(GDataXMLNode *)[pWorld attributeForName:@"mission_damage"] stringValue].intValue;
            int bMissionItem    = [(GDataXMLNode *)[pWorld attributeForName:@"mission_item"] stringValue].intValue;
            
            FCSaveWorldData* pSaveWorldData = pSaveData->AddSaveWorldData(pID);
            if(pSaveWorldData)
            {
                pSaveWorldData->SetOpen(nOpen != 0);
                pSaveWorldData->SetLock(nLock != 0);
                pSaveWorldData->SetMissionTime(bMissionTime != 0);
                pSaveWorldData->SetMissionDamage(bMissionDamage != 0);
                pSaveWorldData->SetMissionItem(bMissionItem != 0);
#ifdef DEBUG
                pSaveWorldData->SetOpen(1);
#endif
            }
        }    
        m_pSaveDataManager->AddSaveData(pSaveData);
    }
    
    [doc release];
    //[xmlData release];
}

void FCSaveDataParser::SaveDataElement(FCSaveData* pSaveData,GDataXMLElement * pSaveDataTemplate)
{
    GDataXMLElement * pSave = [GDataXMLNode elementWithName:@"SAVE_DATA"];
    
    GDataXMLElement * nameElement = [GDataXMLNode elementWithName:@"Name" stringValue:pSaveData->GetName()];
    
    GDataXMLElement * lifeElement = [GDataXMLNode elementWithName:@"LIFE" 
                                                      stringValue:[NSString stringWithFormat:@"%d",pSaveData->GetLife()]];
    
    GDataXMLElement * heartElement = [GDataXMLNode elementWithName:@"HEART" 
                                                       stringValue:[NSString stringWithFormat:@"%d",pSaveData->GetHP()]];
    
    GDataXMLElement * continueCountElement = [GDataXMLNode elementWithName:@"CONTINUE_COUNT" 
                                                               stringValue:[NSString stringWithFormat:@"%d",pSaveData->GetContinueCount()]];
    
    GDataXMLElement * coinElement = [GDataXMLNode elementWithName:@"COIN" 
                                                      stringValue:[NSString stringWithFormat:@"%d",pSaveData->GetCoin()]];
    
    
    GDataXMLElement * scoreElement = [GDataXMLNode elementWithName:@"SCORE" 
                                                       stringValue:[NSString stringWithFormat:@"%d",pSaveData->GetScore()]];
    
    [pSave addChild:nameElement];
    [pSave addChild:lifeElement];
    [pSave addChild:heartElement];
    [pSave addChild:continueCountElement];
    [pSave addChild:coinElement];
    [pSave addChild:scoreElement];
    
    FCSaveWorldDataManager* pSaveWorldDataManager = pSaveData->GetSaveWorldDataManager();
    std::map<NSInteger,FCSaveWorldData*>* hashSaveWorldData = pSaveWorldDataManager->GetSaveWorldDataHash();
    std::map<NSInteger,FCSaveWorldData*>::iterator it = hashSaveWorldData->begin();
    for(;it != hashSaveWorldData->end();++it)
    {
        FCSaveWorldData* pSaveWorldData = (*it).second;
        GDataXMLElement * worldElement = [GDataXMLNode elementWithName:@"WORLD"];
        GDataXMLNode* idNode = [GDataXMLNode attributeWithName:@"id" stringValue:pSaveWorldData->GetID()];
        
        
        NSString* strOpen = [NSString stringWithFormat:@"%d",pSaveWorldData->GetOpen()];        
        GDataXMLNode* openNode = [GDataXMLNode attributeWithName:@"open" stringValue:strOpen];
        
        NSString* strLock = [NSString stringWithFormat:@"%d",pSaveWorldData->GetLock()];
        GDataXMLNode* lockNode = [GDataXMLNode attributeWithName:@"lock" stringValue:strLock];
        
        NSString* strMissionTime = [NSString stringWithFormat:@"%d",pSaveWorldData->GetMissionTime()];
        GDataXMLNode* mission_timeNode = [GDataXMLNode attributeWithName:@"mission_time" stringValue:strMissionTime];
        
        NSString* strMissionItem = [NSString stringWithFormat:@"%d",pSaveWorldData->GetMissionItem()];
        GDataXMLNode* mission_itemNode = [GDataXMLNode attributeWithName:@"mission_item" stringValue:strMissionItem];
        
        NSString* strMissionDamage = [NSString stringWithFormat:@"%d",pSaveWorldData->GetMissionDamage()];
        GDataXMLNode* mission_damageNode = [GDataXMLNode attributeWithName:@"mission_damage" stringValue:strMissionDamage];
        
        
        [worldElement addAttribute:idNode];
        [worldElement addAttribute:openNode];
        [worldElement addAttribute:lockNode];
        [worldElement addAttribute:mission_timeNode];
        [worldElement addAttribute:mission_itemNode];
        [worldElement addAttribute:mission_damageNode];
        
        [pSave addChild:worldElement];
    }
    
    [pSaveDataTemplate addChild:pSave];    
}

void FCSaveDataParser::SaveSaveData()
{
    GDataXMLElement * pSaveDataTemplate = [GDataXMLNode elementWithName:@"SaveDataTemplate"];
    
    std::map<NSInteger ,FCSaveData*>* mapSaveData = m_pSaveDataManager->GetSaveDataMap();
    std::map<NSInteger ,FCSaveData*>::iterator it_save_data = mapSaveData->begin();
    for(;it_save_data != mapSaveData->end();++it_save_data)
    {
        FCSaveData* pSaveData = it_save_data->second;
        SaveDataElement(pSaveData,pSaveDataTemplate);
    }
    
    GDataXMLDocument *document = [[[GDataXMLDocument alloc] initWithRootElement:pSaveDataTemplate] autorelease];
    NSData *xmlData = document.XMLData;
    
    NSString *filePath = dataFilePath(true);
    NSLog(@"Saving xml data to %@...", filePath);
    
    //encrypt-----------------------------------------------------------------------------------------------------------
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCEncryption* pEncryption = [appDelegate GetEncryption];
    xmlData = [pEncryption encryptDES:xmlData];
    [xmlData writeToFile:filePath atomically:YES];
    //---------------------------------------------------------------------------------------------------------------------
}