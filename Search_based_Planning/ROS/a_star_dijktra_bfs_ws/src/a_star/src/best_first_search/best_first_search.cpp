//
// Created by lym on 21-2-16
//

#include "best_first_search/best_first_search.hpp"

namespace a_star {
BestFirstSearch::BestFirstSearch(const State& start_state,
             const State& end_state,
             const grid_map::GridMap& map,
             const std::string& heuristic_type)
    : AStar(start_state, end_state, map, "euclidean") {
    //   collision_checker_(new CollisionChecker(map)),  // TODO: robust collision checker
        // motion_set_ = {{-1, 0}, {-1, 1}, {0, 1}, {1, 1}, 
        //             {1, 0}, {1, -1}, {0, -1}, {-1, -1}};
        // resolution_ = map_.getResolution();
      }

BestFirstSearch::~BestFirstSearch() {}

inline double BestFirstSearch::getG(const APoint& parent, const APoint& point) const {
    // g cost
    // std::cout << "in bfs---------------" << std::endl;
    return 0;
}

}  // namespace a_star