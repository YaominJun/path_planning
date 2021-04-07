//
// Created by lym on 21-2-16
//

#include "dijkstra/dijkstra.hpp"

namespace a_star {
Dijkstra::Dijkstra(const State& start_state,
             const State& end_state,
             const grid_map::GridMap& map,
             const std::string& heuristic_type)
    : AStar(start_state, end_state, map, "euclidean") {
    //   collision_checker_(new CollisionChecker(map)),  // TODO: robust collision checker
        // motion_set_ = {{-1, 0}, {-1, 1}, {0, 1}, {1, 1}, 
        //             {1, 0}, {1, -1}, {0, -1}, {-1, -1}};
        // resolution_ = map_.getResolution();
      }

Dijkstra::~Dijkstra() {}

inline double Dijkstra::getH(const APoint& p) const {
    // Note that this h is neither admissible nor consistent, so the result is not optimal.
    // There is a smoothing stage after this, so time efficiency is much more
    // important than optimality here.
    // std::cout << "in dijkstra" << "--------------" << std::endl;
    return 0;
    // if (heuristic_type_ == "manhattan") {
    //     return fabs(end_state_.x - p.x) + fabs(end_state_.y - p.y);
    // } else {
    //     return sqrt(pow(end_state_.x - p.x, 2) + pow(end_state_.y - p.y, 2));
    // }
}
}  // namespace a_star