//
// Created by lym on 21-2-16
//

#include "a_star/ros_related/ros_related.hpp"
#include "a_star/a_star.hpp"

int main(int argc, char **argc) {
    ros::init(argc, argv, "a_star");
    ros::NodeHandle nh("~");

    std::string base_dir = ros::package::getPath("a_star");
    auto log_dir = base_dir + "/log";
    if (0 != access(log_dir.c_str(), 0)) {
        // if this folder not exist, create a new one.
        mkdir(log_dir.c_str(), 0777);
    }

    google::InitGoogleLogging(argv[0]);
    FLAGS_colorlogtostderr=true;
    FLAGS_stderrthreshold = google::INFO;
    FLAGS_log_dir = log_dir;
    FLAGS_logbufsecs = 0;
    FLAGS_max_log_size = 100;
    FLAGS_stop_logging_if_full_disk = true;

    // Initialize grid map from image.
    std::string image_dir = ros::package::getPath("a_star");
    std::string image_file = "gridmap.png";
    image_dir.append("/" + image_file);
    cv::Mat img_src = cv::imread(image_dir, CV_8UC1);
    double resolution = 0.2;  // in meter
    grid_map::GridMap grid_map(std::vector<std::string>{"obstacle"});
    grid_map::GridMapCvConverter::initializeFromImage(
        img_src, resolution, grid_map, grid_map::Position::Zero());
    // Add obstacle layer.
    unsigned char OCCUPY = 0;
    unsigned char FREE = 255;
    grid_map::GridMapCvConverter::addLayerFromImage<unsigned char, 1>(
        img_src, "obstacle", grid_map, OCCUPY, FREE, 0.5);
    grid_map.setFrameId("/map");

    // Set publishers.
    ros::Publisher map_publisher =
        nh.advertise<nav_msgs::OccupancyGrid>("grid_map", 1, true);
    // Set publishers.
    // ros::Subscriber map_sub = nh.subscribe("/map", 1, mapCb);
    ros::Subscriber start_sub = nh.subscribe("/initialpose", 1, startCb);
    ros::Subscriber end_sub = nh.subscribe("/move_base_simple/goal", 1, goalCb);

    // Markers initialization.
    ros_viz_tools::RosVizTools markers(nh, "markers");
    std::string marker_frame_id = "/map";

    std::string heuristic_type{"euclidean"};  // manhattan; euclidean;

    // Loop.
    ros::Rate rate(30.0);
    while (nh.ok()) {
        ros::Time time = ros::Time::now();

        markers.clear();
        int id = 0;
        showStartAndGoal(markers, marker_frame_id, id);

        // Calculate.
        std::vector<astar::State> final_path;
        if (start_state_rcv && end_state_rcv) {
            astar::AStar a_star(start_state, end_state, grid_map, heuristic_type);
            if (a_star->searching(&final_path)) {
                ROS_INFO("searching successed!");
            }
        }
        
        showResultPath(markers, marker_frame_id, final_path, id);

        // Publish the grid_map.
        grid_map.setTimestamp(time.toNSec());
        nav_msgs::OccupancyGrid message;
        grid_map::GridMapRosConverter::toOccupancyGrid(
            grid_map, "obstacle", FREE, OCCUPY, message);
        map_publisher.publish(message);

        // Publish markers.
        markers.publish();
        LOG_EVERY_N(INFO, 20) << "map published.";

        // Wait for next cycle.
        ros::spinOnce();
        rate.sleep();
    }
    
    google::ShutdownGoogleLogging();
    return 0;
}