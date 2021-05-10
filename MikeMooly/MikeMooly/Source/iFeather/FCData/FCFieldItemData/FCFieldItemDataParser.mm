#import "FCFieldItemDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCFieldItemDataParser::Init()
{
    m_pFieldItemDataManager = new FCFieldItemDataManager;
}

NSString* FCFieldItemDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"FieldItemDataTemplate" ofType:@"xml"];
                                                    
}

FCFieldItemDataManager* FCFieldItemDataParser::GetFieldItemDataManager()
{
    
    return m_pFieldItemDataManager;
}

void FCFieldItemDataParser::LoadFieldItemData()
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
    
    
    NSArray *pFieldItems = [doc.rootElement elementsForName:@"FIELDITEM"];
    for (GDataXMLElement *pFieldItem in pFieldItems) 
    {
        FCFieldItemData* pFieldItemData = new FCFieldItemData;
        //name
        NSArray *names = [pFieldItem elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pFieldItemData->SetName(strName);
        }
        
        NSArray *pCategory = [pFieldItem elementsForName:@"CATEGORY"];
        if (pCategory.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pCategory objectAtIndex:0];
            NSString * strCategory = [[NSString stringWithFormat:@"%@",pValue.stringValue] retain];
            pFieldItemData->SetCategory(strCategory);
        }
        
        NSArray *pScore = [pFieldItem elementsForName:@"SCORE"];
        if (pScore.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pScore objectAtIndex:0];
            int nScore = pValue.stringValue.intValue;
            pFieldItemData->SetScore(nScore);
        }
        
        NSArray *pMissionItemID = [pFieldItem elementsForName:@"MISSION_ITEM_ID"];
        if(pMissionItemID.count >0)
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pMissionItemID objectAtIndex:0];
            int nMissionItemID = pValue.stringValue.intValue;
            pFieldItemData->SetMissionItemID(nMissionItemID);            
        }
        
        NSArray *pStates = [pFieldItem elementsForName:@"STATE"];
        for(GDataXMLElement *pState in pStates)
        {
            NSString *pValue = [[(GDataXMLNode *)[pState attributeForName:@"value"] stringValue] retain];                
            NSString *pID = [[(GDataXMLNode *)[pState attributeForName:@"id"] stringValue] retain];
            int nCategory = [(GDataXMLNode *)[pState attributeForName:@"category"] stringValue].intValue;
            
            pFieldItemData->AddStateData(pID,nCategory,pValue);
        }
        
        m_pFieldItemDataManager->AddFieldItemData(pFieldItemData);
    }
    
    [doc release];
    //[xmlData release];
}