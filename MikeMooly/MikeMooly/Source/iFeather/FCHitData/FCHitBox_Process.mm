#import "FCHitBox.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCHitBox::Process(ccTime dt)
{    
    m_dCurTime += dt;
    if(m_dCurTime >= m_fLifeTime)
    {
        m_bDelete = true;
    }
    
    FCObject::Process(dt);
}

