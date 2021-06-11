im = imread('CT.png');
im = rgb2gray(im);

sigma = 1;
radius = 1;
order = 2*radius+1;
threshold = input('��������ֵ��');


% ��x��y�����ϵ��ݶ�
[dx, dy] = meshgrid(-1:1 , -1:1);

Ix = conv2(double(im),dx,'same');
Iy = conv2(double(im),dy,'same');

dim = max(1, fix(6*sigma));
m = dim; n = dim;

[h1, h2] = meshgrid(-(m-1)/2: (m-1)/2 , -(n-1)/2: (n-1)/2);
hg = exp(-(h1.^2+h2.^2)/(2*sigma^2));
[a, b] = size(hg);
sum = 0;
for i=1:a
    for j=1:b
        sum = sum+hg(i,j);
    end
end

g = hg./sum;

% ����M����
Ix2 = conv2(double(Ix.^2), g,'same');
Iy2 = conv2(double(Iy.^2), g,'same');
Ixy = conv2(double(Ix.*Iy), g,'same');

% harris����
R = (Ix2.*Iy2 - Ixy.^2) ./ (Ix2+Iy2+eps);

% �ֲ���ֵ
mx = ordfilt2(R, order^2,ones(order));

harris_points = (R == mx) & (R > threshold);

[rows, cols] = find(harris_points);

figure,imshow(im,[],'border','tight','initialmagnification','fit') ,hold on,
plot(cols, rows, 'rs'), title('Harris points');







