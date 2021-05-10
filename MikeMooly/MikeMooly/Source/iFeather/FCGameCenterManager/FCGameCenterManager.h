
#ifndef MikeMooly_FCGameCenterManager_h
#define MikeMooly_FCGameCenterManager_h

#import "GameCenterViewController.h"
#import <GameKit/GameKit.h>
#import "GKAchievementHandler.h"



@interface FCGameCenterManager : NSObject <GKLeaderboardViewControllerDelegate,GKAchievementViewControllerDelegate> 
{
    GameCenterViewController *tempVC;
    NSString* strCategory;
}

- (void) Init;

//연결
+ (BOOL) isGameCenterAvailable;
+ (void) connectGameCenter;

//achive ment
- (void) sendAchievementWithIdentifier: (NSString*) identifier percentComplete: (float) percent;//게임센터서버에 목표달성 보내는 메소드
- (void) resetAchievements; //테스트용으로 목표달성도를 리셋하는 메소드
- (void) showArchboard;


//leader board
- (void) sendScoreToGameCenter:(int)_score; //게임센터서버에 점수 보내는 메소드
- (void) showLeaderboard;
- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;

@end

#endif
