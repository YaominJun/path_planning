//
// Created by lym on 21-2-16
//

#include "a_star/ros_related/ros_related.hpp"
#include <cstdlib>

namespace a_star {
void mapCb(const nav_msgs::OccupancyGrid::Ptr map_data) {
    gridmap = map_data;
}

void startCb(const geometry_msgs::PoseWithCovarianceStampedConstPtr& start) {
    start_state.x = static_cast<int>(start->pose.pose.position.x);
    start_state.y = static_cast<int>(start->pose.pose.position.y);
    start_state.z = tf::getYaw(start->pose.pose.orientation);
    start_state_rcv = true;
    ROS_INFO("get initial state.");
}

void goalCb(const geometry_msgs::PoseStampedConstPtr& goal) {
    end_state.x = static_cast<int>(goal->pose.position.x);
    end_state.y = static_cast<int>(goal->pose.position.y);
    end_state.z = tf::getYaw(goal->pose.orientation);
    end_state_rcv = true;
    ROS_INFO("get the goal.");
}

void showStartAndGoal(ros_viz_tools::RosVizTools& markers, 
                      const std::string& marker_frame_id, int& id) {
    geometry_msgs::Vector3 scale;
    scale.x = 2.0;
    scale.y = 0.3;
    scale.z = 0.3;
    geometry_msgs::Pose start_pose;
    start_pose.position.x = start_state.x;
    start_pose.position.y = start_state.y;
    start_pose.position.z = 1.0;
    auto start_quat = tf::createQuaternionFromYaw(start_state.z);
    start_pose.orientation.x = start_quat.x();
    start_pose.orientation.y = start_quat.y();
    start_pose.orientation.z = start_quat.z();
    start_pose.orientation.w = start_quat.w();
    visualization_msgs::Marker start_marker =
        markers.newArrow(scale, start_pose, "start point", id++, ros_viz_tools::CYAN, marker_frame_id);
    markers.append(start_marker);
    geometry_msgs::Pose end_pose;
    end_pose.position.x = end_state.x;
    end_pose.position.y = end_state.y;
    end_pose.position.z = 1.0;
    auto end_quat = tf::createQuaternionFromYaw(end_state.z);
    end_pose.orientation.x = end_quat.x();
    end_pose.orientation.y = end_quat.y();
    end_pose.orientation.z = end_quat.z();
    end_pose.orientation.w = end_quat.w();
    visualization_msgs::Marker end_marker =
        markers.newArrow(scale, end_pose, "end point", id++, ros_viz_tools::CYAN, marker_frame_id);
    markers.append(end_marker);
}

void showResultPath(ros_viz_tools::RosVizTools& markers, 
                    const std::string& marker_frame_id, 
                    std::vector<State>& final_path, int& id) {
    // Visualize result path.
    visualization_msgs::Marker result_marker =
        markers.newLineStrip(0.15, "final path", id++, ros_viz_tools::GREEN, marker_frame_id);
    for (size_t i = 0; i != final_path.size(); ++i) {
        geometry_msgs::Point p;
        p.x = final_path[i].x;
        p.y = final_path[i].y;
        p.z = 1.0;
        result_marker.points.push_back(p);
    }
    markers.append(result_marker);

    // visualization_msgs::Marker vehicle_geometry_marker =
    //     markers.newLineList(0.05, "vehicle", id++, ros_viz_tools::GRAY, marker_frame_id);
    // // Visualize vehicle geometry.
    // static const double length{FLAGS_car_length};
    // static const double width{FLAGS_car_width};
    // static const double rtc{FLAGS_rear_axle_to_center};
    // static const double rear_d{length / 2 - rtc};
    // static const double front_d{length - rear_d};
    // for (size_t i = 0; i != final_path.size(); ++i) {
    //     double heading = final_path[i].z;
    //     a_star::State p1, p2, p3, p4;
    //     p1.x = front_d;
    //     p1.y = width / 2;
    //     p2.x = front_d;
    //     p2.y = -width / 2;
    //     p3.x = -rear_d;
    //     p3.y = -width / 2;
    //     p4.x = -rear_d;
    //     p4.y = width / 2;
    //     auto tmp_relto = final_path[i];
    //     tmp_relto.z = heading;
    //     p1 = a_star::local2Global(tmp_relto, p1);
    //     p2 = a_star::local2Global(tmp_relto, p2);
    //     p3 = a_star::local2Global(tmp_relto, p3);
    //     p4 = a_star::local2Global(tmp_relto, p4);
    //     geometry_msgs::Point pp1, pp2, pp3, pp4;
    //     pp1.x = p1.x;
    //     pp1.y = p1.y;
    //     pp1.z = 0.1;
    //     pp2.x = p2.x;
    //     pp2.y = p2.y;
    //     pp2.z = 0.1;
    //     pp3.x = p3.x;
    //     pp3.y = p3.y;
    //     pp3.z = 0.1;
    //     pp4.x = p4.x;
    //     pp4.y = p4.y;
    //     pp4.z = 0.1;
    //     vehicle_geometry_marker.points.push_back(pp1);
    //     vehicle_geometry_marker.points.push_back(pp2);
    //     vehicle_geometry_marker.points.push_back(pp2);
    //     vehicle_geometry_marker.points.push_back(pp3);
    //     vehicle_geometry_marker.points.push_back(pp3);
    //     vehicle_geometry_marker.points.push_back(pp4);
    //     vehicle_geometry_marker.points.push_back(pp4);
    //     vehicle_geometry_marker.points.push_back(pp1);
    // }
    // markers.append(vehicle_geometry_marker);   
}

void showCloseSet(ros_viz_tools::RosVizTools& markers, 
                  const std::string& marker_frame_id, 
                  const std::unordered_set<APoint, APointHash>& closed_set, int& id) {
    // Visualize close set
    visualization_msgs::Marker closed_set_marker = 
        markers.newSphereList(0.5, "closed set point", id++, ros_viz_tools::RED, marker_frame_id);
    
    for (auto iter = closed_set.begin(); iter != closed_set.end(); iter++) {
        geometry_msgs::Point p;
        p.x = iter->x;
        p.y = iter->y;
        p.z = 1.0;
        closed_set_marker.points.push_back(p);
    }
    markers.append(closed_set_marker);
}
}  // namespace a_star