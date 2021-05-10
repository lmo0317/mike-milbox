#import "SneakyJoystickSkinnedBase.h"
#import "SneakyJoystick.h"
@implementation SneakyJoystickSkinnedBase
@synthesize backgroundSprite, thumbSprite, joystick;
@synthesize m_pLeftSprite,m_pCenterSprite,m_pRightSprite;

- (void) dealloc
{
	[backgroundSprite release];
	[thumbSprite release];
	[joystick release];
	[super dealloc];
}

- (id) init
{
	self = [super init];
	if(self != nil){
		self.backgroundSprite = nil;
		self.thumbSprite = nil;
		self.joystick = nil;
		
        //m_pLeftSprite = [[CCSprite spriteWithFile:@"pad_left.png"] retain];
        //m_pRightSprite = [[CCSprite spriteWithFile:@"pad_right.png"] retain];
        //m_pCenterSprite = [[CCSprite spriteWithFile:@"pad_back.png"] retain];
        
		[self schedule:@selector(updatePositions)];
	}
	return self;
}

- (void) updatePositions
{
	if(joystick && thumbSprite)
    {
		[thumbSprite setPosition:joystick.stickPosition];
    }
    
    if(joystick)
    {
        if(joystick.velocity.x == 0)
        {
            //가운데
            //backgroundSprite = m_pCenterSprite;
            [self setBackgroundSprite:m_pCenterSprite];
        }
        else if(joystick.velocity.x < 0)
        {
            //왼쪽
            [self setBackgroundSprite:m_pLeftSprite];
        }
        else 
        {
            //오른쪽
            [self setBackgroundSprite:m_pRightSprite];
        }
    }
}

- (void) setContentSize:(CGSize)s
{
	contentSize_ = s;
	backgroundSprite.contentSize = s;
	joystick.joystickRadius = s.width/2;
}

- (void) setBackgroundSprite:(CCSprite *)aSprite
{
	if(backgroundSprite){
		if(backgroundSprite.parent)
			[backgroundSprite.parent removeChild:backgroundSprite cleanup:YES];
		[backgroundSprite release];
	}
	backgroundSprite = [aSprite retain];
	if(aSprite){
		[self addChild:backgroundSprite z:0];
		
		[self setContentSize:backgroundSprite.contentSize];
	}
}

- (void) setThumbSprite:(CCSprite *)aSprite
{
	if(thumbSprite){
		if(thumbSprite.parent)
			[thumbSprite.parent removeChild:thumbSprite cleanup:YES];
		[thumbSprite release];
	}
	thumbSprite = [aSprite retain];
	if(aSprite){
		[self addChild:thumbSprite z:1];
		
		[joystick setThumbRadius:thumbSprite.contentSize.width/2];
	}
}

- (void) setJoystick:(SneakyJoystick *)aJoystick
{
	if(joystick){
		if(joystick.parent)
			[joystick.parent removeChild:joystick cleanup:YES];
		[joystick release];
	}
	joystick = [aJoystick retain];
	if(aJoystick){
		[self addChild:joystick z:2];
		if(thumbSprite)
			[joystick setThumbRadius:thumbSprite.contentSize.width/2];
		else
			[joystick setThumbRadius:0];
		
		if(backgroundSprite)
			[joystick setJoystickRadius:backgroundSprite.contentSize.width/2];
	}
}

@end
