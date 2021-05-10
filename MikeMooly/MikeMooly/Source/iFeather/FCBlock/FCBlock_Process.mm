#import "FCEnemy.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCBlock::Process(ccTime dt)
{
    switch(m_nState)
    {
        case BLOCK_STATE_BREAK:
            if(IsEndFrame())
            {
                if(m_nHP <= 0)
                {
                    m_bDelete = true;
                }
                else
                {
                    SetState(BLOCK_STATE_STAY);                    
                }
            }
            break;
    }
    FCObject::Process(dt);
}