#import "CCScrollMenu.h"

@implementation CCScrollMenu

-(CCMenuItem *) itemForTouch: (UITouch *) touch
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CCMenuItem* item;
    CCARRAY_FOREACH(children_, item){
        // ignore invisible and disabled items: issue #779, #866
        if ( [item visible] && [item isEnabled] ) {
            
            CGPoint local = [item convertToNodeSpace:touchLocation];
            local = ccpAdd([self parent].position, local); // to account for parent position <------ key
            
            CGRect r = [item rect];
            r.origin = CGPointZero;
            
            if( CGRectContainsPoint( r, local ) ) {
                return item;
            }
        }
    }
    return nil;
}

@end
