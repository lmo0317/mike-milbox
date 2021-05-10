
#ifndef MikeMooly_ActionLayerDef_h
#define MikeMooly_ActionLayerDef_h

#define MOVE_POINTS_PER_SECOND 80.0

const float32 FIXED_TIMESTEP = 1.0f / 60.0f;
const float32 MINIMUM_TIMESTEP = 1.0f / 600.0f;  
const int32 VELOCITY_ITERATIONS = 8;
const int32 POSITION_ITERATIONS = 8;
const int32 MAXIMUM_NUMBER_OF_STEPS = 25;
const float32 VIEW_RATIO = 0.9f;

#endif
