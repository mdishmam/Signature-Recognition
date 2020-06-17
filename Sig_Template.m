
clc
% clear all;
global clients
global strOp;

clients = ["Saju","FOX","Fatin","qui"];
qntt = 5;


dat = [];

for i = 1:size(clients,2)
    for j = 1:qntt
        img = imread(sprintf('DataSets/%s%d.jpg',clients(i),j));
        img = imresize(img, [80 300]);
        dat = [dat img];
    end
end

cells = qntt * size(clients,2);

colums = 300 + zeros(1,cells);


templates=mat2cell(dat,80,colums);

save ('templates','templates')
%  clear all