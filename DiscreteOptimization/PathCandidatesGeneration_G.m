function [x_Candidate,y_Candidate,deta_control]=PathCandidatesGeneration_G(L,l,V,t,x_v,y_v,theta,theta_Gpath,x_G,y_G)
x_GCandidate=[];y_GCandidate=[];
for d=-5:1:5
    for i=1:length(x_G)
        x1=x_G(i)-d*sin(theta_Gpath(i));y1=y_G(i)+d*cos(theta_Gpath(i));
        x_GCandidate=[x_GCandidate,x1];y_GCandidate=[y_GCandidate,y1];
    end
end
x_GCandidate=reshape(x_GCandidate,length(x_G),length(x_GCandidate)/length(x_G));
y_GCandidate=reshape(y_GCandidate,length(y_G),length(y_GCandidate)/length(y_G));
plot(x_GCandidate,y_GCandidate,'b');plot(x_G,y_G,'r--');axis([0 max(x_GCandidate(:)) min(y_GCandidate(:)) max(y_GCandidate(:))]);
[~,column]=size(x_GCandidate);
x_Candidate=[];y_Candidate=[];deta_control=[];
for i=1:column
    x_G=x_GCandidate(:,i);y_G=y_GCandidate(:,i);
    [x_path,y_path,deta]=PurePursuitFun2(L,l,V,t,x_G,y_G,x_v,y_v,theta);
    x_Candidate=[x_Candidate,x_path];y_Candidate=[y_Candidate,y_path];deta_control=[deta_control,deta];
end
x_Candidate=reshape(x_Candidate,length(x_Candidate)/column,column);
y_Candidate=reshape(y_Candidate,length(y_Candidate)/column,column);
deta_control=reshape(deta_control,length(deta_control)/column,column);