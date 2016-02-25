function y = scan2map(odom, laser, map)
    odom_data = receive(odom);
    scan = receive(laser,1);

    orientation = odom2eul(odom_data.Pose.Pose.Orientation);

    % The z-direction rotation component is the heading of the
    % robot. Use the heading value along with the z-rotation axis to define
    % the rotation matrix
    rotMatrixAlongZ = axang2rotm([0 0 1 orientation(1)]);
    
    % obtain local XY coordinates for the detected obstacle points
    % in the robot's frame.
    coordsLocal = readCartesian(scan);

    % Convert sensor values (originally in the robot's frame) into the
    % world coordinate frame. This is a 2D coordinate transformation, so
    % only the first two rows and columns are used from the rotation matrix.
    
    % rotation
    coordsWorld = rotMatrixAlongZ(1:2,1:2) * coordsLocal';
    %translation
    dim = size(coordsWorld);
    coordsWorld = coordsWorld' + repmat([odom_data.Pose.Pose.Position.X odom_data.Pose.Pose.Position.Y], dim(2),1);

    % Update map based on laser scan data in the world coordinate frame.
    % Populate the map, using the setOccupancy function, by setting the
    % obstacle location on the map as occupied for every sensor reading that
    % detects obstacles
    setOccupancy(map, coordsWorld, 1);
    
    %count = 1
    show(map)
    
    y = coordsLocal;
end