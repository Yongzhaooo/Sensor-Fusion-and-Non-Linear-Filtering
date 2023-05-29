clc;
clear;
close all;
showIP;
startup;

% [xhat, meas] = filterTemplate()
[xhat, meas] = TaskMag_filterTemplate()

% [xhat, meas] = TaskAcc_filterTemplate()
% first test: it seems the google x-axis is wrong direction 

% [xhat, meas] = Task5_filterTemplate()


% load("placeflat.mat");