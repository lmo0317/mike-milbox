#include "FCCharacterStateSkyDamage.h"

const bool FCCharacterStateSkyDamage::SetState(const int nState)
{
    switch(nState)
    {
        case STATE_WALK:
        case STATE_RUN:
        case STATE_JUMP:
        case STATE_JUMP2:
        case STATE_BOUNCE:
        case STATE_FLY:
        case STATE_FALL:
        case STATE_LANDING:
            return true;
    }
    
    return false;
}