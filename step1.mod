set N;
set I;
set O;
set LINKS within (N cross N);

param p{N,N};
param tmax;
param lambda;
param T;

var qsum{N};
var x{LINKS} binary;
var t{N}>=1 integer;

maximize looklihood:  sum {(i,j) in LINKS} x[i,j]*(log(p[i,j])-log(1-p[i,j])+lambda*qsum[j]);

subject to sum_of_q{j in N}: qsum[j]=sum {(j,i) in LINKS} log(1-p[j,i]);
subject to const19{(i,j) in LINKS}: tmax*(x[i,j]-1)<=t[j]-t[i];
subject to const20{(i,j) in LINKS}: tmax*(1-x[i,j])+lambda>=t[j]-t[i];
subject to tf1: t[8]=1;
subject to tf2: t[15]=3;
subject to tf3: t[4]=5;
subject to const22{i in (I diff O)}: sum {(j,i) in LINKS} x[j,i]=1;
subject to const23{i in (N diff I)}: sum {(j,i) in LINKS} x[j,i]<=1;
subject to const24{i in (N diff I),(i,j) in LINKS}: sum {(k,i) in LINKS} x[k,i]>=x[i,j];
