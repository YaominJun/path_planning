//
// Created by lym on 21-3-23
//

#include "a_star/tools/tools.hpp"

namespace a_star {

State local2Global(const State& reference, const State& target) {
    double x = target.x * cos(reference.z) - target.y * sin(reference.z) + reference.x;
    double y = target.x * sin(reference.z) + target.y * cos(reference.z) + reference.y;
    double z = reference.z + target.z;
    return {x, y, z, target.k, target.s};
}

State global2Local(const State& reference, const State& target) {
    double dx = target.x - reference.x;
    double dy = target.y - reference.y;
    double x = dx * cos(reference.z) + dy * sin(reference.z);
    double y = -dx * sin(reference.z) + dy * cos(reference.z);
    double z = target.z - reference.z;;
    return {x, y, z, target.k, 0};
}

bool isEqual(const APoint* a, const APoint* b) {
    double dis = sqrt(pow(a->x - b->x, 2) + pow(a->y - b->y, 2));
    return dis < FLAGS_epsilon;
}

bool isEqual(const APoint* a, const State* b) {
    double dis = sqrt(pow(a->x - b->x, 2) + pow(a->y - b->y, 2));
    return dis < FLAGS_epsilon;
}

bool isEqual(const State* a, const State* b) {
    double dis = sqrt(pow(a->x - b->x, 2) + pow(a->y - b->y, 2));
    return dis < FLAGS_epsilon;
}

bool isEqual(const State* a, const APoint* b) {
    double dis = sqrt(pow(a->x - b->x, 2) + pow(a->y - b->y, 2));
    return dis < FLAGS_epsilon;
}

void transformState(const APoint* apoint, State& state) {
    state.x = apoint->x;
    state.y = apoint->y;
}

void transformState(const State& state, APoint* apoint) {
    apoint->x = state.x;
    apoint->y = state.y;
}

}  // namespace a_star