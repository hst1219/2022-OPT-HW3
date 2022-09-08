clear all;
clc;
close all;
A=[1,2;3,4];
b=[5;6];
l=[-5;-5];
u=[5;5];

cvx_begin

variables x(2,1)

minimize norm(A*x-b)

subject to
x>=l;
x<=u;


cvx_end