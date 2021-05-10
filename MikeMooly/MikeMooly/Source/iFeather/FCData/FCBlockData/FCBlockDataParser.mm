#import "FCBlockDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCBlockDataParser::Init()
{
    m_pBlockDataManager = new FCBlockDataManager;
}

NSString* FCBlockDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"BlockDataTemplate" ofType:@"xml"];
                                                    
}

FCBlockDataManager* FCBlockDataParser::GetBlockDataManager()
{
    
    return m_pBlockDataManager;
}

void FCBlockDataParser::LoadBlockData()
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
    
    
    NSArray *pBlocks = [doc.rootElement elementsForName:@"BLOCK"];
    for (GDataXMLElement *pBlock in pBlocks) 
    {
        FCBlockData* pBlockData = new FCBlockData;
        //name
        NSArray *names = [pBlock elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pBlockData->SetName(strName);
        }
        
        NSArray* pHP = [pBlock elementsForName:@"HP"];
        if(pHP.count > 0)
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pHP objectAtIndex:0];            
            int nHP = pValue.stringValue.intValue;
            pBlockData->SetHP(nHP);    
        }
        
        NSArray* pScore = [pBlock elementsForName:@"SCORE"];
        if(pScore.count > 0)
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pScore objectAtIndex:0];            
            int nScore = pValue.stringValue.intValue;
            pBlockData->SetScore(nScore);    
        }
        
        NSArray *pStates = [pBlock elementsForName:@"STATE"];
        for(GDataXMLElement *pState in pStates)
        {
            NSString *pValue = [[(GDataXMLNode *)[pState attributeForName:@"value"] stringValue] retain];                
            NSString *pID = [[(GDataXMLNode *)[pState attributeForName:@"id"] stringValue] retain];
            int nCategory = [(GDataXMLNode *)[pState attributeForName:@"category"] stringValue].intValue;
            
            pBlockData->AddStateData(pID,nCategory,pValue);
        }
        
        m_pBlockDataManager->AddBlockData(pBlockData);
    }
    
    [doc release];
    //[xmlData release];
}