#import "FCBackGround.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCBackGround::Process(ccTime dt)
{    
    m_dCurTime += dt;    
    FCObject::Process(dt);
}

