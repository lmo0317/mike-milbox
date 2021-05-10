#import "FCAIParser.h"
#import "GDataXMLNode.h"
#import "AppDelegate.h"
#import "FCEncryption.h"

void FCAIParser::Init()
{
    m_pAIDataManager = new FCAIDataManager;
}

NSString* FCAIParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"AITemplate" ofType:@"xml"];
}

FCAIDataManager* FCAIParser::GetAIDataManager()
{
    return m_pAIDataManager;
}

void FCAIParser::LoadAIData()
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
    
    NSArray *pAIs = [doc.rootElement elementsForName:@"AI"];
    for (GDataXMLElement *pAI in pAIs) 
    {
        FCAIData* pAIData = new FCAIData;
        //name
        NSArray *names = [pAI elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pAIData->SetName(strName);
        }
        
        NSArray *pBanister = [pAI elementsForName:@"BANISTER"];
        if (pBanister.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pBanister objectAtIndex:0];
            bool bValue = [(GDataXMLNode *)[pValue attributeForName:@"value"] stringValue].intValue != 0;     
            pAIData->SetBanister(bValue);
        }
        
        NSArray *pStates = [pAI elementsForName:@"STATE"];
        for(GDataXMLElement *pState in pStates)
        {
            NSString *pID = [[(GDataXMLNode *)[pState attributeForName:@"id"] stringValue] retain];
            float fProbability = [(GDataXMLNode *)[pState attributeForName:@"probability"] stringValue].floatValue;                
            float fTime = [(GDataXMLNode *)[pState attributeForName:@"duration"] stringValue].floatValue;
            bool bPrefix = [(GDataXMLNode *)[pState attributeForName:@"prefix"] stringValue].intValue != 0;
            
            pAIData->AddStateData(pID,fProbability,fTime,bPrefix);
        }

        
        m_pAIDataManager->AddAIData(pAIData);
    }
    
    [doc release];
    //[xmlData release];
}