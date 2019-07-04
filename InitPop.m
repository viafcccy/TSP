function Chrom = InitPop(NIND,N)%初始化种群，
%输入：
%NIND：种群大小
%N：个体染色体长度（城市个数）
%输出：
%初始种群
Chrom = zeros(NIND,N);  %用于存储种群
for i = 1:NIND
    Chrom(i,:) = randperm(N);%随机生成初始种群,randperm函数的用法是返回一行1~N的整数，这N个数是不同的
end