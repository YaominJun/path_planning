//
// Created by lym on 21-2-16
//

#include "a_star/a_star.hpp"

namespace astar {
AStar::AStar(const State& start_state,
             const State& end_state,
             const nav_msgs::OccupancyGrid::Ptr& map,
             const std::string& heuristic_type)
    : start_state_(start_state),
      end_state_(end_state),
      map_(map), 
      collision_checker_(new CollisionChecker(map)),
      heuristic_type_(heuristic_type) {
        motion_set_{{-1, 0}, {-1, 1}, {0, 1}, {1, 1},
                    {1, 0}, {1, -1}, {0, -1}, {-1, -1}};
        resolution_ = map_.getResolution();
      }

AStar::~AStar() {
    delete map_;
    delete collision_checker_;
}

bool AStar::searching(std::vector<State>* final_path) {
    if (FLAGS_enable_computation_time_output) std::cout << "------" << std::endl;
    CHECK_NOTNULL(final_path);

    auto t1 = std::clock();
    APoint start_point;
    start_point.x = start_state_.x;
    start_point.y = start_state_.y;
    start_point.g = 0;
    start_point.h = getH(start_point);
    start_point.is_in_open_set = true;
    open_set_.push(&start_point);
    APoint* goal_point;
    while (true) {
        if (open_set_.empty()) {
            LOG(ERROR) << "Lattice search failed!";
            break;
            return false;
        }
        auto tmp_point_ptr = open_set_.top();
        if (isEqual(tmp_point_ptr, end_state_)) {
            goal_point = tmp_point_ptr;
            break;
        }
        open_set_.pop();
        closed_set_.insert(tmp_point_ptr);
        sampled_points_.clear();
        updateNeighbor(tmp_point_ptr);
        for (auto& child : sampled_points_) {
            // If already exsit in closet set, skip it.
            if (checkExistenceInClosedSet(child)) {
                continue;
            }
            if (child.is_in_open_set) {
                double new_g = getG(*tmp_point_ptr, child);
                if (new_g < child.g) {
                    child.g = new_g;
                    child.parent = tmp_point_ptr;
                }
            } else {
                child.g = getG(*tmp_point_ptr, child);
                child.h = getH(child);
                child.parent = tmp_point_ptr;
                open_set_.push(&child);
                child.is_in_open_set = true;
            }
        }
    }
    // exact result path
    extractPath(goal_point);
    return true;
}

inline double AStar::getStepCost(const APoint& parent, const APoint& point) const {
    // Calculate Cost for this motion
    return sqrt(pow(parent.x - point.x, 2) + pow(parent.y - point.y, 2));
}

inline double AStar::getG(const APoint& parent, const APoint& point) const {
    // g cost
    return parent.g + getStepCost(parent, point);
}

inline double AStar::getH(const APoint& p) const {
    // Note that this h is neither admissible nor consistent, so the result is not optimal.
    // There is a smoothing stage after this, so time efficiency is much more
    // important than optimality here.
    if (heuristic_type_ == "manhattan") {
        return fabs(end_state_.x - p.x) + fabs(end_state_.y - p.y);
    } else {
        return sqrt(pow(end_state_.x - p.x, 2) + pow(end_state_.y - p.y, 2));
    }
}

inline bool AStar::checkExistenceInClosedSet(const APoint& point) const {
    return closed_set_.find(&point) != closed_set_.end();
}

void AStar::updateNeighbor(const APoint& p) {
    // get the neighbors according to the motion_set_
    APoint nextnode;
    for (const auto& motion : motion_set_) {
        nextnode.x = p.x + motion[0] * resolution_;
        nextnode.y = p.y + motion[1] * resolution_;
        grid_map::Position position(nextnode.x, nextnode.y);
        if (map_.isInside(position)
            && !isCollision(nextnode)) {
            // nextnode.parent = p;
            // nextnode.g = p.g + getStepCost(p, nextnode);
            // nextnode.h = getH(nextnode);
            sampled_points_.push_back(nextnode);
        }
    }
}

bool AStar::isCollision(const Eigen::Vector2d &pos) const {
    // grid_map::Position is the another name of Eigen::Vector2d
    // check if it's collision
    // 0 - 255, 0 is black, 255 is white
    if (map_.isInside(pos)) {
        return map_.atPosition("obstacle", pos, grid_map::InterpolationMethods::INTER_LINEAR) < FLAGS_collision_epsilon;
    } else {
      return true;
    }
}

void AStar::extractPath(const APoint* goalpoint) {
    final_path.push_back(end_state_);
    APoint apoint = goalpoint;
    while (true) {
        apoint = goalpoint->parent;
        State state;
        transformState(apoint, state);
        final_path.push_back(&state);
        if (apoint->parent == nullptr) {
            break;
        }
    }
    std::reverse(final_path.begin(), final_path.end());
}

}  // namespace astar