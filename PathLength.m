function len = PathLength(D,Chrom)
%计算所有个体的路线长度
%输入
%D两两城市之间的距离
%Chrom个体的轨迹

[~,col] = size(D); %返回D的列数
NIND = size(Chrom,1);%NIND等于初始种群
len = zeros(NIND,1);%初始化一个大小等于NOND的len来记录长度
for i = 1:NIND
    p = [Chrom(i,:) Chrom(i,1)];%构造p矩阵保存路线图 将第一行路线提出 再加上第一个构成回路
    i1 = p(1:end-1);%i1从第一个开始遍历到倒数第二个
    i2 = p(2:end);%i2从第二个开始遍历到倒数第一个
    len(i,1) = sum(D((i1-1)*col+i2));%计算出每种路线（初始种群的个体）的长度
end