#import "FCGimmick.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCGimmick::Process(ccTime dt)
{    
    m_dCurTime += dt;    
    FCObject::Process(dt);
}

