#import "FCShoot.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCShoot::Process(ccTime dt)
{    
    m_dCurTime += dt;
    if(m_dCurTime >= m_fLifeTime)
    {
        m_bDelete = true;
    }
    
    FCObject::Process(dt);
}

