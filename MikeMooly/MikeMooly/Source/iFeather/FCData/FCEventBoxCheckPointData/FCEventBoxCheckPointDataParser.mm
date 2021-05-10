#import "FCEventBoxCheckPointDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCEventBoxCheckPointDataParser::Init()
{
    m_pEventBoxCheckPointDataManager = new FCEventBoxCheckPointDataManager;
}

NSString* FCEventBoxCheckPointDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"EventBoxCheckPointDataTemplate" ofType:@"xml"];
                                                    
}

FCEventBoxCheckPointDataManager* FCEventBoxCheckPointDataParser::GetEventBoxCheckPointDataManager()
{
    
    return m_pEventBoxCheckPointDataManager;
}

void FCEventBoxCheckPointDataParser::LoadEventBoxCheckPointData()
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
    
    
    NSArray *pEventBoxCheckPoints = [doc.rootElement elementsForName:@"EVENT_BOX_CHECK_POINT"];
    for (GDataXMLElement *pEventBoxCheckPoint in pEventBoxCheckPoints) 
    {
        FCEventBoxCheckPointData* pEventBoxCheckPointData = new FCEventBoxCheckPointData;
        //name
        NSArray *names = [pEventBoxCheckPoint elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pEventBoxCheckPointData->SetName(strName);
        }
        
        NSArray *pStates = [pEventBoxCheckPoint elementsForName:@"STATE"];
        for(GDataXMLElement *pState in pStates)
        {
            NSString *pValue = [[(GDataXMLNode *)[pState attributeForName:@"value"] stringValue] retain];                
            NSString *pID = [[(GDataXMLNode *)[pState attributeForName:@"id"] stringValue] retain];
            int nCategory = [(GDataXMLNode *)[pState attributeForName:@"category"] stringValue].intValue;
            
            pEventBoxCheckPointData->AddStateData(pID,nCategory,pValue);
        }

        m_pEventBoxCheckPointDataManager->AddEventBoxCheckPointData(pEventBoxCheckPointData);
    }
    
    [doc release];
    //[xmlData release];
}