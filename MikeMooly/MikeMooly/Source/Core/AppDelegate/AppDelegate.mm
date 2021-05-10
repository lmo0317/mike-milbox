#import "cocos2d.h"
#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "ActionLayer.h"
#import "FCGameManager.h"
#import "FCEncryption.h"

#import "StageSelectLayer.h"
#import "FCPlayer.h"
#import "FCDataManager.h"
#import "FCGameMain.h"
#import "FCUIWindowManager.h"
#import "ZipArchive.h"
#import "FCGameCenterManager.h"

@implementation AppDelegate
@synthesize window;


- (void) removeStartupFlicker
{
}

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeMainLoop];
	
	CCDirector *director = [CCDirector sharedDirector];	
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;

	EAGLView *glView = [EAGLView viewWithFrame:[window bounds] pixelFormat:kEAGLColorFormatRGB565 depthFormat:0];
	
	[director setOpenGLView:glView];
    [glView setMultipleTouchEnabled:YES];

#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/240.0];
	[director setDisplayFPS:NO];

	[viewController setView:glView];
    [window addSubview: viewController.view];
	[window makeKeyAndVisible];

if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
else    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
    
    
    //[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_PVRTC4];
	//[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
	[self removeStartupFlicker];
    
    // // Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
    if(![director enableRetinaDisplay:YES] )
    {
        CCLOG(@"Retina Display Not supported");
    }
    
    //[self OpenZip];
    
    m_pEncryption = [[FCEncryption alloc] retain];
    [m_pEncryption Init];
    
    m_pDataManager = [[FCDataManager alloc] retain];
    [m_pDataManager Init];
    
    m_pGameManager = [[FCGameManager alloc] retain];
    [m_pGameManager Init];
    
    m_pGameCenterManager = [[FCGameCenterManager alloc] retain];
    [m_pGameCenterManager Init];
        
    m_pStageSelectLayer = [[StageSelectLayer alloc] init];
    
    CCScene *scene = [ActionLayer scene:@"title"];
    [[CCDirector sharedDirector] runWithScene:scene];
    //[CaulyViewController stopLoading];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	[viewController release];
	[window release];
	[director end];	
}


- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc 
{    
	[[CCDirector sharedDirector] end];
	[window release];
    
    [m_pDataManager release];
    [m_pGameManager release];
    [m_pEncryption release];
    //[m_pZipArchive release];
    
	[super dealloc];
}

-(void)SetActionLayer:(CCLayer*)pActionLayer
{
    m_pActionLayer = pActionLayer;
}

-(void)SetHudLayer:(CCLayer*)pHudLayer
{
    m_pHudLayer = pHudLayer;
}

-(CCLayer* )GetActionLayer
{
    return m_pActionLayer;
}

-(CCLayer* )GetHudLayer
{
    return m_pHudLayer;
}

-(CCLayer*) GetStageSelectLayer
{
    return m_pStageSelectLayer;
}

-(FCDataManager*) GetDataManager
{
    return m_pDataManager;
}

-(FCGameManager*) GetGameManager
{
    return m_pGameManager;
}

-(FCGameCenterManager*) GetGameCenterManager
{
    return m_pGameCenterManager;
}

-(FCEncryption*) GetEncryption
{
    return m_pEncryption;
}

-(void) PageChange:(int) nPage
{
    FCGameMain* pGameMain = [(ActionLayer*)m_pActionLayer GetGameMain];
    if(pGameMain == NULL)
        return;
    
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();
    FCUIStageSelectWindow* pStageSelectWindow = pWindowManager->GetStageSelectWindow();
    pStageSelectWindow->Reset();
    pStageSelectWindow->ShowEvent();
    
    [m_pGameManager SetStageSelectPage:nPage];
}

-(int) GetStageSelectPage
{
    return [m_pGameManager GetStageSelectPage];
}

-(void) SetState:(int)nState
{
    FCGameMain* pGameMain = [(ActionLayer*)m_pActionLayer GetGameMain];
    FCUIWindowManager* pWindowManager = pGameMain->GetWindowManager();

    pWindowManager->SetState(nState);
}

/*
-(FCZipArchive*) GetZipArchive
{
    return m_pZipArchive;
}
*/

/*
-(void) OpenZip
{
    //번들에 있는 zip 파일
    NSString *pathTofileOne = [[NSBundle mainBundle] pathForResource:@"map" ofType: @"zip"];
    NSLog(@"map.zip path: %@", pathTofileOne);

    //doucument 위치
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString* documentsDir = [paths objectAtIndex:0];
	NSString* fileName = [@"map" stringByAppendingPathExtension:kFileExtension];
	NSString* filePath = [documentsDir stringByAppendingPathComponent:fileName];
    
	m_pZipArchive = [[[FCZipArchive alloc] initWithFilePath: filePath] retain];
    [m_pZipArchive Init];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSLog(@"map.zip 존재하지 않음.");
        NSError *myError = nil;
        
        // copy
        [[NSFileManager defaultManager] copyItemAtPath:pathTofileOne toPath:filePath error:&myError];
        
        if (myError != nil) 
        {
            NSLog(@"ERROR -- %@", [myError localizedDescription]);
        } 
        else 
        {
            BOOL fileExistsInDoc = [[NSFileManager defaultManager]fileExistsAtPath:[filePath stringByAppendingPathComponent:@"map.zip"]];
            NSLog(@"map.zip 파일 카피 성공 - 위치: %i", fileExistsInDoc);
            
            //파일 복사 성공 하면 압축 해제
            [m_pZipArchive releaseZipFile];
        }
    }
    else
    {
         NSLog(@"map.zip 존재함");
    }
}
*/

#pragma mark -

@end
