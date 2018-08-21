clc;
clear all;
close all;

cd_pre=double(imread('1000.bmp'));
cd=double(imread('1001.bmp'));
current=double(imread('1500.bmp'));

[row,col]=size(cd);
cd1=zeros(row,col);
diff=zeros(row,col);
result=zeros(row,col);
result1=zeros(row,col);
variance=zeros(row,col);

b=0.08;
    
for i=1:row
    for j=1:col
       variance(i,j)=var([cd_pre(i,j),cd(i,j)]);             
    end;
end;

for k=1200:1500
%     sum=0.0;
        for i=1:row
            for j=1:col
                cd1(i,j)=(1-b)*(cd1(i,j))+((b)*cd(i,j));      %----register a background using 50 frames.
                cd1(i,j)=cd1(i,j)+sign(cd(i,j)-cd1(i,j));  
                diff(i,j)=abs(cd(i,j)-cd1(i,j));
                variance(i,j)=variance(i,j)+sign(4*diff(i,j)-variance(i,j));
                variance(i,j)=var([cd1(i,j),cd(i,j)]);
            end;
        end;
    in=strcat(num2str(k),'.bmp');
    cd= double(imread(in));
end;

for i=1:row
    for j=1:col
        if(diff(i,j)>variance(i,j));                                     %----------taking difference and thresholding.
              result1(i,j)=255;
        else
              result1(i,j)=0;
        end;             
    end;
end;

subplot(321); imshow(uint8(cd_pre));title('first frame')
subplot(322); imshow(uint8(current));title('Last Frame')
subplot(323); imshow(uint8(cd1));title('Estimated background ')
subplot(324); imshow(uint8(variance));title('varience image')
subplot(325); imshow(uint8(diff));title('diff mask')
subplot(326); imshow(imcomplement(uint8(result1)));title('final Result')
