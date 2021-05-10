#import "FCGimmickDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCGimmickDataParser::Init()
{
    m_pGimmickDataManager = new FCGimmickDataManager;
}

NSString* FCGimmickDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"GimmickDataTemplate" ofType:@"xml"];
}

FCGimmickDataManager* FCGimmickDataParser::GetGimmickDataManager()
{
    return m_pGimmickDataManager;
}

void FCGimmickDataParser::LoadGimmickData()
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
    
    
    NSArray *pGimmicks = [doc.rootElement elementsForName:@"GIMMICK_DATA"];
    for (GDataXMLElement *pGimmick in pGimmicks) 
    {
        FCGimmickData* pGimmickData = new FCGimmickData;
        //name
        NSArray *names = [pGimmick elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pGimmickData->SetName(strName);
        }
        
        NSArray* pTarget = [pGimmick elementsForName:@"TARGET"];
        if(pTarget.count >0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pTarget objectAtIndex:0];
            NSString * strTarget = [[NSString stringWithFormat:@"%@",pVaue.stringValue] retain];
            pGimmickData->SetTarget(strTarget);
        }
        
        NSArray* pOneShot = [pGimmick elementsForName:@"ONE_SHOT"];
        if(pOneShot.count >0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pOneShot objectAtIndex:0];
            bool bOneShot = pVaue.stringValue.intValue != 0;
            pGimmickData->SetOneShot(bOneShot);
        }
        
        m_pGimmickDataManager->AddGimmickData(pGimmickData);
    }
    
    [doc release];
    //[xmlData release];
}