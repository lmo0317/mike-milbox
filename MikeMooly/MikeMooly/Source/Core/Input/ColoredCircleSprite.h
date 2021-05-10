#import "cocos2d.h"

@interface ColoredCircleSprite : CCNode <CCRGBAProtocol, CCBlendProtocol> 
{
	float		radius_;
	GLubyte		opacity_;
	ccColor3B	color_;
	NSUInteger numberOfSegments;
	GLfloat *circleVertices_;
	ccBlendFunc	blendFunc_;
}

@property (nonatomic,readwrite) float radius;
@property (nonatomic,readonly) GLubyte opacity;
@property (nonatomic,readonly) ccColor3B color;
@property (nonatomic,readwrite) ccBlendFunc blendFunc;
+ (id) circleWithColor: (ccColor4B)color radius:(GLfloat)r;
- (id) initWithColor:(ccColor4B)color radius:(GLfloat)r;
- (BOOL) containsPoint:(CGPoint)point;

@end
