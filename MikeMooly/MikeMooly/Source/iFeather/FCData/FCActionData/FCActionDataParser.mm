#import "FCActionDataParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCActionDataParser::Init()
{
    m_pActionDataManager = new FCActionDataManager;
}

NSString* FCActionDataParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"ActionDataTemplate" ofType:@"xml"];
                                                    
}

FCActionDataManager* FCActionDataParser::GetActionDataManager()
{
    
    return m_pActionDataManager;
}

void FCActionDataParser::LoadActionData()
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
    
    
    NSArray *pActions = [doc.rootElement elementsForName:@"ACTION_DATA"];
    for (GDataXMLElement *pAction in pActions) 
    {
        FCActionData* pActionData = new FCActionData;
        //name
        NSArray *names = [pAction elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pActionData->SetName(strName);
        }
        
        NSArray *pRepeats = [pAction elementsForName:@"Repeat"];
        if (pRepeats.count > 0) 
        {
            GDataXMLElement *pValue = (GDataXMLElement *) [pRepeats objectAtIndex:0];
            const int nRepeat = pValue.stringValue.intValue;
            pActionData->SetRepeat(nRepeat);
        }
        
        NSArray * pSequences = [pAction elementsForName:@"SEQUENCE"];
        {
            for(GDataXMLElement *pSequence in pSequences)
            {
                FCActionElementSequenceData* pActionElementSequenceData = pActionData->AddActionElementSequenceData();
                FCActionElementDataManager* pActionElementDataManager = pActionElementSequenceData->GetACtionElementDataManager();
                
                NSArray *pActions = [pSequence elementsForName:@"ACTION"];
                for(GDataXMLElement *pAction in pActions)
                {
                    //NSString *pID = [[(GDataXMLNode *)[pControl attributeForName:@"id"] stringValue] retain];
                    FCActionElementData* pActionElementData = pActionElementDataManager->AddActionElementData();
                    
                    NSString *pType = [[(GDataXMLNode *)[pAction attributeForName:@"type"] stringValue] retain];
                    const float fDuration = [(GDataXMLNode *)[pAction attributeForName:@"duration"] stringValue].floatValue;
                    
                    pActionElementData->SetType(pType);
                    pActionElementData->SetDuration(fDuration);
                    
                    if([pType isEqualToString:@"CCMoveTo"])
                    {
                        int nX = [(GDataXMLNode *)[pAction attributeForName:@"x"] stringValue].intValue;
                        int nY = [(GDataXMLNode *)[pAction attributeForName:@"y"] stringValue].intValue;
                        
                        pActionElementData->SetX(nX);
                        pActionElementData->SetY(nY);
                    }
                    else if([pType isEqualToString:@"CCMoveBy"])
                    {
                        int nX = [(GDataXMLNode *)[pAction attributeForName:@"x"] stringValue].intValue;
                        int nY = [(GDataXMLNode *)[pAction attributeForName:@"y"] stringValue].intValue;
                        
                        pActionElementData->SetX(nX);
                        pActionElementData->SetY(nY);
                    }
                    else if([pType isEqualToString:@"CCRotateTo"])
                    {
                        int fAngle = [(GDataXMLNode *)[pAction attributeForName:@"angle"] stringValue].floatValue;
                        
                        pActionElementData->SetAngle(fAngle);
                    }
                    else if([pType isEqualToString:@"CCRotateBy"])
                    {
                        int fAngle = [(GDataXMLNode *)[pAction attributeForName:@"angle"] stringValue].floatValue;
                        
                        pActionElementData->SetAngle(fAngle);
                    }
                    else if([pType isEqualToString:@"CCSkewTo"])
                    {
                        float fSkewX = [(GDataXMLNode *)[pAction attributeForName:@"skew_x"] stringValue].floatValue;
                        float fSkewY = [(GDataXMLNode *)[pAction attributeForName:@"skew_y"] stringValue].floatValue;
                        
                        pActionElementData->SetSkewX(fSkewX);
                        pActionElementData->SetSkewY(fSkewY);
                    }
                    else if([pType isEqualToString:@"CCSkewBy"])
                    {
                        float fSkewX = [(GDataXMLNode *)[pAction attributeForName:@"skew_x"] stringValue].floatValue;
                        float fSkewY = [(GDataXMLNode *)[pAction attributeForName:@"skew_y"] stringValue].floatValue;
                        
                        pActionElementData->SetSkewX(fSkewX);
                        pActionElementData->SetSkewY(fSkewY);
                    }
                    else if([pType isEqualToString:@"CCScaleTo"])
                    {
                        float fScaleX = [(GDataXMLNode *)[pAction attributeForName:@"scale_x"] stringValue].floatValue;
                        float fScaleY = [(GDataXMLNode *)[pAction attributeForName:@"scale_y"] stringValue].floatValue;
                        
                        pActionElementData->SetScaleX(fScaleX);
                        pActionElementData->SetScaleY(fScaleY);
                    }
                    else if([pType isEqualToString:@"CCScaleBy"])
                    {
                        float fScaleX = [(GDataXMLNode *)[pAction attributeForName:@"scale_x"] stringValue].floatValue;
                        float fScaleY = [(GDataXMLNode *)[pAction attributeForName:@"scale_y"] stringValue].floatValue;
                        
                        pActionElementData->SetScaleX(fScaleX);
                        pActionElementData->SetScaleY(fScaleY);
                    }
                    else if([pType isEqualToString:@"CCJumpTo"])
                    {
                        float fHeight = [(GDataXMLNode *)[pAction attributeForName:@"height"] stringValue].floatValue;
                        int nJumps = [(GDataXMLNode *)[pAction attributeForName:@"jumps"] stringValue].intValue;
                        
                        pActionElementData->SetHeight(fHeight);
                        pActionElementData->SetJumps(nJumps);
                    }
                    else if([pType isEqualToString:@"CCJumpBy"])
                    {
                        float fHeight = [(GDataXMLNode *)[pAction attributeForName:@"height"] stringValue].floatValue;
                        int nJumps = [(GDataXMLNode *)[pAction attributeForName:@"jumps"] stringValue].intValue;
                        
                        pActionElementData->SetHeight(fHeight);
                        pActionElementData->SetJumps(nJumps);
                    }
                    else if([pType isEqualToString:@"CCTintTo"])
                    {
                        int nR = [(GDataXMLNode *)[pAction attributeForName:@"r"] stringValue].intValue;
                        int nG = [(GDataXMLNode *)[pAction attributeForName:@"g"] stringValue].intValue;
                        int nB = [(GDataXMLNode *)[pAction attributeForName:@"b"] stringValue].intValue;
                        
                        pActionElementData->SetR(nR);
                        pActionElementData->SetG(nG);
                        pActionElementData->SetB(nB);
                    }
                    else if([pType isEqualToString:@"CCTintBy"])
                    {
                        int nR = [(GDataXMLNode *)[pAction attributeForName:@"r"] stringValue].intValue;
                        int nG = [(GDataXMLNode *)[pAction attributeForName:@"g"] stringValue].intValue;
                        int nB = [(GDataXMLNode *)[pAction attributeForName:@"b"] stringValue].intValue;
                        
                        pActionElementData->SetR(nR);
                        pActionElementData->SetG(nG);
                        pActionElementData->SetB(nB);
                    }
                    else if([pType isEqualToString:@"CCBlink"])
                    {
                        int nBlinks = [(GDataXMLNode *)[pAction attributeForName:@"blinks"] stringValue].intValue;
                        
                        pActionElementData->SetBlinks(nBlinks);
                    }
                    else if([pType isEqualToString:@"CCFadeIn"])
                    {
                        
                    }
                    else if([pType isEqualToString:@"CCFadeOut"])
                    {
                        
                    }
                    else if([pType isEqualToString:@"CCAnimation"])
                    {
                        int nCount = [(GDataXMLNode *)[pAction attributeForName:@"count"] stringValue].intValue;
                        
                        NSString *pFileName = [[(GDataXMLNode *)[pAction attributeForName:@"file"] stringValue] retain];
                        pActionElementData->SetCount(nCount);
                        pActionElementData->SetFileName(pFileName);
                    }
                }
            }
        }
        
        m_pActionDataManager->AddActionData(pActionData);
    }
    
    [doc release];
    //[xmlData release];
}