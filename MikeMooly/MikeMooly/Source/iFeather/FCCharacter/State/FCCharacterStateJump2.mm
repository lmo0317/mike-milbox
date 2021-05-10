#include "FCCharacterStateJump2.h"

const bool FCCharacterStateJump2::SetState(const int nState)
{
    switch(nState)
    {
        case STATE_RUN:
        case STATE_JUMP:
        case STATE_JUMP2:
        case STATE_BOUNCE:
        case STATE_FLY:
        case STATE_FALL:
        case STATE_LANDING:
        case STATE_DAMAGE:
            return true;
    }
    
    return false;
}