#import "FCShootParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCShootParser::Init()
{
    m_pShootDataManager = new FCShootDataManager;
}

NSString* FCShootParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"ShootTemplate" ofType:@"xml"];
}

FCShootDataManager* FCShootParser::GetShootDataManager()
{
    return m_pShootDataManager;
}

void FCShootParser::LoadShootData()
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
    
    NSArray *pShoots = [doc.rootElement elementsForName:@"SHOOT"];
    for (GDataXMLElement *pShoot in pShoots) 
    {
        FCShootData* pShootData = new FCShootData;
        //name
        NSArray *names = [pShoot elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pShootData->SetName(strName);
        }
        
        NSArray* pLifeTime = [pShoot elementsForName:@"LIFE_TIME"];
        if(pLifeTime.count > 0)
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pLifeTime objectAtIndex:0];            
            int fLifeTIme = pValue.stringValue.floatValue;
            pShootData->SetLifeTime(fLifeTIme);    
        }
        
        m_pShootDataManager->AddShootData(pShootData);
    }
    
    [doc release];
    //[xmlData release];
}