#import "FCUIWindowDataParser.h"
#import "GDataXMLNode.h"

void FCUIWindowDataParser::Init()
{
    m_pUIWindowDataManager = new FCUIWindowDataManager;
}

FCUIWindowDataManager* FCUIWindowDataParser::GetUIWindowDataManager()
{
    
    return m_pUIWindowDataManager;
}

void FCUIWindowDataParser::LoadUIWindowData(NSString* strName)
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:strName ofType:@"xml"];    
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
                                                           options:0 error:&error];
    if (doc == nil) 
    { 
        return; 
    }
    
    NSArray *pUIWindows = [doc.rootElement elementsForName:@"Window"];
    for (GDataXMLElement *pUIWindow in pUIWindows) 
    {
        FCUIWindowData* pUIWindowData = new FCUIWindowData;
        //name
        NSArray *names = [pUIWindow elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pUIWindowData->SetName(strName);
        }
        
        NSArray *pControls = [pUIWindow elementsForName:@"CONTROL"];
        for(GDataXMLElement *pControl in pControls)
        {            
            NSString *pID = [[(GDataXMLNode *)[pControl attributeForName:@"id"] stringValue] retain];
            NSString *pType = [[(GDataXMLNode *)[pControl attributeForName:@"type"] stringValue] retain];
            NSString *pShowEvent = [[(GDataXMLNode *)[pControl attributeForName:@"show_event"] stringValue] retain];
            NSString *pClickEvent = [[(GDataXMLNode *)[pControl attributeForName:@"click_event"] stringValue] retain];
            
            int nX = [(GDataXMLNode *)[pControl attributeForName:@"x"] stringValue].intValue;
            int nY = [(GDataXMLNode *)[pControl attributeForName:@"y"] stringValue].intValue;
            int nZ = [(GDataXMLNode *)[pControl attributeForName:@"z"] stringValue].intValue;
            
            float fAnchorX = [(GDataXMLNode *)[pControl attributeForName:@"anchor_x"] stringValue].floatValue;
            float fAnchorY = [(GDataXMLNode *)[pControl attributeForName:@"anchor_y"] stringValue].floatValue;
            
            if([pType isEqualToString:@"sprite"])
            {
                NSString *pImg1 = [[(GDataXMLNode *)[pControl attributeForName:@"img1"] stringValue] retain];
                NSString *pImg2 = [[(GDataXMLNode *)[pControl attributeForName:@"img2"] stringValue] retain];
                
                int nU      = [(GDataXMLNode *)[pControl attributeForName:@"u"] stringValue].intValue;
                int nV      = [(GDataXMLNode *)[pControl attributeForName:@"v"] stringValue].intValue;
                int nWidth  = [(GDataXMLNode *)[pControl attributeForName:@"width"] stringValue].intValue;
                int nHeight = [(GDataXMLNode *)[pControl attributeForName:@"height"] stringValue].intValue;
                
                FCUIControlData* pUIControlData = pUIWindowData->AddUIControlData(pID);
                
                pUIControlData->SetType(pType);
                pUIControlData->SetImg1(pImg1);
                pUIControlData->SetImg2(pImg2);
                pUIControlData->SetX(nX);
                pUIControlData->SetY(nY);
                pUIControlData->SetZ(nZ);
                pUIControlData->SetU(nU);
                pUIControlData->SetV(nV);
                pUIControlData->SetWidth(nWidth);
                pUIControlData->SetHeight(nHeight);
                pUIControlData->SetAnchorX(fAnchorX);
                pUIControlData->SetAnchorY(fAnchorY);
                pUIControlData->SetShowEvent(pShowEvent);
                pUIControlData->SetClickEvent(pClickEvent);
            }
            else if([pType isEqualToString:@"label"])
            {                
                int nR = [(GDataXMLNode *)[pControl attributeForName:@"r"] stringValue].intValue;
                int nG = [(GDataXMLNode *)[pControl attributeForName:@"g"] stringValue].intValue;
                int nB = [(GDataXMLNode *)[pControl attributeForName:@"b"] stringValue].intValue;

                NSString *pFntFile = [[(GDataXMLNode *)[pControl attributeForName:@"fnt_file"] stringValue] retain];
                NSString *pDefault = [[(GDataXMLNode *)[pControl attributeForName:@"default"] stringValue] retain];
                                
                FCUIControlData* pUIControlData = pUIWindowData->AddUIControlData(pID);
                
                pUIControlData->SetType(pType);
                pUIControlData->SetX(nX);
                pUIControlData->SetY(nY);
                pUIControlData->SetZ(nZ);
                pUIControlData->SetFntFile(pFntFile);
                pUIControlData->SetDefault(pDefault);
                pUIControlData->SetAnchorX(fAnchorX);
                pUIControlData->SetAnchorY(fAnchorY);
                pUIControlData->SetR(nR);
                pUIControlData->SetG(nG);
                pUIControlData->SetB(nB);
                pUIControlData->SetShowEvent(pShowEvent);
                pUIControlData->SetClickEvent(pClickEvent);
            }
            else if([pType isEqualToString:@"button"])
            {
                NSString *pImg1 = [[(GDataXMLNode *)[pControl attributeForName:@"img1"] stringValue] retain];
                NSString *pImg2 = [[(GDataXMLNode *)[pControl attributeForName:@"img2"] stringValue] retain];
                NSString* pImg3 = [[(GDataXMLNode *)[pControl attributeForName:@"img3"] stringValue] retain];

                FCUIControlData* pUIControlData = pUIWindowData->AddUIControlData(pID);
                pUIControlData->SetType(pType);
                pUIControlData->SetX(nX);
                pUIControlData->SetY(nY);
                pUIControlData->SetZ(nZ);
                                
                pUIControlData->SetAnchorX(fAnchorX);
                pUIControlData->SetAnchorY(fAnchorY);
                pUIControlData->SetImg1(pImg1);
                pUIControlData->SetImg2(pImg2);
                pUIControlData->SetImg3(pImg3);
                pUIControlData->SetShowEvent(pShowEvent);
                pUIControlData->SetClickEvent(pClickEvent);
            }
            else if([pType isEqualToString:@"check_button"])
            {
                NSString *pImg1 = [[(GDataXMLNode *)[pControl attributeForName:@"img1"] stringValue] retain];
                NSString *pImg2 = [[(GDataXMLNode *)[pControl attributeForName:@"img2"] stringValue] retain];
                
                FCUIControlData* pUIControlData = pUIWindowData->AddUIControlData(pID);
                pUIControlData->SetType(pType);
                pUIControlData->SetX(nX);
                pUIControlData->SetY(nY);
                pUIControlData->SetZ(nZ);
                
                pUIControlData->SetAnchorX(fAnchorX);
                pUIControlData->SetAnchorY(fAnchorY);
                pUIControlData->SetImg1(pImg1);
                pUIControlData->SetImg2(pImg2);
                pUIControlData->SetShowEvent(pShowEvent);
                pUIControlData->SetClickEvent(pClickEvent);
            }
        }
        
        m_pUIWindowDataManager->AddUIWindowData(pUIWindowData);
    }
    
    [doc release];
    [xmlData release];
}