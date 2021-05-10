//
//  MainLayer.h
//  ScrollViewTest
//
//  Created by 1ststory on 11. 11. 9..
//  Copyright __MyCompanyName__ 2011년. All rights reserved.
//

#import "cocos2d.h"
#import "CocosOverlayScrollView.h"

@interface StageSelectLayer : CCLayer <CocosOverlayScrollViewDelegate>
{    
    CGFloat m_frameWidth;
    CGFloat m_frameHeight;
    int m_nPage;
    CocosOverlayScrollView* m_selectWorldScrollView;
}

-(void) PageChange:(int) nPage;
+(CCScene *) scene;
-(void) Clear;

-(CocosOverlayScrollView*) GetScrollView;

@end
