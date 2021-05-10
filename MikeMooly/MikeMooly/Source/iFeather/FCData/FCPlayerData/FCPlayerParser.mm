#import "FCPlayerParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCPlayerParser::Init()
{
    m_pPlayerDataManager = new FCPlayerDataManager;
}

NSString* FCPlayerParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"Player" ofType:@"xml"];
}

FCPlayerDataManager* FCPlayerParser::GetPlayerDataManager()
{
    return m_pPlayerDataManager;
}

void FCPlayerParser::LoadPlayerData()
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
    
    NSArray *pPlayers = [doc.rootElement elementsForName:@"Player"];
    for (GDataXMLElement *pPlayer in pPlayers) 
    {
        FCPlayerData* pPlayerData = new FCPlayerData;
        //name
        NSArray *names = [pPlayer elementsForName:@"Name"];
        if (names.count > 0) 
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pPlayerData->SetName(strName);
        }
        
        NSArray * pWalkSpeed = [pPlayer elementsForName:@"WALK_SPEED"];
        if(pWalkSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pWalkSpeed objectAtIndex:0];
            float fWalkSpeed = pVaue.stringValue.intValue;
            pPlayerData->SetWalkSpeed(fWalkSpeed);
        }
        
        NSArray * pWalkMoveSpeed = [pPlayer elementsForName:@"JUMP_MOVE_SPEED"];
        if(pWalkMoveSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pWalkMoveSpeed objectAtIndex:0];
            float fJumpMoveSpeed = pVaue.stringValue.intValue;
            pPlayerData->SetJumpMoveSpeed(fJumpMoveSpeed);
        }
        
        NSArray * pJumpSpeed = [pPlayer elementsForName:@"JUMP_SPEED"];
        if(pJumpSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pJumpSpeed objectAtIndex:0];
            float fJumpSpeed = pVaue.stringValue.intValue;
            pPlayerData->SetJumpSpeed(fJumpSpeed);
        }
        
        NSArray * pJump2Speed = [pPlayer elementsForName:@"JUMP2_SPEED"];
        if(pJump2Speed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pJump2Speed objectAtIndex:0];
            float fJump2Speed = pVaue.stringValue.intValue;
            pPlayerData->SetJump2Speed(fJump2Speed);
        }
        
        NSArray * pJumpMaxCount = [pPlayer elementsForName:@"JUMP_MAX_COUNT"];
        if(pJumpMaxCount.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pJumpMaxCount objectAtIndex:0];
            int nJumpMaxCount = pVaue.stringValue.intValue;
            pPlayerData->SetJumpMaxCount(nJumpMaxCount);
        }
        
        NSArray * pDeathTime = [pPlayer elementsForName:@"DEATH_TIME"];
        if(pDeathTime.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pDeathTime objectAtIndex:0];
            float fDeathTime = pVaue.stringValue.intValue;
            pPlayerData->SetDeathTime(fDeathTime);
        }
        
        NSArray * pBounceSpeed = [pPlayer elementsForName:@"BOUNCE_SPEED"];
        if(pBounceSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pBounceSpeed objectAtIndex:0];
            float fBounceSpeed = pVaue.stringValue.intValue;
            pPlayerData->SetBounceSpeed(fBounceSpeed);
        }
        
        NSArray * pDamageBounceSpeed = [pPlayer elementsForName:@"DAMAGE_BOUNCE_SPEED"];
        if(pDamageBounceSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pDamageBounceSpeed objectAtIndex:0];
            float fDamageBounceSpeed = pVaue.stringValue.intValue;
            pPlayerData->SetDamageBounceSpeed(fDamageBounceSpeed);
        }
        
        NSArray *pStates = [pPlayer elementsForName:@"STATE"];
        for(GDataXMLElement *pState in pStates)
        {
            NSString *pValue = [[(GDataXMLNode *)[pState attributeForName:@"value"] stringValue] retain];                
            NSString *pID = [[(GDataXMLNode *)[pState attributeForName:@"id"] stringValue] retain];
            int nCategory = [(GDataXMLNode *)[pState attributeForName:@"category"] stringValue].intValue;
            
            pPlayerData->AddStateData(pID,nCategory,pValue);
        }
        
        m_pPlayerDataManager->AddPlayerData(pPlayerData);
    }
    
    [doc release];
    //[xmlData release];
}