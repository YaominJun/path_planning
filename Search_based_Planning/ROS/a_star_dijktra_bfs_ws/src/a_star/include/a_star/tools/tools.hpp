//
// Created by lym on 21-3-23
//

#ifndef A_STAR_INCLUDE_TOOLS_TOOLS_HPP_
#define A_STAR_INCLUDE_TOOLS_TOOLS_HPP_

#include "a_star/data_struct/data_struct.hpp"
#include "a_star/config/planning_flags.hpp"
#include "glog/logging.h"
#include <cmath>
#include <vector>
namespace a_star {

class State;
class APoint;

State local2Global(const State& reference, const State& target);
State global2Local(const State& reference, const State& target);

// Return true if a == b.
bool isEqual(const APoint* a, const APoint* b);
bool isEqual(const APoint* a, const State* b);
bool isEqual(const State* a, const State* b);
bool isEqual(const State* a, const APoint* b);

// transform APoint to State
void transformState(const APoint* apoint, State* state);
// transform State to APoint
void transformState(const State* state, APoint* apoint);

}  // namespace a_star
#endif  // A_STAR_INCLUDE_TOOLS_TOOLS_HPP_