//
//  MyLevelHelperLoader.m
//  MIKE
//
//  Created by 이민오 on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyLevelHelperLoader.h"


@implementation MyLevelHelperLoader

////////////////////////////////////////////////////////////////////////////////
-(void) mystartAnimationWithUniqueName:(NSString *)animName onSprite:(LHSprite*)ccsprite animationInfo:(AnimationInfo&) aniInfo
{
    for(NSDictionary* anim in lhAnims)
    {
        NSString* uniqueAnimName = [anim objectForKey:@"UniqueName"];
        if([animName isEqualToString:uniqueAnimName])
        {
            bool loop = [[anim objectForKey:@"LoopForever"] boolValue];
            float animSpeed = [[anim objectForKey:@"Speed"] floatValue];
            int repetitions = [[anim objectForKey:@"Repetitions"] intValue];
            NSArray* framesInfo = [anim objectForKey:@"Frames"];
            
            aniInfo.bLoop = loop;
            aniInfo.fSpeed = animSpeed;
            aniInfo.nRepetitions = repetitions;
            aniInfo.nFrame = [framesInfo count];
        }
    }
    
    [ccsprite startAnimationNamed:animName];
    //[self startAnimationWithUniqueName:animName onSprite:ccsprite];
}

-(bool) getAnimationInfoLoop:(NSString*)animName onSprite:(LHSprite*)ccsprite
{
    for(NSDictionary* anim in lhAnims)
    {
        NSString* uniqueAnimName = [anim objectForKey:@"UniqueName"];
        if([animName isEqualToString:uniqueAnimName])
        {
            return [[anim objectForKey:@"LoopForever"] boolValue];
        }
    }

    return false;
}

-(float) getAnimationInfoAnimSpeed:(NSString*)animName onSprite:(LHSprite*)ccsprite
{
    for(NSDictionary* anim in lhAnims)
    {
        NSString* uniqueAnimName = [anim objectForKey:@"UniqueName"];
        if([animName isEqualToString:uniqueAnimName])
        {
            return [[anim objectForKey:@"Speed"] floatValue];
        }
    }
    
    return 0.f;
}


-(int) getAnimationInfoRepetitions:(NSString*)animName onSprite:(LHSprite*)ccsprite
{
    for(NSDictionary* anim in lhAnims)
    {
        NSString* uniqueAnimName = [anim objectForKey:@"UniqueName"];
        if([animName isEqualToString:uniqueAnimName])
        {
            return [[anim objectForKey:@"Repetitions"] intValue];
        }
    }
    
    return 0;
}

-(int) getAnimationInfoFrame:(NSString*)animName onSprite:(LHSprite*)ccsprite
{
    for(NSDictionary* anim in lhAnims)
    {
        NSString* uniqueAnimName = [anim objectForKey:@"UniqueName"];
        if([animName isEqualToString:uniqueAnimName])
        {
             NSArray* framesInfo = [anim objectForKey:@"Frames"];
            return [framesInfo count];
        }
    }
    
    return 0;
}

-(NSMutableDictionary*)GetSpriteInLevel
{
    return spritesInLevel;
}

-(NSMutableDictionary*)GetBeziersInLevel
{
    return beziersInLevel;
}



@end
