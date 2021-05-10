#import "HUDLayer.h"
#import "ActionLayer.h"
#import "AppDelegate.h"
#import "FCGameManager.h"
#import "SimpleContactListener.h"

@implementation ActionLayer
#pragma mark - 메모리 해제 매우 중요함
- (void)dealloc 
{
    [_lhelper release];
    _lhelper = nil;
    _world->SetContactListener(NULL);
    
    delete _contactListener;
    delete _world;
    delete m_debugDraw;
    [super dealloc];
}

-(FCGameMain*) GetGameMain
{
    return &m_GameMain;
}

+ (id)scene :(NSString*) Name
{
    CCScene *scene = [CCScene node];
    HUDLayer *hud = [HUDLayer node];
    [scene addChild:hud z:1];

    ActionLayer *layer = [[[ActionLayer alloc] initWithHUD:hud name:Name] autorelease];
    [scene addChild:layer];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate SetActionLayer:layer];
    [appDelegate SetHudLayer:hud];
    
    [layer InitGameMain:hud name:Name];
    return scene;
}

-(void)InitGameMain :(HUDLayer *)hud name:(NSString*)Name
{
    m_GameMain.Init(Name,hud);
    m_GameMain.SetLevelHelperLoader(_lhelper);
    m_GameMain.Clear();
    m_GameMain.CreateSpriteInLevel();
    m_GameMain.setupAudio();
    
    FCPlayer* pPlayer = m_GameMain.GetLocalPlayer();
    if(pPlayer)
    {
        pPlayer->InitCheckPoint();
    }
    
    FCWorldData* pWorldData = m_GameMain.GetWorldData();
    NSString* strBGM = pWorldData->GetBGM();
    
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:strBGM loop:true];
    
    m_GameMain.FirstEvent();    
    if([pWorldData->GetType() isEqualToString:@"TITLE"])
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        StageSelectLayer* pStageSelectLayer = (StageSelectLayer*)[appDelegate GetStageSelectLayer];
        CocosOverlayScrollView* pScrollView = [pStageSelectLayer GetScrollView];
        pScrollView.hidden = true;
    }
    else if([pWorldData->GetType() isEqualToString:@"GAME"])
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        StageSelectLayer* pStageSelectLayer = (StageSelectLayer*)[appDelegate GetStageSelectLayer];
        CocosOverlayScrollView* pScrollView = [pStageSelectLayer GetScrollView];
        pScrollView.hidden = true;
    }
    else if([pWorldData->GetType() isEqualToString:@"STAGE_SELECT"])
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        StageSelectLayer* pStageSelectLayer = (StageSelectLayer*)[appDelegate GetStageSelectLayer];
        [_hud addChild:pStageSelectLayer z:0];
        
        CocosOverlayScrollView* pScrollView = [pStageSelectLayer GetScrollView];
        pScrollView.hidden = false;
    }
    
    FCUIWindowManager* pWindowManager = m_GameMain.GetWindowManager();
    if(pWindowManager)
    {
        FCUIStageStartWindow* pStageStartWindow = pWindowManager->GetStageStartWindow();
        if(pStageStartWindow)
        {
            pStageStartWindow->SetUIStageName(pWorldData->GetUIStageName());
            pStageStartWindow->SetUIStageSprite(pWorldData->GetUIStageSprite());
        }
    }
}

- (void)setupLevelHelper :(NSString*) Name
{
    //CCLOG(@"SETUP LEVEL HELPER");
    self.scaleX = VIEW_RATIO;
    self.scaleY = VIEW_RATIO;
    
    b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
    _world = new b2World(gravity);

    _world->SetAllowSleeping(false);
    _world->SetContinuousPhysics(true);
        
    _contactListener = new SimpleContactListener(self);
    _world->SetContactListener(_contactListener);
    
    [MyLevelHelperLoader dontStretchArtOnIpad];
    _lhelper = [[MyLevelHelperLoader alloc] initWithContentOfFile:Name];
    [_lhelper addObjectsToWorld:_world cocos2dLayer:self];

    if([_lhelper hasPhysicBoundaries])
        [_lhelper createPhysicBoundariesNoStretching:_world];
    
    if(![_lhelper isGravityZero])
        [_lhelper createGravity:_world];
    
    parallaxNode = [_lhelper parallaxNodeWithUniqueName:@"Parallax_1"];
    [self SetDebugDraw];
}

-(void) SetDebugDraw
{
#ifdef DEBUG
    m_debugDraw = new GLESDebugDraw();
    _world->SetDebugDraw(m_debugDraw);
    uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    flags += b2Draw::e_jointBit; 
    m_debugDraw->SetFlags(flags);
#endif
}

-(void) CreateSpriteInLevel
{
    m_GameMain.CreateSpriteInLevel();
}

-(void) CreateSprite:(LHSprite*) pSprite
{
    m_GameMain.CreateSprite(pSprite);
}

-(void) CreateSpriteReserve:(LHSprite*) pSprite
{
    m_GameMain.CreateSpriteReserve(pSprite);
}

- (id)initWithHUD:(HUDLayer *)hud name:(NSString*)Name
{
    if ((self = [super init])) 
    {
        _hud = hud;
        [self setupLevelHelper:Name];
        [self schedule: @selector(tick:) interval:1.0f/60.0f];
        self.isTouchEnabled = YES;
    }
    return self;
}

-(void)setViewpointCenter:(CGPoint) position 
{
    position.x *= VIEW_RATIO;
    position.y *= VIEW_RATIO;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    winSize.width *= VIEW_RATIO;
    winSize.height *= VIEW_RATIO;
    
    CGRect worldRect = [_lhelper gameWorldSize];
    worldRect.size.width *= VIEW_RATIO;
    worldRect.size.height *= VIEW_RATIO;
    
    int x = position.x;
    int y = position.y;
    
    //최소값
    x = MAX(position.x, winSize.width / 2);
    y = MAX(position.y, winSize.height / 2);
    
    //최대값
    x = MIN(x, worldRect.size.width);
    y = MIN(y, worldRect.size.height);
    
    CGPoint actualPosition = ccp(x, y);
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);

    [self setPosition:viewPoint];    
    float deltaX = viewPoint.x - prevLocation.x;
    float deltaY = viewPoint.y - prevLocation.y;
    
    prevLocation = viewPoint;
    if(nil != parallaxNode)
    {
        [parallaxNode setPosition:ccp([parallaxNode position].x + deltaX, [parallaxNode position].y + deltaY)];
    }
}

-(void) draw 
{      
#ifdef DEBUG
    if(_world == nil)
        return;
    
    glClearColor(98.0/255.0, 183.0/255.0, 214.0/255.0, 255.0/255.0);
    glClear(GL_COLOR_BUFFER_BIT);	
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    _world->DrawDebugData();
    
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
#endif
}

-(b2World*)GetWorld
{
    return _world;
}

-(void)step:(ccTime)dt 
{
	float32 frameTime = dt;
	int stepsPerformed = 0;
    
	while ( (frameTime > 0.0) && (stepsPerformed < MAXIMUM_NUMBER_OF_STEPS) )
    {
		float32 deltaTime = std::min( frameTime, FIXED_TIMESTEP );
		frameTime -= deltaTime;
		if (frameTime < MINIMUM_TIMESTEP) 
        {
			deltaTime += frameTime;
			frameTime = 0.0f;
		}
        
        //contactmanager 포함
		_world->Step(deltaTime,VELOCITY_ITERATIONS,POSITION_ITERATIONS);
        stepsPerformed++;
	}
    
	_world->ClearForces();
}

-(void) update :(ccTime) dt
{
    FCPlayer* pLocalPlayer = m_GameMain.GetLocalPlayer();    
    
    [self step:dt];
    for (b2Body* b = _world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) 
        {
			CCSprite *myActor = (CCSprite*)b->GetUserData();
            if(myActor != 0)
            {
                myActor.position = [LevelHelperLoader metersToPoints:b->GetPosition()];                
                myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            }
        }	
	}
    
    if(pLocalPlayer)
    {
        [self setViewpointCenter:pLocalPlayer->GetSprite().position];
    }
}

-(void) tick: (ccTime) dt
{
    m_GameMain.Process(dt);
    [self update:dt];
    [_hud Process:dt];
}

- (void)beginContact:(b2Contact *)contact 
{
    m_GameMain.beginContact(contact);
}

- (void)endContact:(b2Contact *)contact 
{
    m_GameMain.endContact(contact);
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*
    if ([touches count] == 2) 
    {
		NSArray *twoTouch = [touches allObjects];
		UITouch *tOne = [twoTouch objectAtIndex:0];
		UITouch *tTwo = [twoTouch objectAtIndex:1];
		CGPoint firstTouch = [tOne locationInView:[tOne view]];
		CGPoint secondTouch = [tTwo locationInView:[tTwo view]];
        
		m_fInitialDistance = sqrt(pow(firstTouch.x - secondTouch.x, 2.0f) + pow(firstTouch.y - secondTouch.y, 2.0f));
	}
    */
    
    m_GameMain.ccTouchesBegan(touches, event);
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*
    if ([touches count] == 2) 
    {
		NSArray *twoTouch = [touches allObjects];
        
		UITouch *tOne = [twoTouch objectAtIndex:0];
		UITouch *tTwo = [twoTouch objectAtIndex:1];
		CGPoint firstTouch = [tOne locationInView:[tOne view]];
		CGPoint secondTouch = [tTwo locationInView:[tTwo view]];
		CGFloat currentDistance = sqrt(pow(firstTouch.x - secondTouch.x, 2.0f) + pow(firstTouch.y - secondTouch.y, 2.0f));
        
		if (m_fInitialDistance == 0) 
        {
			m_fInitialDistance = currentDistance;
		} 
        else if (currentDistance - m_fInitialDistance > 0) 
        {
            [self OpenPausedWindow];            
			m_fInitialDistance = currentDistance;
		} 
        else if (currentDistance - m_fInitialDistance < 0) 
        {
            [self ClosePausedWindow];            
			m_fInitialDistance = currentDistance;
		}
	}
    */

    m_GameMain.ccTouchesMoved(touches, event);
}
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*
	for( UITouch *touch in touches ) 
    {
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
	}
    */
    
    m_GameMain.ccTouchesEnded(touches, event);
}

-(void) ClosePausedWindow
{
    FCUIWindowManager* pWindowManager = m_GameMain.GetWindowManager();
    if(pWindowManager->GetShow(@"PausedWindow") == true)
    {
        [self resumeSchedulerAndActions];
        pWindowManager->SetShow(@"PausedWindow",false);
        
        [_hud SetShowJoy:true];
        [_hud SetShowButton:true];
    }
    else if(pWindowManager->GetShow(@"MainOptionWindow") == true)
    {
        [self resumeSchedulerAndActions];
        pWindowManager->SetShow(@"MainOptionWindow",false);
        
        [_hud SetShowJoy:true];
        [_hud SetShowButton:true];
    }
}

-(void) OpenPausedWindow
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    if([pGameManager GetLoadingState] != LOADING_STATE_NONE)
        return;
    
    FCPlayer* pPlayer = m_GameMain.GetLocalPlayer();
    if(pPlayer && pPlayer->GetState() == STATE_DEATH)
        return;
    
    FCWorldData* pWorldData = m_GameMain.GetWorldData();
    if([pWorldData->GetType() isEqualToString:@"GAME"] == false)
    {
        return;
    }
    
    FCUIWindowManager* pWindowManager = m_GameMain.GetWindowManager();
    
    if(pWindowManager->GetShow(@"StageClearWindow"))
        return;
    
    if(pWindowManager->GetShow(@"PausedWindow"))
        return;
    
    if(pWindowManager->GetShow(@"MainOptionWindow"))
        return;
    
    if(pWindowManager->GetShow(@"StageStartWindow"))
    {
        pWindowManager->SetShow(@"StageStartWindow",false);
    }

    [self pauseSchedulerAndActions];
    pWindowManager->SetShow(@"PausedWindow",true);
    [_hud SetShowJoy:false];
    [_hud SetShowButton:false];
}

-(void) OpenSaveWorldData:(NSString*) strMapName
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    
    FCSaveWorldData* pSaveWorldData = pSaveData->GetSaveWorldData(strMapName);
    if(pSaveWorldData)
    {
        pSaveWorldData->SetOpen(true);
    }
    
    FCWorldDataManager* pWorldDataManager = [pDataManager GetWorldDataManager];
    FCWorldData* pWorldData = pWorldDataManager->GetWorldData(strMapName);

    if(pWorldData->GetGroupEnd())
    {
        
    }
}

-(void) SaveData
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCSaveDataManager* pSaveDataManager = [pDataManager GetSaveDataManager];
    FCSaveDataParser* pSaveDataParser = [pDataManager GetSaveDataParser];
    
    FCGameManager* pGameManager = [appDelegate GetGameManager];
    NSString* strSaveSlot = [pGameManager GetSaveSlot];
    FCSaveData* pSaveData = pSaveDataManager->GetSaveData(strSaveSlot);
    
    FCPlayer* pLocalPlayer = m_GameMain.GetLocalPlayer();
    if(pLocalPlayer)
    {
        pSaveData->SetLife(pLocalPlayer->GetLife());
        pSaveData->SetHP(pLocalPlayer->GetHP());
    }
    
    pSaveData->SetContinueCount(m_GameMain.GetContinueCount());
    pSaveData->SetScore(m_GameMain.GetScore());
    pSaveData->SetCoin(m_GameMain.GetCoin());
    pSaveDataParser->SaveSaveData();
}
@end