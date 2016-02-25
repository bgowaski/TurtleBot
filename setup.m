function [robot, velmsg, laser] = setup(ROS_IP_ADDRESS, MY_IP_ADDRESS)
%[robot, velmsg, laser] = setup('10.101.84.35','10.102.155.225');
setenv('ROS_MASTER_URI',strcat('http://',ROS_IP_ADDRESS,':11311'))
setenv('ROS_IP',MY_IP_ADDRESS)
rosinit
rosnode list
end