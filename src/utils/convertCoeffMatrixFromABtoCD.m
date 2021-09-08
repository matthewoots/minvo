% /* ----------------------------------------------------------------------------
%  * Copyright 2020, Jesus Tordesillas Torres, Aerospace Controls Laboratory
%  * Massachusetts Institute of Technology
%  * All Rights Reserved
%  * Authors: Jesus Tordesillas, et al.
%  * See LICENSE file for the license information
%  * -------------------------------------------------------------------------- */

%P expressed in [a,b] --> P expressed in [c,d]

%Note that the spatial curve is the same one. I.e., denoting Pt=P*T  and  P_converted_t=P_converted*T
%        fplot(Pt(1,:),Pt(2,:), [a,b]);   and
%        fplot(P_converted_t(1,:),P_converted_t(2,:), [c,d]);   
%generate the same plots

%In other words,  P_converted_t(c) = Pt(a)
%                 P_converted_t(d) = Pt(b)
% (and they also match in between)
function P_converted=convertCoeffMatrixFromABtoCD(P,ab,cd) 

syms t real

a=ab(1);
b=ab(2);
c=cd(1);
d=cd(2);

if(b<=a)
    error("Need b>a")
end

if(d<=c)
    error("Need d>c")
end

%tt=((d-c)/(b-a))*(t-a) + c;

tt=((b-a)/(d-c))*(t-c)+a;

T=[];
deg=size(P,2)-1;
for i=0:(deg)
    T=[tt^i T];
end

tmp=P*T';

P_converted=[];

for i=1:size(P,1)
    
    P_converted=[P_converted ;vpa(coeffs(tmp(i),t,'All'))];
end

end