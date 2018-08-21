clc;
clear all;
close all;

cd=double(imread('1.png'));
a=cd;
current=double(imread('127.png'));

[row,col]=size(a);
b=0.05;
cd1=zeros(row,col);
diff=zeros(row,col);
result=zeros(row,col);
cd=a;

tic;
for k=1:100
    cd1=((1-b).*cd1)+(b.*cd);
    in=strcat(num2str(k),'.png');
    cd=double(imread(in));
    %disp(['image no',num2str(k)]);
end;

    x=abs(current-cd1);

for i=1:row
    for j=1:col
%          diff(i,j)=abs(current(i,j)-cd1(i,j));
%         x=diff(i,j);
        if(x(i,j)>20)                                      %--taking difference and thresholding.
            result(i,j)=1;
        else
            result(i,j)=0;
        end;
    end;
end;
tm=toc;

subplot(221);imshow(uint8(cd1));title('Registered background image')
subplot(222);imshow(uint8(current));title('Orignal image')
subplot(223);imshow(result);title('Detecetd mask image')
% subplot(224);imshow(result);

