function D = Distance(a)
%计算两两城市之间的距离
%输入的数据为所有城市的x、y坐标位置矩阵a，输出为两两城市的距离构成的矩阵D

row = size(a,1);
D = zeros(row,row);
for i = 1:row
    for j = i+1:row
        D(i,j) = ((a(i,1) - a(j,1))^2 + (a(i,2)-a(j,2))^2)^0.5;
        D(j,i) = D(i,j);
    end
end