

input=imread('1.png');
input1=imread('127.png');

[row,col]=size(input);

diff=zeros(row,col);
mask=zeros(row,col);

for i=1:row
    for j=1:col
        diff(i,j)=abs(input(i,j)-input1(i,j));
        if(diff(i,j)>25) 
            mask(i,j)=255;
        else
            mask(i,j)=0;
        end;
    end;
end;

subplot(221);imshow(input);title('Fixed Background')
subplot(222);imshow(input1);title('current Frame')
subplot(223);imshow(uint8(mask));title('resultant mask')






