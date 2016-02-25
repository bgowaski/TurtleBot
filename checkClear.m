function [ clear ] = checkClear(laser )
%CHECKCLEAR Summary of this function goes here
% Collect information from laser scan
  scan = receive(laser);
  plot(scan);
  data = readCartesian(scan);
  x = data(:,1);
  y = data(:,2);
  % Compute distance of the closest obstacle
  dist = sqrt(x.^2 + y.^2);
  minDist = min(dist);
  % Command robot action
  if minDist < 0.6
      clear = false;
  else
      clear = true;
  end

end

