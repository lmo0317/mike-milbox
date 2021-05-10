#import "FCDefaultDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCDefaultDataParser::Init()
{
    m_pDefaultDataManager = new FCDefaultDataManager;
}

NSString* FCDefaultDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"DefaultDataTemplate" ofType:@"xml"];
                                                    
}

FCDefaultDataManager* FCDefaultDataParser::GetDefaultDataManager()
{
    
    return m_pDefaultDataManager;
}

void FCDefaultDataParser::LoadDefaultData()
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
    
    
    NSArray *pDefaults = [doc.rootElement elementsForName:@"DEFAULT"];
    for (GDataXMLElement *pDefault in pDefaults) 
    {
        FCDefaultData* pDefaultData = new FCDefaultData;
        //name
        NSArray *names = [pDefault elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pDefaultData->SetName(strName);
        }
        
        NSArray *pLife = [pDefault elementsForName:@"LIFE"];
        if (pLife.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pLife objectAtIndex:0];
            const int nLife = pValue.stringValue.integerValue;
            pDefaultData->SetLife(nLife);
        }
        
        NSArray *pHeart = [pDefault elementsForName:@"HEART"];
        if (pHeart.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pHeart objectAtIndex:0];
            const int nHeart = pValue.stringValue.integerValue;
            pDefaultData->SetHP(nHeart);
        }
        
        NSArray *pContinueCount = [pDefault elementsForName:@"CONTINUE_COUNT"];
        if (pContinueCount.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pContinueCount objectAtIndex:0];
            const int nContinueCount = pValue.stringValue.integerValue;
            pDefaultData->SetContinueCount(nContinueCount);
        }
        
        NSArray *pSounds = [pDefault elementsForName:@"SOUND"];
        for(GDataXMLElement *pSound in pSounds)
        {
            NSString *pValue = [[(GDataXMLNode *)[pSound attributeForName:@"value"] stringValue] retain];                
            NSString *pID = [[(GDataXMLNode *)[pSound attributeForName:@"id"] stringValue] retain];
            int nCategory = [(GDataXMLNode *)[pSound attributeForName:@"category"] stringValue].intValue;
            
            pDefaultData->AddSoundData(pID,nCategory,pValue);
        }
        
        m_pDefaultDataManager->AddDefaultData(pDefaultData);
    }
    
    [doc release];
    //[xmlData release];
}