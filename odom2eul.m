% Must send this odom_data.Pose.Pose.Orientation as input
% i.e.: orientation = odom2eul(odom_data.Pose.Pose.Orientation);

function orientationEul = odom2eul(orientationQuat)
    % Define the Quaternion in a vector form
    q = [orientationQuat.W orientationQuat.X orientationQuat.Y orientationQuat.Z];

    % Convert the Quaternion into Euler angles
    orientationEul = quat2eul(q, 'ZYX');
end