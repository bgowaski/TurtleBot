% run like the following:
% map = genMap('mapLounge.png');

function map = genMap(image)
    imageMat = imread(image);
    imageMat = rgb2gray(imageMat);
    imageMat = imageMat < 0.5;
    map = robotics.BinaryOccupancyGrid(imageMat, 20);
    map.GridLocationInWorld = [-20 -20];
end