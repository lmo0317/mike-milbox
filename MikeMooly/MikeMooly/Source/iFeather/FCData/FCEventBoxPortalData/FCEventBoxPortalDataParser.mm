#import "FCEventBoxPortalDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCEventBoxPortalDataParser::Init()
{
    m_pEventBoxPortalDataManager = new FCEventBoxPortalDataManager;
}

NSString* FCEventBoxPortalDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"EventBoxPortalDataTemplate" ofType:@"xml"];
                                                    
}

FCEventBoxPortalDataManager* FCEventBoxPortalDataParser::GetEventBoxPortalDataManager()
{
    
    return m_pEventBoxPortalDataManager;
}

void FCEventBoxPortalDataParser::LoadEventBoxPortalData()
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
    
    
    NSArray *pEventBoxPortals = [doc.rootElement elementsForName:@"EVENT_BOX_PORTAL"];
    for (GDataXMLElement *pEventBoxPortal in pEventBoxPortals) 
    {
        FCEventBoxPortalData* pEventBoxPortalData = new FCEventBoxPortalData;
        //name
        NSArray *names = [pEventBoxPortal elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pEventBoxPortalData->SetName(strName);
        }
        
        NSArray* pMap = [pEventBoxPortal elementsForName:@"MAP"];
        if(pMap.count > 0)
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pMap objectAtIndex:0];
            NSString * strMap = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pEventBoxPortalData->SetMapName(strMap);    
        }
        
        NSArray* pEventBox = [pEventBoxPortal elementsForName:@"EVENT_BOX_POSITION"];
        if(pEventBox.count > 0)
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pEventBox objectAtIndex:0];
            NSString * strEventBoxPosition = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pEventBoxPortalData->SetEventBoxPositionName(strEventBoxPosition);    
        }
        
        NSArray* pType = [pEventBoxPortal elementsForName:@"TYPE"];
        if(pType.count > 0)
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pType objectAtIndex:0];
            NSString * strType = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pEventBoxPortalData->SetType(strType);    
        }
        
        NSArray *pStates = [pEventBoxPortal elementsForName:@"STATE"];
        for(GDataXMLElement *pState in pStates)
        {
            NSString *pValue = [[(GDataXMLNode *)[pState attributeForName:@"value"] stringValue] retain];                
            NSString *pID = [[(GDataXMLNode *)[pState attributeForName:@"id"] stringValue] retain];
            int nCategory = [(GDataXMLNode *)[pState attributeForName:@"category"] stringValue].intValue;
            
            pEventBoxPortalData->AddStateData(pID,nCategory,pValue);
        }


        m_pEventBoxPortalDataManager->AddEventBoxPortalData(pEventBoxPortalData);
    }
    
    [doc release];
    //[xmlData release];
}