#import "CocosOverlayScrollView.h"
#import "cocos2d.h"
#import "AppDelegate.h"
//#import "ActionLayer.h"

@implementation CocosOverlayScrollView


-(id)initWithLayer:(CCLayer *)layer target:(id<CocosOverlayScrollViewDelegate>)target count:(NSInteger)count
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGRect rect = CGRectMake(layer.position.x, winSize.height-layer.position.y-layer.contentSize.height,
                             layer.contentSize.width, layer.contentSize.height);

    if (self = [self initWithFrame:rect])
    {
        m_target = target;
        
        self.delegate = self;
        self.contentSize = CGSizeMake(layer.contentSize.width * count, layer.contentSize.height);
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
    }
    
    return self;
}

-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{    
    if (!self.dragging)
    {
        //UITouch* touch = [[touches allObjects] objectAtIndex:0];
        //CGPoint location = [touch locationInView: [touch view]];
        
        [self.nextResponder touchesBegan: touches withEvent:event];
        //[[[CCDirector sharedDirector] openGLView] touchesBegan:touches withEvent:event];
    }
    
    [super touchesBegan: touches withEvent: event];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    if (!self.dragging)
    {
        [self.nextResponder touchesEnded: touches withEvent:event];
        //[[[CCDirector sharedDirector] openGLView] touchesEnded:touches withEvent:event];
    }
    
    [super touchesEnded: touches withEvent: event];
}

-(void) touchesCancelled: (NSSet *) touches withEvent: (UIEvent *) event
{
    [self.nextResponder touchesCancelled: touches withEvent:event];
    //[[[CCDirector sharedDirector] openGLView] touchesCancelled:touches withEvent:event];
    [super touchesCancelled: touches withEvent: event];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    // TODO - Custom code for handling deceleration of the scroll view
    [m_target scrollViewWillBeginDecelerating:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [m_target scrollViewDidScroll:scrollView];
    [[CCDirector sharedDirector] drawScene];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //CGPoint dragPt = [scrollView contentOffset];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [m_target scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

@end
