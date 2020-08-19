function PathCandidate=PathSelect(cost,x_v,y_v,x_Candidate,y_Candidate)
%路径选择
PathCandidate=find(cost==min(cost));
PathCandidate_l=zeros(1,length(PathCandidate));
if length(PathCandidate)>1
    for i=1:length(PathCandidate)
        %候选路径起点终点间斜率与初始车头倾角的差额来代表路径变化率，显然一般情况下是此差额小的，总路程小
        PathCandidate_l(i)=(y_Candidate(end,PathCandidate(i))-y_v)/(x_Candidate(end,PathCandidate(i))-x_v);        
    end
    j=find(abs(PathCandidate_l)-abs(tan(theta))==min(abs(PathCandidate_l)-abs(tan(theta))));
    PathCandidate=PathCandidate(j);
end
