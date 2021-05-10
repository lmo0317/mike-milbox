#import "FCOptionDataParser.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCOptionDataParser::Init()
{
    m_pOptionDataManager = new FCOptionDataManager;
}


NSString * FCOptionDataParser::dataFilePath(bool forSave)
{    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory
                               stringByAppendingPathComponent:@"OptionDataTemplate.xml"];
    if (forSave || 
        [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) 
    {
        return documentsPath;
    }
    else 
    {
        return [[NSBundle mainBundle] pathForResource:@"OptionDataTemplate" ofType:@"xml"];
    }
}
    

FCOptionDataManager* FCOptionDataParser::GetOptionDataManager()
{
    
    return m_pOptionDataManager;
}

void FCOptionDataParser::LoadOptionData()
{
    NSString *filePath = dataFilePath(false);
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
    
    
    NSArray *pOptions = [doc.rootElement elementsForName:@"OPTION_DATA"];
    for (GDataXMLElement *pOtion in pOptions) 
    {
        FCOptionData* pOptionData = new FCOptionData;
        //name
        NSArray *names = [pOtion elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pOptionData->SetName(strName);
        }
        
        NSArray *pBgm = [pOtion elementsForName:@"BGM"];
        if (pBgm.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pBgm objectAtIndex:0];
            const bool bBgm = pValue.stringValue.intValue != 0;
            pOptionData->SetBGM(bBgm);
        }
        
        NSArray *pFx = [pOtion elementsForName:@"FX"];
        if (pFx.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pFx objectAtIndex:0];
            const bool bFx = pValue.stringValue.intValue != 0;
            pOptionData->SetFX(bFx);
        }
        
        NSArray *pControl = [pOtion elementsForName:@"CONTROL"];
        if (pControl.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pControl objectAtIndex:0];
            const int nControl = pValue.stringValue.intValue;
            pOptionData->SetControl(nControl);
        }
        
        m_pOptionDataManager->AddOptionData(pOptionData);
    }
    
    [doc release];
    //[xmlData release];
}

void FCOptionDataParser::SaveDataElement(FCOptionData* pOptionData,GDataXMLElement * pOptionDataTemplate)
{
    GDataXMLElement * pOption = [GDataXMLNode elementWithName:@"OPTION_DATA"];
    
    GDataXMLElement * nameElement = [GDataXMLNode elementWithName:@"Name" stringValue:pOptionData->GetName()];
    
    GDataXMLElement * BGMlement = [GDataXMLNode elementWithName:@"BGM" 
                                                      stringValue:[NSString stringWithFormat:@"%d",pOptionData->GetBGM()]];
    
    GDataXMLElement * FXElement = [GDataXMLNode elementWithName:@"FX" 
                                                      stringValue:[NSString stringWithFormat:@"%d",pOptionData->GetFX()]];
    
    GDataXMLElement * ControlElement = [GDataXMLNode elementWithName:@"CONTROL" 
                                                      stringValue:[NSString stringWithFormat:@"%d",pOptionData->GetControl()]];
    
 
    
    [pOption addChild:nameElement];
    [pOption addChild:BGMlement];
    [pOption addChild:FXElement];
    [pOption addChild:ControlElement];
    
    [pOptionDataTemplate addChild:pOption];    
}

void FCOptionDataParser::SaveOptionData()
{
    GDataXMLElement * pOptionDataTemplate = [GDataXMLNode elementWithName:@"OptionDataTemplate"];
    
    std::map<NSInteger ,FCOptionData*>* mapOptionData = m_pOptionDataManager->GetOptionDataMap();
    std::map<NSInteger ,FCOptionData*>::iterator it_option_data = mapOptionData->begin();
    for(;it_option_data != mapOptionData->end();++it_option_data)
    {
        FCOptionData* pOptionData = it_option_data->second;
        SaveDataElement(pOptionData,pOptionDataTemplate);
    }
    
    GDataXMLDocument *document = [[[GDataXMLDocument alloc] initWithRootElement:pOptionDataTemplate] autorelease];
    NSData *xmlData = document.XMLData;
    NSString *filePath = dataFilePath(true);
    NSLog(@"Saving xml data to %@...", filePath);
    
    //encrypt-----------------------------------------------------------------------------------------------------------
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCEncryption* pEncryption = [appDelegate GetEncryption];
    xmlData = [pEncryption encryptDES:xmlData];
    [xmlData writeToFile:filePath atomically:YES];
    //---------------------------------------------------------------------------------------------------------------------
}