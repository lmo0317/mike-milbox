#import <UIKit/UIKit.h>

@class CCLayer;
@protocol CocosOverlayScrollViewDelegate;

@interface CocosOverlayScrollView : UIScrollView <UIScrollViewDelegate>
{
    id<CocosOverlayScrollViewDelegate> m_target;
}

-(id)initWithLayer:(CCLayer*)layer target:(id<CocosOverlayScrollViewDelegate>)target count:(NSInteger)count;

@end

@protocol CocosOverlayScrollViewDelegate <NSObject>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end
