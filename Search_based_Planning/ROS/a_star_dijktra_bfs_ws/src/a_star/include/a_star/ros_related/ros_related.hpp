//
// Created by lym on 21-2-16
//

#ifndef ROS_RELATED_HPP_
#define ROS_RELATED_HPP_

#include "a_star/data_struct/data_struct.hpp"
#include "a_star/tools/tools.hpp"
#include "a_star/config/planning_flags.hpp"
#include "glog/logging.h"
#include <ros/ros.h>
#include <ros/package.h>
#include <ros/package.h>
#include "nav_msgs/OccupancyGrid.h"
#include <tf/tf.h>

#include <geometry_msgs/PointStamped.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <ros_viz_tools/ros_viz_tools.h>


// A pointer to the grid the planner runs on
nav_msgs::OccupancyGrid::Ptr gridmap;
a_star::State start_state, end_state;
bool start_state_rcv = false, end_state_rcv = false;

namespace a_star {

class State;

void mapCb(const nav_msgs::OccupancyGrid::Ptr map_data);
void startCb(const geometry_msgs::PoseWithCovarianceStampedConstPtr& start);
void goalCb(const geometry_msgs::PoseStampedConstPtr& goal);

void showStartAndGoal(ros_viz_tools::RosVizTools& markers, const std::string& marker_frame_id, int& id);
void showResultPath(ros_viz_tools::RosVizTools& markers, const std::string& marker_frame_id, std::vector<State>& final_path, int& id);
void showCloseSet(ros_viz_tools::RosVizTools& markers, const std::string& marker_frame_id, const std::unordered_set<APoint, APointHash>& closed_set, int& id);

}  // namespace a_star

#endif  // ROS_RELATED_HPP_