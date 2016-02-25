function path_follow(odom, prm)
%'10.101.84.35' - MIKEY IP
%resetOdom;
odom = rossubscriber('/odom');
robot = rospublisher('/mobile_base/commands/velocity');
velmsg = rosmessage(robot);
laser = rossubscriber('/scan');
% prm = getPRM('mapLounge.png')

needPath = true;
visited = 0;

hold on
show(prm, 'Map', 'off', 'RoadMap', 'off');
hold off

controller = robotics.PurePursuit
controller.DesiredLinearVelocity = 0.2;
controller.MaxAngularVelocity = 1;
controller.LookaheadDistance = 0.3;
release(controller)
goalRadius = 0.15;
Locations = [2.5 0.4; 4.25 2.3; 2.15 4.18; -1.46 3.53; 0.0 0.0];
numWaypoints = size(Locations);
numWaypoints = numWaypoints(1);
disp(numWaypoints)

while visited < numWaypoints
    if checkClear(laser)
        if needPath
            release(controller)
            robotCurrentPose = currentPose(odom);
            startLocation = robotCurrentPose(1:2);
            endLocation = Locations((visited+1),:);
            path = findpath(prm, startLocation, endLocation);
            controller.Waypoints = path;
            robotGoal = path(end,:);
            distanceToGoal = norm(startLocation - robotGoal);
            needPath = false;
        end
        if( distanceToGoal > goalRadius )

            robotCurrentPose = currentPose(odom);
            % Compute the controller outputs, i.e., the inputs to the robot
            %[v, omega] = step(controller, robot.CurrentPose);
            [v, omega] = step(controller, robotCurrentPose);

            % Simulate the robot using the controller outputs
            %drive(robot, v, omega)
            velmsg.Linear.X = v;
            velmsg.Angular.Z = omega;
            send(robot, velmsg);

            robotCurrentPose = currentPose(odom);
            % Re-compute the distance to the goal
            distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal);
        else 
            distanceToGoal = 100;
            needPath = true;
            visited = visited + 1;
        end
    else 
        ObstacleAvoidance(robot, velmsg, laser);
        needPath = true;
    end
end

end
