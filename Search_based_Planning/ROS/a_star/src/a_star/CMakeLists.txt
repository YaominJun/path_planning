cmake_minimum_required(VERSION 2.8.3)
project(a_star)

## Compile as C++11, supported in ROS Kinetic and newer
add_definitions(-std=c++11 -w)
set(CMAKE_CXX_FLAGS " -Wall -Wextra ${CMAKE_CXX_FLAGS}")
set(CMAKE_BUILD_TYPE "Release")

set(catkin_deps
        roscpp
        grid_map_ros
        ros_viz_tools
        )

find_package(catkin REQUIRED COMPONENTS
        ${catkin_deps}
        )

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")

message(STATUS "CMAKE SOURCE DIR:" ${CMAKE_MODULE_PATH})

find_package(Eigen3 REQUIRED)
find_package(OpenCV 3 REQUIRED)
find_package(gflags REQUIRED)

catkin_package(
        INCLUDE_DIRS include
        LIBRARIES ${PROJECT_NAME}
        CATKIN_DEPENDS ${catkin_deps}
        DEPENDS OpenCV
)

include_directories(
        include
        ${OpenCV_INCLUDE_DIRS}
        ${catkin_INCLUDE_DIRS}
        ${EIGEN3_INCLUDE_DIR}
)

add_library(${PROJECT_NAME}
        src/tools/tools.cpp
        src/ros_related/ros_related.cpp
        src/a_star/a_star.cpp
        src/config/planning_flags.cpp
        # include/a_star/config/planning_flags.hpp
        src/data_struct/data_struct.cpp
)
target_link_libraries(${PROJECT_NAME} glog gflags ${catkin_LIBRARIES}
        )

add_executable(${PROJECT_NAME}_demo
        src/test/demo.cpp)
target_link_libraries(${PROJECT_NAME}_demo
        ${PROJECT_NAME} ${OpenCV_LIBRARIES}
        )

install(
        TARGETS ${PROJECT_NAME} ${PROJECT_NAME}_demo
        EXPORT ${PROJECT_NAME}Export
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY include/${PROJECT_NAME}/
        DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
        )

install(DIRECTORY
        config launch
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
        )

install(FILES
        gridmap.png
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
        )