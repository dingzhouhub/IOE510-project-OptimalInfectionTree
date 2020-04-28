set N;
set I;
set O;
set LINKS within (N cross N);
set LINKS_I within (I cross I);


param p{N,N};
param t{N};
param dt{N,N};
param tmax;
param lambda;
param T;

var dtqsum{N};
var x{LINKS} binary;

maximize looklihood:  sum {(i,j) in LINKS} x[i,j]*(log(p[i,j])-log(1-p[i,j])+dtqsum[j]);

subject to sum_of_dtq{j in N}: dtqsum[j]=sum {(j,i) in LINKS} dt[j,i]*log(1-p[j,i]);
subject to const47{(i,j) in LINKS_I}: tmax*(x[i,j]-1)<=t[j]-t[i]-1;
subject to const48{(i,j) in LINKS_I}: tmax*(1-x[i,j])+lambda>=t[j]-t[i];
subject to const49{i in (I diff O)}: sum {(j,i) in LINKS} x[j,i]=1;
