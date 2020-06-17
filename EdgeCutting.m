clc
close all
clear all

strInp = "16.jpg";
strOp = "Fatin5";

dat = imread(sprintf('%s',strInp));
dat = rgb2gray(dat);

dat = imbinarize(dat,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
dat = 1-dat;
dat = bwareaopen(dat,100);

[tRow, tCol] = size(dat);

%Beginnings Horizontal Edge Cutting
while 1
    tmp = 0;
    for j = 1:tRow
        tmp = tmp + dat(j,1);
    end
    if tmp == 0
        dat(:,1) = [];
    else
        break
    end
    
end

%Endings Horizontal Edge Cutting
dat = imrotate(dat,180);

while 1
    tmp = 0;
    for j = 1:tRow
        tmp = tmp + dat(j,1);
    end
    if tmp == 0
        dat(:,1) = [];
    else
        break
    end
    
end
dat = imrotate(dat,180);

%Top vertical edge cutting
[tRow, tCol] = size(dat);

while 1
    tmp = 0;
    for j = 1:tCol
        tmp = tmp + dat(1,j);
    end
    if tmp == 0
        dat(1,:) = [];
    else
        break
    end
    
end

dat = imrotate(dat,180);
while 1
    tmp = 0;
    for j = 1:tCol
        tmp = tmp + dat(1,j);
    end
    if tmp == 0
        dat(1,:) = [];
    else
        break
    end
    
end
dat = imrotate(dat,180);

imshow(dat); 
imwrite(dat,sprintf('%s%s.jpg','DataSets/',strOp));
% imwrite(dat,strOp);