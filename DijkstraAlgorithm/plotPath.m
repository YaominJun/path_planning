function [vertex,XY,Qlest]=plotPath(flag_find,xTarget,yTarget,xStart,yStart,S,T)
QS=[];QS=[QS,(S.Q)];
XS=[];XS=[XS,S.x];YS=[];YS=[YS,S.y];XY=[XS;YS];
XSF=[];XSF=[XSF,S.father_x];YSF=[];YSF=[YSF,S.father_y];XYF=[XSF;YSF];

xy=find(XS==xTarget&YS==yTarget);
qxy=find(QS(xy)==min(QS(xy)));Qlest=min(QS(xy));
i=xy(qxy(1));vertex=[];vertex=[vertex,i];
while i~=1
    xs=XYF(1,i);ys=XYF(2,i);
    xy=find(XS==xs&YS==ys);
    qxy=find(QS(xy)==min(QS(xy)));
    vertex=[vertex,xy(qxy(1))];
    i=xy(qxy(1));
end
plot(YS,XS,'*');
plot(XY(2,vertex),XY(1,vertex));