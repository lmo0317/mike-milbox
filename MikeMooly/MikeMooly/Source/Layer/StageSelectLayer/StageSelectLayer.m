#import "StageSelectLayer.h"
#import "CCScrollMenu.h"
#import "AppDelegate.h"

@implementation StageSelectLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	StageSelectLayer *layer = [StageSelectLayer node];	
	[scene addChild: layer];
	
	return scene;
}

-(void)select:(id)sender
{
    NSLog(@"Select Button");
}

-(id) init
{
	if( (self=[super init]))
    {
        // 초기화
        m_frameWidth = [[CCDirector sharedDirector] winSize].width;
        m_frameHeight = [[CCDirector sharedDirector] winSize].height;
        
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        m_nPage = [appDelegate GetStageSelectPage];
        
        NSArray* world = [NSArray arrayWithObjects:@"Stage 1", @"Stage 2",@"Stage 3",@"Stage 4", nil];
        NSInteger worldSize = [world count];
        CocosOverlayScrollView* worldScrollView = [[CocosOverlayScrollView alloc] initWithLayer:self target:self count:worldSize];        
        
        [[[CCDirector sharedDirector] openGLView] addSubview:worldScrollView];
        m_selectWorldScrollView = worldScrollView;
        [worldScrollView release];
        
        self.contentSize = CGSizeMake(m_frameWidth * worldSize, m_frameHeight);
       
    }
	return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint dragPt = scrollView.contentOffset;    
    dragPt = [[CCDirector sharedDirector] convertToGL:dragPt];
    [self setPosition:ccp(-dragPt.x, 0)];    
}

- (void) dealloc
{
    [m_selectWorldScrollView removeFromSuperview];
    m_selectWorldScrollView = nil;
    
	[super dealloc];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float offset_x = scrollView.contentOffset.x;
    
    int nPage = floor((offset_x / pageWidth) + 1);
    if(nPage != m_nPage)
    {
        m_nPage = nPage;
        [self PageChange:m_nPage];
    }
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate SetState:CONTROL_BUTTON_STATE_NONE];
}

-(void)PageChange:(int) nPage
{
    CCLOG(@"PAGE CHANGE");
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate PageChange:nPage];
}

-(void) Clear
{
    //[self stopAllActions];
    //CGPoint pos = ccp(m_frameWidth * (m_nPage - 1),0);
    //[m_selectWorldScrollView setContentOffset:pos  animated:YES];
    
    [self removeAllChildrenWithCleanup:YES];
}

-(CocosOverlayScrollView*) GetScrollView
{
    return m_selectWorldScrollView;
}

@end
