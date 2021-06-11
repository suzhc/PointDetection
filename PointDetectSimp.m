f = imread('C:\Users\160\Desktop\Bishe\CT.png');
f = rgb2gray(f);
[width,height] = size(f);
h = zeros(width,height);
number = input('ÇëÊäÈëãÐÖµ£º');
if number > width*height
    number = width*height;
end
df = im2double(f);
w = [-1 -1 -1;-1 8 -1;-1 -1 -1];
g = imfilter(df,w);
g = abs(g)./8;
[data index]=sort(g(:));
T = data(width*height-number+1);
for i = 1:width
    for j = 1:height
        if g(i,j)>=T
            h(i,j) = 1;
            %h(i,j) = g(i,j);
        end
    end
end

[rows, cols] = find(h);
figure,imshow(f,[],'border','tight','initialmagnification','fit') ,hold on,
plot(cols, rows, 'rs'), title('points');
