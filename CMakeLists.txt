cmake_minimum_required(VERSION 3.1)
project(xsens_mti_driver)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/CMakeModules)
set(CMAKE_CXX_STANDARD 11)

# Use MTSDK_PREFIX if mtsdk is not installed in its standard directory
find_package(mtsdk REQUIRED COMPONENTS xstypes xsensdeviceapi)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  tf2
  tf2_ros
  std_msgs
  geometry_msgs
  sensor_msgs
)

catkin_package(
  CATKIN_DEPENDS
  roscpp
  tf2
  tf2_ros
  sensor_msgs
  std_msgs
  geometry_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

add_executable(
	xsens_mti_node
	src/main.cpp
	src/xdainterface.cpp
	src/xdacallback.cpp
)
target_link_libraries(
	xsens_mti_node
  PUBLIC
	${catkin_LIBRARIES}
)
target_link_libraries(xsens_mti_node PUBLIC mtsdk::xstypes mtsdk::xsensdeviceapi)
