#import "FCGameCenterManager.h"


@implementation FCGameCenterManager

-(void) Init
{
    /*
    if([FCGameCenterManager isGameCenterAvailable]) 
    {
        [FCGameCenterManager connectGameCenter];
        strCategory = @"main_score";
    }
    */
}

//접속 ////////////////////////////////////////////////////////////////////////////////////////////////////////////
//GameCenter 사용 가능 단말인지 확인
+ (BOOL) isGameCenterAvailable 
{ 
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] !=NSOrderedAscending);
    return (gcClass && osVersionSupported);
}

//GameCenter 로그인
+ (void) connectGameCenter
{
    /*
    NSLog(@"connect... to gamecenter");
    if([GKLocalPlayer localPlayer].authenticated == NO) { //게임센터 로그인이 아직일때
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError* error){
            if(error == NULL){
                NSLog(@"게임센터 로그인 성공~");
            } else {
                NSLog(@"게임센터 로그인 에러. 별다른 처리는 하지 않는다.");
            }
        }];
    }
    */
    
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
        if (error == nil) //인증 성공 시 ...
        {
            // Insert code here to handle a successful authentication.
            NSLog(@"1--alias--.%@",[GKLocalPlayer localPlayer].alias);
            NSLog(@"2--authenticated--.%d",[GKLocalPlayer localPlayer].authenticated);
            NSLog(@"3--isFriend--.%d",[GKLocalPlayer localPlayer].isFriend);
            NSLog(@"4--playerID--.%@",[GKLocalPlayer localPlayer].playerID);
            NSLog(@"5--underage--.%d",[GKLocalPlayer localPlayer].underage);
            
            NSLog(@"Game Center: Player Authenticated!");
        }
        else
        {
            NSLog(@"AuthenticateLocalPlayer Error");
        }
    }];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//leader board
//점수 전송
-(void) sendScoreToGameCenter:(int)_score
{
    GKScore* score = [[[GKScore alloc] initWithCategory:strCategory]autorelease];
    score.value = _score;
    
    // 아래는 겜센터 스타일의 노티를 보여준다. 첫번째가 타이틀, 두번째가 표시할 메세지
    //[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"NBank Point!"andMessage:[NSString stringWithFormat:@"NBank Point %d점을 기록하셨습니다.",_score]];
    
    // 실지로 게임센터 서버에 점수를 보낸다.
    [score reportScoreWithCompletionHandler: ^(NSError *error) {
        if (error != nil)
        {
            NSLog(@"Submitting a highscore failed!!!");
        }
        else {
            NSLog(@"Submitting highcore Succeeded!!!");
        }
    }];
}

- (void) showLeaderboard
{
    GKLeaderboardViewController *leaderboardController = [[[GKLeaderboardViewController alloc] init]autorelease];
    if (leaderboardController != nil)
    {
        tempVC=[[GameCenterViewController alloc] init];
        leaderboardController.leaderboardDelegate = self;
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:tempVC.view];
        [tempVC presentModalViewController:leaderboardController animated: YES];
    }
}

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [tempVC dismissViewControllerAnimated:YES completion:^(void)
     {
         [tempVC.view removeFromSuperview];
         [tempVC release];
         NSLog(@"leaderboard correctly dismissed");
     }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//목표 달성

// 게임센터 서버로 목표달성도를 보낸다. 첫번째가 목표ID, 두번째가 달성도. 100%면 목표달성임
- (void) sendAchievementWithIdentifier: (NSString*) identifier percentComplete: (float) percent
{
    NSLog(@"--겜센터 : sendAchievementWithIdentifier %@ , %f",identifier,percent);
    GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier]autorelease];
    if (achievement)
    {
        achievement.percentComplete = percent;
        
        [achievement reportAchievementWithCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 
             }
         }];
        
        // 이 아래는 게임센터로부터 목표달성이 등록되면 실행되는 리스너(?)
        [GKAchievementDescription loadAchievementDescriptionsWithCompletionHandler:
         ^(NSArray *descriptions, NSError *error) 
         {
             if (error != nil){}
             // process the errors
             if (descriptions != nil)
             {
                 //목표달성이 등록되면 노티로 알려준다.
                 for (GKAchievementDescription *achievementDescription in descriptions)
                 {
                     if ([[achievementDescription identifier] isEqualToString:identifier])
                     {
                         /*
                         // 보낸 ID와 일치하면 달성도에 따라 노티를 보여준다.
                         if (percent >= 100.0f) 
                         { 
                             // 100%면 달성완료 노티를...
                             [[GKAchievementHandler defaultHandler]notifyAchievement:achievementDescription];   
                         } 
                         else 
                         {
                             // 100%가 안되면 진행도를 노티.
                             [[GKAchievementHandler defaultHandler]notifyAchievementTitle:achievementDescription.title andMessage:[NSString stringWithFormat:@"%.0f%% 완료하셨습니다.",percent]];
                         }
                         */
                     }
                 }                           
             }                     
         }];    
    }
} 

- (void) showArchboard 
{
    GKAchievementViewController *archiveController = [[[GKAchievementViewController
                                                        alloc] init] autorelease];
    if (archiveController != nil) 
    {
        tempVC=[[GameCenterViewController alloc] init];
        archiveController.achievementDelegate = self;
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:tempVC.view];
        [tempVC presentModalViewController:archiveController animated: YES];
    }
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *) viewController
{
    [tempVC dismissViewControllerAnimated:YES completion:^(void)
     {
         [tempVC.view removeFromSuperview];
         [tempVC release];
         NSLog(@"leaderboard correctly dismissed");
     }];

}

// 테스트할때 현재까지 모든 진행도를 리셋하는 메소드.
- (void) resetAchievements
{
    // Clear all progress saved on Game Center
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error)
     {
         if (error != nil){}
         // handle errors
     }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////


@end