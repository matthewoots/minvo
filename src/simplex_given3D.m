% /* ----------------------------------------------------------------------------
%  * Copyright 2020, Jesus Tordesillas Torres, Aerospace Controls Laboratory
%  * Massachusetts Institute of Technology
%  * All Rights Reserved
%  * Authors: Jesus Tordesillas, et al.
%  * See LICENSE file for the license information
%  * -------------------------------------------------------------------------- */

%% RESULT for 3D for a given simplex
close all; clear; clc;

order = 5; % Order 2 to 5 supported, I dont know whether you'll use something higher

addpath(genpath('./utils')); addpath(genpath('./solutions'));
interv=[-1,1];
syms t real; 

switch order
    case 2
        TN=[t*t t 1]'; 
    case 3
        TN=[t*t*t t*t t 1]';
    case 4
        TN=[t*t*t*t t*t*t t*t t 1]';
    case 5 
        TN=[t*t*t*t*t t*t*t*t t*t*t t*t t 1]';
    otherwise 
        error('Error, give a proper order');
end

view1=54; view2=-4.5; figure; set(gcf, 'Position',  [500, 500, 3000, 1000])
samples_t=min(interv):0.01:max(interv);

%Vertexes of the given simplex

V=[ 0.1000    1.0000    0.8000    0.1000    0.5000	  0.9000;
    0.5000    0.2000    1.0000    0.7000    0.5000    0.6000;
         0    0.5000    0.4000    1.0000    1.2000    0.9000];
     
V = V(:,1:order+1);

disp("________________________________________");
%%%% MINVO basis
subplot(1,3,1);hold on; 

A=getA_MV(order,interv);
disp("Curve obtained using the MINVO basis: ")
P=V*A
pol_x=P(1,:)'; pol_y=P(2,:)'; pol_z=P(3,:)';

plot_convex_hull(pol_x,pol_y,pol_z,A,'g',0.02);
fplot3(pol_x'*TN,pol_y'*TN,pol_z'*TN,interv,'r','LineWidth',3);
view(view1, view2); axis equal; grid on; ylim([-1.5,1.5]); 

poly=[pol_x'*TN,pol_y'*TN,pol_z'*TN]';
samples_poly=double(subs(poly,t,samples_t));
[k1,volumen_minvo] = convhull(samples_poly(1,:)',samples_poly(2,:)',samples_poly(3,:)');
trisurf(k1,samples_poly(1,:)',samples_poly(2,:)',samples_poly(3,:)','EdgeColor','none','FaceAlpha' ,1.0)
fplot3(pol_x'*TN,pol_y'*TN,pol_z'*TN,interv,'r','LineWidth',3); title('MINVO');
camlight; lightangle(gca,45,0); colormap(winter); axis equal; axis off; caxis([0.2 0.7])
fprintf("Total volume of the convex hull of the curve = %f\n", volumen_minvo)

disp("________________________________________");
%%%%% Bernstein (Bezier) basis
subplot(1,3,2); hold on; 
A=getA_Be(order,interv);
disp("Curve obtained using the Bernstein (Bezier) basis: ")
P=V*A
pol_x=P(1,:)'; pol_y=P(2,:)'; pol_z=P(3,:)';
plot_convex_hull(pol_x,pol_y,pol_z,A,'b',0.02);
fplot3(pol_x'*TN,pol_y'*TN,pol_z'*TN,interv,'r','LineWidth',3);
view(view1, view2); axis equal; ylim([-1.5,1.5]); 

poly=[pol_x'*TN,pol_y'*TN,pol_z'*TN]';
samples_poly=double(subs(poly,t,samples_t));
[k1,volumen_bernstein] = convhull(samples_poly(1,:)',samples_poly(2,:)',samples_poly(3,:)');
trisurf(k1,samples_poly(1,:)',samples_poly(2,:)',samples_poly(3,:)','EdgeColor','none','FaceAlpha' ,1.0)
fplot3(pol_x'*TN,pol_y'*TN,pol_z'*TN,interv,'r','LineWidth',3); title('Bernstein (Bezier)');
camlight; lightangle(gca,45,0); colormap(winter); axis equal; axis off; caxis([0.2 0.7])
fprintf("Total volume of the convex hull of the curve = %f\n", volumen_bernstein)


disp("________________________________________");
%%%%% BSpline basis
subplot(1,3,3); hold on; 
A=getA_BS(order,interv);
disp("Curve obtained using the B-Spline basis: ")
P=V*A
pol_x=P(1,:)'; pol_y=P(2,:)'; pol_z=P(3,:)';
plot_convex_hull(pol_x,pol_y,pol_z,A,'y',0.02);
fplot3(pol_x'*TN,pol_y'*TN,pol_z'*TN,interv,'r','LineWidth',3);
view(view1, view2); axis equal; ylim([-1.5,1.5]); 

poly=[pol_x'*TN,pol_y'*TN,pol_z'*TN]';
samples_poly=double(subs(poly,t,samples_t));
[k1,volumen_bspline] = convhull(samples_poly(1,:)',samples_poly(2,:)',samples_poly(3,:)');
trisurf(k1,samples_poly(1,:)',samples_poly(2,:)',samples_poly(3,:)','EdgeColor','none','FaceAlpha' ,1.0)
fplot3(pol_x'*TN,pol_y'*TN,pol_z'*TN,interv,'r','LineWidth',3); title('B-Spline');
camlight; lightangle(gca,45,0); colormap(winter); axis equal; axis off; caxis([0.2 0.7])

fprintf("Total volume of the convex hull of the curve = %f\n", volumen_bspline)