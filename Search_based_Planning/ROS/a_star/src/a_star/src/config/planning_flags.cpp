//
// Created by lym on 21-3-24
//

#include "a_star/config/planning_flags.hpp"

DEFINE_bool(enable_computation_time_output, true, "output details on screen");

DEFINE_double(car_width, 2.0, "");
DEFINE_double(car_length, 4.9, "");
DEFINE_double(rear_axle_to_center, 1.45, "distance from rear axle to vehicle center");

DEFINE_double(epsilon, 1e-6, "use this when comparing double");
DEFINE_double(collision_epsilon, 200, "use this when checking if collision");