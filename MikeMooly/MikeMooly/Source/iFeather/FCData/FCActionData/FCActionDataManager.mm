 #import "FCActionDataManager.h"

void FCActionDataManager::AddActionData(FCActionData* pActionData)
{
    std::map<NSInteger,FCActionData*>::iterator it = m_hashActionData.find(pActionData->GetName().hash);
    if(it == m_hashActionData.end())
    {
        m_hashActionData.insert(std::make_pair(pActionData->GetName().hash,pActionData));
        return;
    }
    
    FCActionData *pLocalActionData = (*it).second;
    pLocalActionData->Copy(pActionData);
}


FCActionData* FCActionDataManager::GetActionData(NSString* pName)
{  
    std::map<NSInteger,FCActionData*>::iterator it = m_hashActionData.find(pName.hash);
    if(it == m_hashActionData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

id FCActionDataManager::GetActionElement(FCActionElementSequenceData* pActionElementSequenceData)
{
    FCActionElementDataManager* pActionElementDataManager = pActionElementSequenceData->GetACtionElementDataManager();
    NSMutableArray *aSpawn = [[NSMutableArray alloc] init];
    
    std::vector<FCActionElementData*>* pActionElementData = pActionElementDataManager->GetActionElementDataVector();
    std::vector<FCActionElementData*>::iterator it = pActionElementData->begin();
    for(;it != pActionElementData->end(); ++it)
    {
        FCActionElementData* pActionElementData = (*it);
        const float fDuration = pActionElementData->GetDuration();
        const int nX = pActionElementData->GetX();
        const int nY = pActionElementData->GetY();
        const float fAngle = pActionElementData->GetAngle();
        const float fSkewX = pActionElementData->GetSkewX();
        const float fSkewY = pActionElementData->GetSkewY();
        const float fScaleX = pActionElementData->GetScaleX();
        const float fScaleY = pActionElementData->GetScaleY();
        const float fHeight = pActionElementData->GetHeight();
        const int nJump = pActionElementData->GetJumps();
        const int nR = pActionElementData->GetR();
        const int nG = pActionElementData->GetG();
        const int nB = pActionElementData->GetB();
        const int nBlinks = pActionElementData->GetBlinks();
        const int nCount = pActionElementData->GetCount();
        NSString* strFileName = pActionElementData->GetFileName();
        
        CGPoint position = ccp(nX,nY);
        
        if([pActionElementData->GetType() isEqualToString:@"CCMoveTo"])
        {
            id action = [CCMoveTo actionWithDuration:fDuration position:position];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCMoveBy"])
        {
            id action = [CCMoveBy actionWithDuration:fDuration position:position];
            [aSpawn addObject:action];            
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCRotateTo"])
        {
            id action = [CCRotateTo actionWithDuration:fDuration angle:fAngle];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCRotateBy"])
        {
            id action = [CCRotateBy actionWithDuration:fDuration angle:fAngle];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCSkewTo"])
        {
            id action = [CCSkewTo actionWithDuration:fDuration skewX:fSkewX skewY:fSkewY];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCSkewBy"])
        {
            id action = [CCSkewBy actionWithDuration:fDuration skewX:fSkewX skewY:fSkewY];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCScaleTo"])
        {
            id action = [CCScaleTo actionWithDuration:fDuration scaleX:fScaleX scaleY:fScaleY];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCScaleBy"])
        {
            id action = [CCScaleBy actionWithDuration:fDuration scaleX:fScaleX scaleY:fScaleY];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCJumpTo"])
        {
            id action = [CCJumpTo actionWithDuration:fDuration position:ccp(nX,nY) height:fHeight jumps:nJump];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCJumpBy"])
        {
            id action = [CCJumpBy actionWithDuration:fDuration position:ccp(nX,nY) height:fHeight jumps:nJump];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCTintTo"])
        {
            id action = [CCTintTo actionWithDuration:fDuration red:nR green:nG blue:nB];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCTintBy"])
        {
            id action = [CCTintBy actionWithDuration:fDuration red:nR green:nG blue:nB];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCBlink"])
        {
            id action = [CCBlink actionWithDuration:fDuration blinks:nBlinks];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCFadeIn"])
        {
            id action = [CCFadeIn actionWithDuration:fDuration];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCFadeOut"])
        {
            id action = [CCFadeOut actionWithDuration:fDuration];
            [aSpawn addObject:action];
        }
        else if([pActionElementData->GetType() isEqualToString:@"CCAnimation"])
        {
            CCAnimation *animation = [[CCAnimation alloc]init];
            [animation setDelay:fDuration];
            
            for (int i=0; i<nCount; i++) 
            {
                [animation addFrameWithFilename:[NSString stringWithFormat:strFileName,i]];
            }
            
            id action = [CCAnimate actionWithAnimation:animation];
            [aSpawn addObject:action];
        }
    }
    
    if(aSpawn.count == 0)
        return NULL;
    
    id spawn = [CCSpawn actionsWithArray:aSpawn];
    //id repeat = [CCRepeat actionWithAction:spawn times:10];
    return spawn;
}


id FCActionDataManager::GetActionSequence(NSString * pName)
{
    std::map<NSInteger,FCActionData*>::iterator it = m_hashActionData.find(pName.hash);
    if(it == m_hashActionData.end())
    {
        return NULL;
    }
    
    NSMutableArray *aSequenece = [[NSMutableArray alloc] init];
    FCActionData* pActionData = (*it).second;
    std::vector<FCActionElementSequenceData*>* pActinoElementSequenceData = pActionData->GetActionElementSequenceDataVector();
    std::vector<FCActionElementSequenceData*>::iterator it_action_sequence_element = pActinoElementSequenceData->begin();
    for(;it_action_sequence_element != pActinoElementSequenceData->end();++it_action_sequence_element)
    {
        FCActionElementSequenceData* pActionElementSequenceData = (*it_action_sequence_element);
        id pActionElment = GetActionElement(pActionElementSequenceData);
        
        if(pActionElment)
        {
            [aSequenece addObject:pActionElment];
        }
    }
    
    if(aSequenece.count == 0)
        return NULL;
    
    id sequence = [CCSequence actionsWithArray:aSequenece];
    
    const int nRepeat = pActionData->GetRepeat();
    if(nRepeat == -1)
    {
        //-1 일때 RepeatForever
        id repeat = [CCRepeatForever actionWithAction:sequence];
        return repeat;
    }
    else if(nRepeat > 0)
    {
        //0 아닐떄 Repeat
        id repeat = [CCRepeat actionWithAction:sequence times:nRepeat];
        return repeat;
    }
    
    return sequence;
}
