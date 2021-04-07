//
// Created by lym on 21-2-16
//

#ifndef BEST_FIRST_SEARCH_HPP_
#define BEST_FIRST_SEARCH_HPP_

#include "a_star/a_star.hpp"

namespace a_star {

class State;
class APoint;
class SearchNode;
class AStar;

class BestFirstSearch : public AStar {
 public:
    BestFirstSearch() = delete;
    BestFirstSearch(const State& start_state,
          const State& end_state,
          const grid_map::GridMap& map,
          const std::string& heuristic_type);
    virtual ~BestFirstSearch();
    BestFirstSearch(const BestFirstSearch& astar) = delete;
    BestFirstSearch& operator=(const BestFirstSearch& astar) = delete;

 private:
    inline double getG(const APoint& parent, const APoint& point) const override;
};
}  // namespace a_star

#endif  // BEST_FIRST_SEARCH_HPP_