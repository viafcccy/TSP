function p=OutputPath(R)
%打印路线函数
%以1->2->3的形式在命令行打印路线

R = [R,R(1)];
N = length(R);
p = num2str(R(1));
for i = 2:N
    p = [p,'->',num2str(R(i))];
end
disp(p)