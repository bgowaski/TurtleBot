function [ pose ] = currentPose( odom )
%CURRENTPOSE Summary of this function goes here
%   Detailed explanation goes here

odom_data = receive(odom);

x = odom_data.Pose.Pose.Position.X;
y = odom_data.Pose.Pose.Position.Y;
orientation = odom2eul(odom_data.Pose.Pose.Orientation);
z = orientation(1);

pose = [x y z];

end

