#import "FCHitBoxDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCHitBoxDataParser::Init()
{
    m_pHitBoxDataManager = new FCHitBoxDataManager;
}

NSString* FCHitBoxDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"HitBoxDataTemplate" ofType:@"xml"];
}

FCHitBoxDataManager* FCHitBoxDataParser::GetHitBoxDataManager()
{
    return m_pHitBoxDataManager;
}

void FCHitBoxDataParser::LoadHitBoxData()
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
    
    
    NSArray *pHitBoxs = [doc.rootElement elementsForName:@"HIT_BOX_DATA"];
    for (GDataXMLElement *pHitBox in pHitBoxs) 
    {
        FCHitBoxData* pHitBoxData = new FCHitBoxData;
        //name
        NSArray *names = [pHitBox elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pHitBoxData->SetName(strName);
        }
        
        NSArray* pLifeTime = [pHitBox elementsForName:@"LIFE_TIME"];
        if(pLifeTime.count > 0)
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pLifeTime objectAtIndex:0];            
            float fLifeTIme = pValue.stringValue.floatValue;
            pHitBoxData->SetLifeTime(fLifeTIme);    
        }
        
        m_pHitBoxDataManager->AddHitBoxData(pHitBoxData);
    }
    
    [doc release];
    //[xmlData release];
}