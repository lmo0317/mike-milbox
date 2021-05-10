#import "FCFieldItem.h"
#import "LHSettings.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

void FCFieldItem::Process(ccTime dt)
{
    switch(m_nState)
    {
        case FIELDITEM_STATE_BREAK:
            if(IsEndFrame())
            {
                m_bDelete = true;
            }
            break;
    }
    FCObject::Process(dt);
}