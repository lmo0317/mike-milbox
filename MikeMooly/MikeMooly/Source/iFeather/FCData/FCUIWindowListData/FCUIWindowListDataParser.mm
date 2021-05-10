
#import "FCUIWindowListDataParser.h"
#import "GDataXMLNode.h"

void FCUIWindowListDataParser::Init()
{
    m_pUIWindowListDataManager = new FCUIWindowListDataManager;
}

NSString* FCUIWindowListDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"UIWindowListDataTemplate" ofType:@"xml"];
                                                    
}

FCUIWindowListDataManager* FCUIWindowListDataParser::GetUIWindowListDataManager()
{
    return m_pUIWindowListDataManager;
}

void FCUIWindowListDataParser::LoadUIWindowListData()
{
    NSString *filePath = dataFilePath();
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
                                                           options:0 error:&error];
    if (doc == nil) 
    { 
        return; 
    }

    NSArray *pUIWindowLists = [doc.rootElement elementsForName:@"WindowList"];
    for (GDataXMLElement *pUIWindowList in pUIWindowLists) 
    {
        FCUIWindowListData* pUIWindowListData = new FCUIWindowListData;
        //name
        NSArray *names = [pUIWindowList elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pUIWindowListData->SetName(strName);
        }
        
        m_pUIWindowListDataManager->AddUIWindowListData(pUIWindowListData);
    }
    
    [doc release];
    [xmlData release];
}

void FCUIWindowListDataParser::LoadUIWindowData()
{
    m_pUIWindowListDataManager->LoadUIWindowData();
}