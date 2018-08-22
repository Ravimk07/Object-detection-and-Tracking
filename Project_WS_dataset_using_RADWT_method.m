clc;
clear all;
close all;


% cd_pre=double(imread('1400.png'));
cd=double(imread('1500.png'));
a=cd;
current=double(imread('1616.png'));
gt=double(imread('1.bmp'));
b=.05;
[row,col]=size(cd);
% row=row+4;
% col=col+4;
mean_image=zeros(row,col);
% dct_mat=zeros(1,64);
dct_mat=zeros(row,col);
diff=zeros(row,col);
mask=zeros(row,col);
% orignal=zeros(row,col);
dct_mat_new=zeros(row,col);
dct_coe=zeros(8,8);
tp=0;
fp=0;
fn=0;

for k=1300:1450
% for i=1:row
%     for j=1:col
         [aa,ah,av,ad]=dwt2(cd,'haar');
         dct_mat=[aa ah;av ad];
         dct_mat_new = ((b.*dct_mat)+(1-b).*dct_mat)+dct_mat_new;
%     end;
% end;

    in=strcat(num2str(k),'.png');
    cd= double(imread(in));
end;


ba=dct_mat_new(1:row/2,1:col/2);
bv=dct_mat_new(1+(row/2):row,1:col/2);
bh=dct_mat_new(1:row/2,1+(col/2):col);
bd=dct_mat_new(1+(row/2):row,1+(col/2):col);
back=idwt2(ba,bh,bv,bd,'haar');
% back=idwt2(ba,'haar');
m=max(max(back));
back=(back./m).*255;
imshow(uint8(back));

for i=1:row
    for j=1:col
       diff(i,j) = abs(current(i,j)-back(i,j));
            if(diff(i,j)>90) 
                 mask(i,j)=255;
            else
                 mask(i,j)=0;
            end;
    end;
end;
imshow(uint8(mask));

for i=1:row
    for j=1:col
        if((gt(i,j)==255) && (mask(i,j)==255))
             tp=tp+1;    %----true positive pixel i.e detected mask of moving object.
        elseif((gt(i,j)==255))
            fn=fn+1;     %----false negative pixel i.e part of moving object but not detected.
        elseif(mask(i,j)==255)
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

subplot(221);imshow(uint8(a));title('First Frame ')
subplot(222);imshow(uint8(current));title('Last Frame')
subplot(223);imshow((back),[]);title('Estimated background ')
subplot(224);imshow((mask));xlabel(['F1 = ',num2str(F1),', similarity = ',num2str(similarity)]);title('Generated mask ')

% imshow(orignal,[]);


