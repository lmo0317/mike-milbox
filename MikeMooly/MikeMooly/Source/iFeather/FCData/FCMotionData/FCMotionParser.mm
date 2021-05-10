#import "FCMotionParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCMotionParser::Init()
{
    m_pMotionDataManager = new FCMotionDataManager;
}

NSString* FCMotionParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"MotionTemplate" ofType:@"xml"];
}

FCMotionDataManager* FCMotionParser::GetMotionDataManager()
{
    return m_pMotionDataManager;
}

void FCMotionParser::LoadMotionData()
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
    
    NSArray *pMotions = [doc.rootElement elementsForName:@"MOTION"];
    for(GDataXMLElement *pMotion in pMotions)
    {
        FCMotionData* pMotionData = new FCMotionData;        
        NSArray *names = [pMotion elementsForName:@"Name"];
        if (names.count > 0)  
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pMotionData->SetName(strName);
        }
        
        NSArray *pEffects = [pMotion elementsForName:@"EFFECT"];
        for(GDataXMLElement *pEffect in pEffects)
        {
            NSString *pValue = [[(GDataXMLNode *)[pEffect attributeForName:@"value"] stringValue] retain];               
            int nFrame = [(GDataXMLNode *)[pEffect attributeForName:@"frame"] stringValue].intValue;
            pMotionData->AddEffectData(nFrame,pValue);
        }
        
        NSArray *pSounds = [pMotion elementsForName:@"SOUND"];
        for(GDataXMLElement *pSound in pSounds)
        {
            NSString *pValue = [[(GDataXMLNode *)[pSound attributeForName:@"value"] stringValue] retain];               
            int nFrame = [(GDataXMLNode *)[pSound attributeForName:@"frame"] stringValue].intValue;
            pMotionData->AddSoundData(nFrame,pValue);
        }
        
        NSArray *pSoots = [pMotion elementsForName:@"SHOOT"];
        for(GDataXMLElement *pShoot in pSoots)
        {
            int nFrame = [(GDataXMLNode *)[pShoot attributeForName:@"frame"] stringValue].intValue;
            NSString *pModelName = [[(GDataXMLNode *)[pShoot attributeForName:@"model"] stringValue] retain]; 
            pMotionData->AddShootData(nFrame,pModelName);
        }
        
        NSArray *pHitDats = [pMotion elementsForName:@"HITDATA"];
        for(GDataXMLElement *pHitData in pHitDats)
        {
            int nFrame = [(GDataXMLNode *)[pHitData attributeForName:@"frame"] stringValue].intValue;
            NSString *pModelName = [[(GDataXMLNode *)[pHitData attributeForName:@"model"] stringValue] retain];
            pMotionData->AddHitData(nFrame,pModelName);
        }
        
        
        m_pMotionDataManager->AddMotionData(pMotionData);
    }

    [doc release];
    //[xmlData release];
}