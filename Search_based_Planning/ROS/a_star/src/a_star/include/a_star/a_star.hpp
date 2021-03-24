//
// Created by lym on 21-2-16
//

#ifndef A_STAR_HPP_
#define A_STAR_HPP_

#include "a_star/data_struct/data_struct.hpp"
#include "a_star/tools/tools.hpp"
#include "a_star/config/planning_flags.hpp"
#include "glog/logging.h"
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
#include <cmath>

namespace astar {

class State;
class CollisionChecker;

class AStar {
 public:
    AStar() = delete;
    AStar(const State& start_state,
          const State& end_state,
          const nav_msgs::OccupancyGrid::Ptr& map,
          const std::string& heuristic_type);
    ~AStar();
    AStar(const AStar& astar) = delete;
    AStar& operator=(const AStar& astar) = delete;

    bool searching(std::vector<State>* final_path);

 private:
    inline double getStepCost(const APoint &parent, const APoint &point) const;
    inline double getG(const APoint& parent, const APoint& point) const;
    inline double getH(const APoint& p) const;
    inline bool checkExistenceInClosedSet(const APoint& point) const;
    void updateNeighbor(const APoint& p);
    bool isCollision(const Eigen::Vector2d &pos) const;
    void extractPath(const APoint* goalpoint);

    const grid_map::GridMap& map_;
    double resolution_;
    CollisionChecker* collision_checker_;
    std::string heuristic_type_;
    std::vector<APoint> sampled_points_;
    std:vector<vector<int>> motion_set_;
    State start_state_;
    State end_state_;
    std::priority_queue<APoint*, std::vector<APoint*>, PointComparator> open_set_;
    std::unordered_set<const APoint*> closed_set_;

};
}  // namespace astar

#endif  // A_STAR_HPP_