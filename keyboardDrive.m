function keyboardDrive()
    %map = robotics.BinaryOccupancyGrid(40,40,20);
    %map.GridLocationInWorld = [-20 -20];
    robot = rospublisher('/mobile_base/commands/velocity');
    velmsg = rosmessage(robot);
    %laser = rossubscriber('/scan');
    odom = rossubscriber('/odom');
    keyObj = ExampleHelperTurtleBotKeyInput();
    
    disp('Keyboard Control: ');
    disp('i=forward, k=backward, j=left, l=right');
    disp('q=quit');
    disp('Waiting for input: ');
    
    % Use ASCII key representations for reply, initialize here
    reply = 0;
    
    while reply~='q'
        
        forwardV = 0;   % Initialize linear and angular velocities
        turnV = 0;
        
        reply = getKeystroke(keyObj);
        switch reply
            case 'i'         % i
                forwardV = 0.2;
            case 'k'     % k
                forwardV = -0.2;
            case 'j'     % j
                turnV = 1;
            case 'l'     % l
                turnV = -1;
        end
        
        %scan2map(odom, laser, map);
        velmsg.Linear.X = forwardV
        velmsg.Angular.Z = turnV;
        send(robot, velmsg);
        %show(map);
        %newMap = map;
        odom_data = receive(odom);
        disp(odom_data.Pose.Pose.Position);
    end
end