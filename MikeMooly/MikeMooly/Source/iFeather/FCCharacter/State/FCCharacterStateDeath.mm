#include "FCCharacterStateDeath.h"

const bool FCCharacterStateDeath::SetState(const int nState)
{
    switch(nState)
    {
        case STATE_STAY:
            return true;
    }
    
    return false;
}