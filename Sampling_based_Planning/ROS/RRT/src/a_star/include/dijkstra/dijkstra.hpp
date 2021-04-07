//
// Created by lym on 21-2-16
//

#ifndef DIJKSTRA_HPP_
#define DIJKSTRA_HPP_

#include "a_star/a_star.hpp"

namespace a_star {

class State;
class APoint;
class SearchNode;
class AStar;

class Dijkstra : public AStar {
 public:
    Dijkstra() = delete;
    Dijkstra(const State& start_state,
          const State& end_state,
          const grid_map::GridMap& map,
          const std::string& heuristic_type);
    virtual ~Dijkstra();
    Dijkstra(const Dijkstra& astar) = delete;
    Dijkstra& operator=(const Dijkstra& astar) = delete;

 private:
    inline double getH(const APoint& p) const override;
};
}  // namespace a_star

#endif  // DIJKSTRA_HPP_