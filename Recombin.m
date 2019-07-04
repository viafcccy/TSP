function SelCh = Recombin(SelCh,Pc)
%交叉操作
%输入：
%SelCh 被选择的个体
%Pc    交叉概率
%输出：
%SelCh 交叉后的个体

NSel = size(SelCh,1);
for i = 1:2:NSel - mod(NSel,2)
    if Pc>=rand %交叉概率PC
        [SelCh(i,:),SelCh(i+1,:)] = intercross(SelCh(i,:),SelCh(i+1,:));
    end
end