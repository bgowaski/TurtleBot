function ObstacleAvoidance( robot, velmsg, laser)
%OBSTACLEAVOIDANCE Summary of this function goes here
go = true;

velmsg.Linear.X = -0.2;
velmsg.Angular.Z = 0;
send(robot, velmsg);

while(go)
    
    velmsg.Linear.X = 0;
    velmsg.Angular.Z = pi/2;
    tic; 
    while(toc < 1);
        send(robot, velmsg);
    end
    
    velmsg.Linear.X = 0.2;
    velmsg.Angular.Z = 0;
    tic; 
    while(toc < 3);
        send(robot, velmsg);
    end
    
    velmsg.Linear.X = 0;
    velmsg.Angular.Z = -pi/2;
    tic; 
    while(toc < 1);
        send(robot, velmsg);
    end
    
    go = ~checkClear(laser);
end
end

