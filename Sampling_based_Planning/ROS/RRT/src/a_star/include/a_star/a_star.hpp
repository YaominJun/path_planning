//
// Created by lym on 21-2-16
//

#ifndef A_STAR_HPP_
#define A_STAR_HPP_

#include "a_star/data_struct/data_struct.hpp"
#include "a_star/tools/tools.hpp"
#include "a_star/config/planning_flags.hpp"
#include "glog/logging.h"
#include "nav_msgs/OccupancyGrid.h"
#include "grid_map_core/grid_map_core.hpp"
#include "Eigen/Core"
#include <vector>
#include <queue>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <cmath>

namespace a_star {

class State;
class APoint;
class SearchNode;

class AStar {
 public:
    AStar() = delete;
    AStar(const State& start_state,
          const State& end_state,
          const grid_map::GridMap& map,
          const std::string& heuristic_type);
    virtual ~AStar();
    AStar(const AStar& astar) = delete;
    AStar& operator=(const AStar& astar) = delete;

    virtual bool searching(std::vector<State>* final_path);

    const std::unordered_set<APoint, APointHash>* getClosedSet() {return &closed_set_;}

//  private:
 protected:
    inline double getStepCost(const APoint &parent, const APoint &point) const;
    virtual inline double getG(const APoint& parent, const APoint& point) const;
    virtual inline double getH(const APoint& p) const;
    inline bool checkExistenceInClosedSet(const APoint& point) const;
    inline bool checkExistenceInOpenSet(const APoint& point) const;
    void updateNeighbor(const APoint* p, std::vector<APoint*>& sampled_points);
    bool isCollision(const Eigen::Vector2d &pos) const;
    void extractPath(const APoint* goalpoint, std::vector<State>* final_path);

    const grid_map::GridMap& map_;
    double resolution_;
   //  CollisionChecker* collision_checker_;  // TODO: robust collision checker
    std::string heuristic_type_;
    std::vector<APoint*> sampled_points_;
    std::vector<std::vector<int>> motion_set_;
    State start_state_;
    State end_state_;
   //  std::priority_queue<APoint*, std::vector<APoint*>, PointComparator> open_set_pq;
    std::unordered_set<APoint, APointHash> open_set_;
    std::unordered_set<APoint, APointHash> closed_set_;
};
}  // namespace a_star

#endif  // A_STAR_HPP_