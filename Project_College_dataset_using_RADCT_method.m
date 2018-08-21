clc;
clear all;
close all;
b=input('block size: ');
cd=double(imread('1.png'));
gt=double(imread('1.bmp'));
a=cd;
current=double(imread('127.png'));
imshow((gt));
[row ,col]=size(cd);
d=zeros(b,b);
d1=zeros(b,b);
dct_mat=zeros(b,b);
diff=zeros(row,col);
mask=zeros(row,col);
% back=zeros(row,col);

y_new=zeros(row,col);
tp=0;
fp=0;
fn=0;
b1=.05;

for k=1:100
    for i=1:b:row
        for j=1:b:col
            d=cd(i:i+b-1,j:j+b-1);
            dct_mat=dct2(d);
            y(i:i+b-1,j:j+b-1)=((dct_mat));
   
        end;
    end;
        y_new = ((b1.*y_new)+(1-b1).*y)+y_new;
         in=strcat(num2str(k),'.png');
         cd= double(imread(in));
end;       
% y_new=y_new./8;

for i=1:b:row
    for j=1:b:col
        d1=y_new(i:i+b-1,j:j+b-1);
        y1(i:i+b-1,j:j+b-1)=(idct2(d1));
%         z(i:i+b-1,j:j+b-1)=idct2(y);
    end;
end;

y1=y1./(max(max(y1)));
back=(y1.*255);
imshow(uint8(back));
% back=abs(y1-cd);
 
for i=1:row
    for j=1:col
        diff(i,j) = abs(current(i,j)-back(i,j));
            if(diff(i,j)>24)     %-----------update while changing database.
                 mask(i,j)=255;
            else
                 mask(i,j)=0;
            end;
                
    end;
end;

mask = im2bw(mask);

for i=1:row
    for j=1:col
        if((gt(i,j)==1) && (mask(i,j)==1))
             tp=tp+1;    %----true positive pixel i.e detected mask of moving object.
        elseif((gt(i,j)==1))
            fn=fn+1;     %----false negative pixel i.e part of moving object but not detected.
        elseif(mask(i,j)==1)
            fp=fp+1;
        end;
       
    end;
end;

recall=tp/(tp+fn);
disp(recall);

precision=tp/(tp+fp);
disp(precision);

F1=2*(recall)*(precision)/(recall+precision);
disp('F1 test =');
disp(F1);
similarity=tp/(tp+fp+fn);
disp('Similarity =');
disp(similarity);

subplot(221);imshow(uint8(current));title('current frame  ')
subplot(222);imshow(double(gt));title('Ground truth')
subplot(223);imshow(uint8(back));title('Background')
subplot(224);imshow((mask),[]);xlabel(['F1 = ',num2str(F1),', similarity = ',num2str(similarity)]);title('Generated mask ')


