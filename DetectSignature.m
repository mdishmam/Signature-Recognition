clc
 clear all;

dat = imread('test/test4.jpg');
dat = rgb2gray(dat);
dat = imbinarize(dat,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
dat = 1-dat;
dat = bwareaopen(dat,100);

[tRow, tCol] = size(dat);

%Edge Cutting
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
%End of edge cutting


dat = imresize(dat, [80 300]);
imshow(dat);

load templates;

comp=[];
sz = size(templates,2);

 for n=1:sz
    
    sem=corr2(templates{1,n},dat);
    comp=[comp sem];
    
    %pause(1)
 end
 
 average = [];
 sum = 0;
 threshold = 0.15;
 count = 0;
 pos = 0;
 for i = 1:5:sz
     for j = i:i+5
         pos = (floor(i/5)+1);
         sum = sum+comp((i-1)+pos);
        
     end
      average = [average (sum/5)];
      sum = 0;
      if average(pos)>=threshold
%           sprintf("Signature matched with %d",pos);
          count = count + 1;
          break;
      end
 end

 Sig_Template;
 global clients
 
 if count == 0
     sprintf("Signature did not match");
 else
     name = clients(pos);
     sprintf("Signature matched with %s",name);
 end
 ans
 
         
 
