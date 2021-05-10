#ifndef MikeMooly_FCUINamePanelWindow_h
#define MikeMooly_FCUINamePanelWindow_h

#include <vector>
@interface FCUINamePanelWindow :NSObject
{
}

-(void) CreateScorePanel:(int) nX y:(int) nY z:(int) nZ score:(int) nScore;
-(void) EndEvent:(id)sender;
@end


#endif
