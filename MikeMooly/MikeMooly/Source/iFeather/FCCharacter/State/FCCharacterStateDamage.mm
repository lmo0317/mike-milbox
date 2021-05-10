#include "FCCharacterStateDamage.h"

const bool FCCharacterStateDamage::SetState(const int nState)
{
    switch(nState)
    {
        //case STATE_WALK:
        //case STATE_RUN:
        //case STATE_JUMP:
        //case STATE_JUMP2:
        case STATE_BOUNCE:
        case STATE_FLY:
        case STATE_FALL:
        case STATE_LANDING:
        case STATE_STAY:
        case STATE_DEATH:
        case STATE_DAMAGE:
            return true;
    }
    
    return false;
}