function DrawPath(Chrom,X)
%输入：
%待画路线
%城市的坐标位置
%输出：
%旅行商的路线

R =  [Chrom(1,:) Chrom(1,1)]; %第一个随机解（个体）【Chrom(1,:)取第一行数据】，一共有n个城市，但是这里R有n+1个值，因为后面又补了一个Chrom(1,1)，“是为了让路径最后再回到起点”
figure;
hold on
plot(X(:,1),X(:,2),'bo')%X(:,1)，X(:,2)分别代表的X轴坐标和Y轴坐标
%plot(X(:,1),X(:,2),'o','color',[1,1,1])%X(:,1)，X(:,2)分别代表的X轴坐标和Y轴坐标，
plot(X(Chrom(1,1),1),X(Chrom(1,1),2),'rv','MarkerSize',20)%标记起点
A = X(R,:);                         %A是将之前的坐标顺序用R打乱后重新存入A中
row = size(A,1);                    %row为坐标数+1
for i = 2:row
    [arrowx,arrowy] = dsxy2figxy(gca,A(i-1:i,1),A(i-1:i,2));    %dsxy2figxy坐标转换函数，记录两个点
    annotation('textarrow',arrowx,arrowy,'HeadWidth',8,'color',[0,0,1]);%将这两个点连接起来
end
hold off
xlabel('横坐标x')
ylabel('纵坐标y')
title('旅行商轨迹图')
box on