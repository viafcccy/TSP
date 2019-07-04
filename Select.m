function SelCh = Select(Chrom,FitnV,GGAP)
%输入：
%Chrom 种群
%FitnV 适应度值
%GGAP 选择概率
%输出：
%SelCh 被选择的个体
NIND = size(Chrom,1);%种群个体总数
NSel = max(floor(NIND * GGAP+.5),2);%确定下一代种群的个体数，如果不足二个就计为二个
ChrIx = Sus(FitnV,NSel);
SelCh = Chrom(ChrIx,:);