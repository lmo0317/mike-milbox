#import "FCEnemyParser.h"
#import "GDataXMLNode.h"
#import "FCEncryption.h"
#import "AppDelegate.h"

void FCEnemyParser::Init()
{
    m_pEnemyDataManager = new FCEnemyDataManager;
}

NSString* FCEnemyParser::dataFilePath()
{
    return [[NSBundle mainBundle] pathForResource:@"EnemyTemplate" ofType:@"xml"];
}

FCEnemyDataManager* FCEnemyParser::GetEnemyDataManager()
{
    return m_pEnemyDataManager;
}

void FCEnemyParser::LoadEnemyData()
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
    
    NSArray *pEnemys = [doc.rootElement elementsForName:@"Enemy"];
    for (GDataXMLElement *pEnemy in pEnemys) 
    {
        FCEnemyData* pEnemyData = new FCEnemyData;
        //name
        NSArray *names = [pEnemy elementsForName:@"Name"];
        if (names.count > 0)  
        {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",firstName.stringValue] retain];
            pEnemyData->SetName(strName);
        }
        
        NSArray* pAIName = [pEnemy elementsForName:@"AI_NAME"];
        if(pAIName.count >0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pAIName objectAtIndex:0];
            NSString * strName = [[NSString stringWithFormat:@"%@",pVaue.stringValue] retain];
            pEnemyData->SetAIName(strName);
        }
        
        NSArray * pHP = [pEnemy elementsForName:@"HP"];
        if(pHP.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pHP objectAtIndex:0];
            int nHP = pVaue.stringValue.intValue;
            pEnemyData->SetHP(nHP);
        }
        
        NSArray * pWalkSpeed = [pEnemy elementsForName:@"WALK_SPEED"];
        if(pWalkSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pWalkSpeed objectAtIndex:0];
            float fWalkSpeed = pVaue.stringValue.intValue;
            pEnemyData->SetWalkSpeed(fWalkSpeed);
        }
        
        NSArray * pWalkMoveSpeed = [pEnemy elementsForName:@"JUMP_MOVE_SPEED"];
        if(pWalkMoveSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pWalkMoveSpeed objectAtIndex:0];
            float fJumpMoveSpeed = pVaue.stringValue.intValue;
            pEnemyData->SetJumpMoveSpeed(fJumpMoveSpeed);
        }
        
        NSArray * pJumpSpeed = [pEnemy elementsForName:@"JUMP_SPEED"];
        if(pJumpSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pJumpSpeed objectAtIndex:0];
            float fJumpSpeed = pVaue.stringValue.intValue;
            pEnemyData->SetJumpSpeed(fJumpSpeed);
        }
        
        NSArray * pJump2Speed = [pEnemy elementsForName:@"JUMP2_SPEED"];
        if(pJump2Speed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pJump2Speed objectAtIndex:0];
            float fJump2Speed = pVaue.stringValue.intValue;
            pEnemyData->SetJump2Speed(fJump2Speed);
        }
        
        NSArray * pBounceSpeed = [pEnemy elementsForName:@"BOUNCE_SPEED"];
        if(pBounceSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pBounceSpeed objectAtIndex:0];
            float fBounceSpeed = pVaue.stringValue.intValue;
            pEnemyData->SetBounceSpeed(fBounceSpeed);
        }
        
        NSArray * pDamageBounceSpeed = [pEnemy elementsForName:@"DAMGE_BOUNCE_SPEED"];
        if(pDamageBounceSpeed.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pDamageBounceSpeed objectAtIndex:0];
            float fDamageBounceSpeed = pVaue.stringValue.intValue;
            pEnemyData->SetDamageBounceSpeed(fDamageBounceSpeed);
        }
        
        NSArray *pStates = [pEnemy elementsForName:@"STATE"];
        for(GDataXMLElement *pState in pStates)
        {
            NSString *pValue = [[(GDataXMLNode *)[pState attributeForName:@"value"] stringValue] retain];                
            NSString *pID = [[(GDataXMLNode *)[pState attributeForName:@"id"] stringValue] retain];
            int nCategory = [(GDataXMLNode *)[pState attributeForName:@"id"] stringValue].intValue;

            pEnemyData->AddStateData(pID,nCategory,pValue);
        }
        
        NSArray * pDeath = [pEnemy elementsForName:@"DEATH"];
        if(pDeath.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pDeath objectAtIndex:0];
            int bDeath = pVaue.stringValue.intValue != 0;
            pEnemyData->SetCanDeath(bDeath);
        }
        
        NSArray * pCulling = [pEnemy elementsForName:@"CULLING"];
        if(pCulling.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pCulling objectAtIndex:0];
            int nCulling = pVaue.stringValue.intValue;
            pEnemyData->SetCulling(nCulling);
        }
        
        NSArray * pScore = [pEnemy elementsForName:@"SCORE"];
        if(pScore.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pScore objectAtIndex:0];
            int nScore = pVaue.stringValue.intValue;
            pEnemyData->SetScore(nScore);
            
            //CCLOG(@"SCORE = [%d]",nScore);
        }
        
        NSArray * pDamageSensor = [pEnemy elementsForName:@"DAMAGE_SENSOR"];
        if(pDamageSensor.count > 0)
        {
            GDataXMLElement *pVaue = (GDataXMLElement *) [pDamageSensor objectAtIndex:0];
            int bDamageSensor = pVaue.stringValue.intValue != 0;
            pEnemyData->SetDamageSensor(bDamageSensor);
        }
        
        m_pEnemyDataManager->AddEnemyData(pEnemyData);
    }
    
    [doc release];
    //[xmlData release];
}