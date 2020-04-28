set N;
set I;
set O;
set LINKS within (N cross N);
set LINKS_1 within (I cross I);
set LINKS_I within (I cross I);
set LINKS_const3738 within (N cross N);

param p{N,N};
param tmax;
param lambda;
param T;
param M;
param x{LINKS_I};

var dtqsum{N};
var dt{LINKS}>=1 integer;
var t{I}>=1 integer;
var s{I}>=0 integer;

maximize step2:  sum {(i,j) in LINKS_1} dtqsum[j];

subject to dt_define{(i,j) in LINKS_1}: dt[i,j]=t[j]-t[i];
subject to sum_of_dtq{j in N}: dtqsum[j]=sum {(j,i) in LINKS} dt[j,i]*log(1-p[j,i]);
subject to const37{(i,j) in LINKS_const3738}: dt[i,j]>=lambda-s[i]*M;
subject to const38{(i,j) in LINKS_const3738}: dt[i,j]>=T-t[i]-(1-s[i])*M;
subject to const39{i in I}: t[i]>=s[i]*(T-lambda);
subject to const40{i in I}: t[i]<=T-(1-s[i])*lambda;
subject to const41{(i,j) in LINKS_I}: tmax*(x[i,j]-1)<=t[j]-t[i];
subject to const42{(i,j) in LINKS_I}: tmax*(1-x[i,j])+lambda>=t[j]-t[i];
subject to tf1: t[8]=1;
subject to tf2: t[15]=3;
subject to tf3: t[4]=5;
subject to tregion{i in I}: t[i]<=tmax;