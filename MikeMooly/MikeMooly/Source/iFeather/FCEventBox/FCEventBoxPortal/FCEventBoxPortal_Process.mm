#import "FCEventBoxPortal.h"

void FCEventBoxPortal::Process(ccTime dt)
{
    switch(m_nState)
    {
        case EVENT_BOX_PORTAL_STATE_READY:
            if(IsEndFrame())
            {
                SetState(EVENT_BOX_PORTAL_STATE_STAY);
            }
            break;
    }
    
    FCEventBox::Process(dt);
}