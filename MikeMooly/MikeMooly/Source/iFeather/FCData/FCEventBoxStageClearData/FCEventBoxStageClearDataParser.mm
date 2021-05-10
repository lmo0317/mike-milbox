#import "FCEventBoxStageClearDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCEventBoxStageClearDataParser::Init()
{
    m_pEventBoxStageClearDataManager = new FCEventBoxStageClearDataManager;
}

NSString* FCEventBoxStageClearDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"EventBoxStageClearDataTemplate" ofType:@"xml"];
                                                    
}

FCEventBoxStageClearDataManager* FCEventBoxStageClearDataParser::GetEventBoxStageClearDataManager()
{
    
    return m_pEventBoxStageClearDataManager;
}

void FCEventBoxStageClearDataParser::LoadEventBoxStageClearData()
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
    
    
    NSArray *pEventBoxStageClears = [doc.rootElement elementsForName:@"EVENT_BOX_STAGE_CLEAR"];
    for (GDataXMLElement *pEventBoxStageClear in pEventBoxStageClears) 
    {
        FCEventBoxStageClearData* pEventBoxStageClearData = new FCEventBoxStageClearData;
        //name
        NSArray *names = [pEventBoxStageClear elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pEventBoxStageClearData->SetName(strName);
        }
        
        NSArray *pNextStage = [pEventBoxStageClear elementsForName:@"NextStage"];
        if (pNextStage.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pNextStage objectAtIndex:0];
            NSString * strNextStage = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pEventBoxStageClearData->SetNextStage(strNextStage);
        }
        
        NSArray *pStates = [pEventBoxStageClear elementsForName:@"STATE"];
        for(GDataXMLElement *pState in pStates)
        {
            NSString *pValue = [[(GDataXMLNode *)[pState attributeForName:@"value"] stringValue] retain];                
            NSString *pID = [[(GDataXMLNode *)[pState attributeForName:@"id"] stringValue] retain];
            int nCategory = [(GDataXMLNode *)[pState attributeForName:@"category"] stringValue].intValue;
            
            pEventBoxStageClearData->AddStateData(pID,nCategory,pValue);
        }

        m_pEventBoxStageClearDataManager->AddEventBoxStageClearData(pEventBoxStageClearData);
    }
    
    [doc release];
    //[xmlData release];
}