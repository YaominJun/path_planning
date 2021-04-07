//
// Created by lym on 21-3-24
//

#ifndef A_STAR_INCLUDE_A_STAR_CONFIG_PLANNING_FLAGS_HPP_
#define A_STAR_INCLUDE_A_STAR_CONFIG_PLANNING_FLAGS_HPP_

#include <gflags/gflags.h>

DECLARE_bool(enable_computation_time_output);

DECLARE_double(car_width);
DECLARE_double(car_length);
DECLARE_double(rear_axle_to_center);

DECLARE_double(epsilon);
DECLARE_double(collision_epsilon);



#endif  // A_STAR_INCLUDE_A_STAR_CONFIG_PLANNING_FLAGS_HPP_
