function resetOdom()
    emptyMsg = rosmessage('std_msgs/Empty');
    odom_reset = rospublisher('/mobile_base/commands/reset_odometry');
    send(odom_reset, emptyMsg);
end