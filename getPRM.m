function [ prm, map ] = getPRM( image )
%Gets the PRM of the map
    map = genMap(image);
    show(map)
    robotRadius = 0.15;
    mapInflated = copy(map);
    inflate(mapInflated,robotRadius);
    prm = robotics.PRM(mapInflated);
    prm.NumNodes = 300;
    prm.ConnectionDistance = 10;
end

