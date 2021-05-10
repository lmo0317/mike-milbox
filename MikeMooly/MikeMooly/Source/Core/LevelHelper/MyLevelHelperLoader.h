#import <Foundation/Foundation.h>
#import "LevelHelperLoader.h"

struct AnimationInfo
{
    int nFrame;
    int nRepetitions;
    float fSpeed;
    bool bLoop;
};

@interface MyLevelHelperLoader : LevelHelperLoader {
    
}

-(void) mystartAnimationWithUniqueName:(NSString *)animName onSprite:(LHSprite*)ccsprite animationInfo:(AnimationInfo&) aniInfo;
-(bool) getAnimationInfoLoop:(NSString*)animName onSprite:(LHSprite*)ccsprite;

-(int) getAnimationInfoFrame:(NSString*)animName onSprite:(LHSprite*)ccsprite;
-(int) getAnimationInfoRepetitions:(NSString*)animName onSprite:(LHSprite*)ccsprite;
-(float) getAnimationInfoAnimSpeed:(NSString*)animName onSprite:(LHSprite*)ccsprite;
-(bool) getAnimationInfoLoop:(NSString*)animName onSprite:(LHSprite*)ccsprite;
-(NSMutableDictionary*) GetSpriteInLevel;
-(NSMutableDictionary*) GetBeziersInLevel;
@end
