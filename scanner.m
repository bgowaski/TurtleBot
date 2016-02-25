function [] = scanner(laser)
tic;
while toc < 20
    scan = receive(laser,1)
    plot(scan)
end

end