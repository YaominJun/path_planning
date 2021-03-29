//
// Created by lym on 21-2-16
//

#include "a_star/a_star.hpp"

namespace a_star {
AStar::AStar(const State& start_state,
             const State& end_state,
             const grid_map::GridMap& map,
             const std::string& heuristic_type)
    : start_state_(start_state),
      end_state_(end_state),
      map_(map), 
      heuristic_type_(heuristic_type) {
    //   collision_checker_(new CollisionChecker(map)),  // TODO: robust collision checker
        motion_set_ = {{-1, 0}, {-1, 1}, {0, 1}, {1, 1}, 
                    {1, 0}, {1, -1}, {0, -1}, {-1, -1}};
        resolution_ = map_.getResolution();
      }

AStar::~AStar() {}

bool AStar::searching(std::vector<State>* final_path) {
    if (FLAGS_enable_computation_time_output) std::cout << "------" << std::endl;
    CHECK_NOTNULL(final_path);

    // auto t1 = std::clock();
    std::priority_queue<APoint*, std::vector<APoint*>, PointCmp> open_set_pq;

    APoint start_point;
    start_point.x = start_state_.x;
    start_point.y = start_state_.y;
    start_point.g = 0;
    start_point.h = getH(start_point);
    start_point.parent = nullptr;
    open_set_.insert(start_point);
    open_set_pq.push(&start_point);

    APoint* current_node;
    LOG_EVERY_N(INFO, 20) << "searching started.";
    int count = 0;
    while (!open_set_pq.empty()) {
        count++;
        current_node = open_set_pq.top();
        if (isEqual(current_node, &end_state_)) {
            std::cout << "searching finished." << std::endl;
            // exact result path
            extractPath(current_node, final_path);
            return true;
        }
        open_set_.erase(*current_node);
        open_set_pq.pop();
        closed_set_.insert(*current_node);
        sampled_points_.clear();
        updateNeighbor(current_node, sampled_points_);
        for (auto* child : sampled_points_) {
            // If already exsit in closet set, skip it.
            if (checkExistenceInClosedSet(*child)) {
                continue;
            }
            double new_cost = getG(*current_node, *child) + getH(*child);
            if (!checkExistenceInOpenSet(*child)) {
                open_set_.insert(*child);
                child->g = std::numeric_limits<double>::max();
            }
            if (new_cost < child->g) {
                child->g = new_cost;
                child->parent = current_node;  
                open_set_pq.push(child);
            }
        }
    }
    LOG(ERROR) << "A Star failed!";
    return false;
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
    return closed_set_.find(point) != closed_set_.end();
}

inline bool AStar::checkExistenceInOpenSet(const APoint& point) const {
    return open_set_.find(point) != open_set_.end();
}

void AStar::updateNeighbor(const APoint* p, std::vector<APoint*>& sampled_points) {
    // get the neighbors according to the motion_set_
    for (const auto& motion : motion_set_) {
        APoint* nextnode = new APoint();
        nextnode->x = p->x + motion[0] * resolution_;
        nextnode->y = p->y + motion[1] * resolution_;
        grid_map::Position position(nextnode->x, nextnode->y);
        if (map_.isInside(position)
            && !isCollision(position)) {
            nextnode->g = getG(*p, *nextnode);
            nextnode->h = getH(*nextnode);
            sampled_points.push_back(nextnode);
        }
    }
}

bool AStar::isCollision(const Eigen::Vector2d& pos) const {
    // grid_map::Position is the another name of Eigen::Vector2d
    // check if it's collision
    // 0 - 255, 0 is black, 255 is white
    if (map_.isInside(pos)) {
        return map_.atPosition("obstacle", pos, grid_map::InterpolationMethods::INTER_LINEAR) < FLAGS_collision_epsilon;
    } else {
      return true;
    }
}

void AStar::extractPath(const APoint* goalpoint, std::vector<State>* final_path) {
    final_path->push_back(end_state_);
    const APoint* apoint = goalpoint;
    int count = 0;
    while (apoint != nullptr) {
        count++;
        State state;
        transformState(apoint, &state);
        final_path->push_back(state);
        if (apoint->parent == nullptr || count > 100000) {
            // avoid the path is too long
            break;
        }
        apoint = apoint->parent;
    }
    std::reverse(final_path->begin(), final_path->end());
}

}  // namespace a_star