#import "FCWorldDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCWorldDataParser::Init()
{
    m_pWorldDataManager = new FCWorldDataManager;
}

NSString* FCWorldDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"WorldDataTemplate" ofType:@"xml"];
                                                    
}

FCWorldDataManager* FCWorldDataParser::GetWorldDataManager()
{
    
    return m_pWorldDataManager;
}

void FCWorldDataParser::LoadWorldData()
{
    NSString *filePath = dataFilePath();
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    
    //decrypt----------------------------------------------------------------------------------
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCEncryption* pEncryption = [appDelegate GetEncryption];
    xmlData = [pEncryption decryptDES:xmlData];
    //-----------------------------------------------------------------------------------------
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
                                                           options:0 error:&error];
    if (doc == nil) 
    { 
        return; 
    }
    
    
    NSArray *pWorlds = [doc.rootElement elementsForName:@"WORLD"];
    for (GDataXMLElement *pWorld in pWorlds) 
    {
        FCWorldData* pWorldData = new FCWorldData;
        //name
        NSArray *names = [pWorld elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pWorldData->SetName(strName);
            
            //CCLOG(@"WORLD NAME = [%@]",strName);
        }
        
        NSArray *pType = [pWorld elementsForName:@"TYPE"];
        if (pType.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pType objectAtIndex:0];
            NSString * strType = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pWorldData->SetType(strType);
        }
        
        NSArray *pBGM = [pWorld elementsForName:@"BGM"];
        if (pBGM.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pBGM objectAtIndex:0];
            NSString * strBGM = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pWorldData->SetBGM(strBGM);
        }
        
        NSArray *pTime = [pWorld elementsForName:@"TIME"];
        if (pTime.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pTime objectAtIndex:0];
            int nTime = pValue.stringValue.intValue;
            
            pWorldData->SetTime(nTime);
        }
        
        NSArray *pGroup = [pWorld elementsForName:@"GROUP"];
        if (pGroup.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pGroup objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pWorldData->SetGroup(strName);
        }
        
        NSArray *pGroupEnd = [pWorld elementsForName:@"GROUP_END"];
        if (pGroupEnd.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pGroupEnd objectAtIndex:0];
            const bool bGroupEnd = pValue.stringValue.intValue != 0;
            pWorldData->SetGroupEnd(bGroupEnd);
        }
        
        NSArray *pGroupFirst = [pWorld elementsForName:@"GROUP_FIRST"];
        if (pGroupFirst.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pGroupFirst objectAtIndex:0];
            const bool bGroupFirst = pValue.stringValue.intValue != 0;
            pWorldData->SetGroupFirst(bGroupFirst);
        }
        
        NSArray *pMissionTime = [pWorld elementsForName:@"MISSION_TIME"];
        if (pMissionTime.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pMissionTime objectAtIndex:0];
            const int nMissionTime = pValue.stringValue.intValue;
            pWorldData->SetMissionTime(nMissionTime);
        }
        
        NSArray *pMissionDamage = [pWorld elementsForName:@"MISSION_DAMAGE"];
        if (pMissionDamage.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pMissionDamage objectAtIndex:0];
            const int nMissionDamage = pValue.stringValue.intValue;
            pWorldData->SetMissionDamage(nMissionDamage);
        }
        
        NSArray *pUIStageName = [pWorld elementsForName:@"UI_STAGE_NAME"];
        if (pUIStageName.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pUIStageName objectAtIndex:0];
            NSString * strUIStageName = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pWorldData->SetUIStageName(strUIStageName);
        }
        
        NSArray *pUIStageSprite = [pWorld elementsForName:@"UI_STAGE_SPRITE"];
        if (pUIStageSprite.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pUIStageSprite objectAtIndex:0];
            NSString * strUIStageSprite = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pWorldData->SetUIStageSprite(strUIStageSprite);
        }
        
        NSArray *pSoundPreloads = [pWorld elementsForName:@"SOUND_PRELOAD"];
        for(GDataXMLElement *pSoundPreload in pSoundPreloads)
        {
            NSString *pValue = [[(GDataXMLNode *)[pSoundPreload attributeForName:@"value"] stringValue] retain];
            pWorldData->AddSoundPreload(pValue);
        } 

        m_pWorldDataManager->AddWorldData(pWorldData);
    }
    
    [doc release];
    //[xmlData release];
}