%% For n=3
clc; clear;
%Everything here is for the interval [0,1]
A_be=computeMatrixForBezier(3,"01");
A_bs_seg0=computeMatrixForClampedUniformBSpline(3,0,"01");
A_bs_seg1=computeMatrixForClampedUniformBSpline(3,1,"01");
A_bs_rest=computeMatrixForClampedUniformBSpline(3,2,"01");
A_bs_seg_last2=computeMatrixForClampedUniformBSpline(3,-2,"01");
A_bs_seg_last=computeMatrixForClampedUniformBSpline(3,-1,"01");

A_mv=getSolutionA(3,"01");

Mbs2mv_seg0=A_bs_seg0*inv(A_mv);
Mbs2mv_seg1=A_bs_seg1*inv(A_mv);
Mbs2mv_rest=A_bs_rest*inv(A_mv);
Mbs2mv_seg_last2=A_bs_seg_last2*inv(A_mv);
Mbs2mv_seg_last=A_bs_seg_last*inv(A_mv);

Mbs2be_seg0=A_bs_seg0*inv(A_be);
Mbs2be_seg1=A_bs_seg1*inv(A_be);
Mbs2be_rest=A_bs_rest*inv(A_be);
Mbs2be_seg_last2=A_bs_seg_last2*inv(A_be);
Mbs2be_seg_last=A_bs_seg_last*inv(A_be);


%% For n=2
clc; clear;
%Everything here is for the interval [0,1]
A_be=computeMatrixForBezier(2,"01");
A_bs_seg0=computeMatrixForClampedUniformBSpline(2,0,"01");
A_bs_rest=computeMatrixForClampedUniformBSpline(2,1,"01");
A_bs_seg_last=computeMatrixForClampedUniformBSpline(2,-1,"01");

A_mv=getSolutionA(2,"01");

Mbs2mv_seg0=A_bs_seg0*inv(A_mv);
Mbs2mv_rest=A_bs_rest*inv(A_mv);
Mbs2mv_seg_last=A_bs_seg_last*inv(A_mv);

Mbs2be_seg0=A_bs_seg0*inv(A_be);
Mbs2be_rest=A_bs_rest*inv(A_be);
Mbs2be_seg_last=A_bs_seg_last*inv(A_be);



%Everything here is for the interval [0,1]

% Mbs2mv=A_bs*inv(A_mv);
% 
% 
% Mbs2be=A_bs*inv(A_be);

%% For n=1

%Everything here is for the interval [0,1]
A_be=computeMatrixForBezier(1,"01");
A_bs=computeMatrixForBSpline(1,"01");
A_mv=getSolutionA(1,"01");

Mbs2mv=A_bs*inv(A_mv);


Mbs2be=A_bs*inv(A_be);