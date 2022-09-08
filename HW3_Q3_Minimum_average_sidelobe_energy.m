% 講義ch3 p30-32

clear all;
clc;
close all;

NUM_ANA= 20;%antenna number
CARR_FREQ= 2.3*(10^9);%carrier frequency 以手機為例
WAVE_LEN= (3*10^8)/CARR_FREQ;%wave length
ANTENNA_DIS= WAVE_LEN/2;%distance between two antennas
ANGLE_DES= 10;%propagation direction of the desired signal 
ANGLE_INT= 40;%propagation direction of the interference signal
theta_l=0;
theta_u=15;

Steering_des=  [exp(-j*[0:NUM_ANA-1].'*2*pi*ANTENNA_DIS*sin(ANGLE_DES*pi/180)/WAVE_LEN)];%steering vector of the desired signal
Steering_int=  [exp(-j*[0:NUM_ANA-1].'*2*pi*ANTENNA_DIS*sin(ANGLE_INT*pi/180)/WAVE_LEN)];%steering vector of the interference signal

% Minimize average sidelobe 講義ch3 p32 
P_matrix= zeros(NUM_ANA, NUM_ANA);

for i=-90:1:theta_l  %90度開始，每隔一度切割一次，到theta_l=0;為止
    P_matrix= P_matrix+ exp(-j*[0:NUM_ANA-1]'*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)*exp(-j*[0:NUM_ANA-1]'*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)';
end

for i= theta_u:1:90  %theta_u=15開始，每隔一度切割一次，到90度為止
    P_matrix= P_matrix+ exp(-j*[0:NUM_ANA-1]'*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)*exp(-j*[0:NUM_ANA-1]'*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)';
end

% Steering_des  a_thita_d



cvx_begin

variable w(20,1) complex
minimize(quad_form(w,P_matrix)) 
subject to
w'*Steering_des==1


cvx_end


steering_vec_plot=[];
for i=-90:1:90
    steering_vec_plot= [steering_vec_plot; exp(-j*[0:NUM_ANA-1]*2*pi*ANTENNA_DIS*sin(i*pi/180)/WAVE_LEN)];
end
% plot angle spectrum
plot([-90:1:90],10*log10(abs(w'*steering_vec_plot.').^2));
legend(['M=',num2str(NUM_ANA),',\theta_{d}=',num2str(ANGLE_DES),',\theta_{l}=',num2str(theta_l),',\theta_{u}=',num2str(theta_u)]);
title('Minimize average sidelobe energy');
xlabel('Angle(degree)');
ylabel('Angle response(dB)');


