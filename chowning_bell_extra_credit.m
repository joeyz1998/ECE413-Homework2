% Daniel Zuerbig
% Music and Engineering extra credit
% Just for fun, I experimented with the Chowning bell model. However, I
% made the small change of having the modulating frequency change over
% time. Below are the results. It is quite easy to switch back to the
% original chowning bell, simply uncomment line 32, and comment line 33. 

clc; close all; clear all;

fs = 44100;
T = 1/fs; 
len = 12;
t = 0:T:len-T;
n = length(t);


fc = 300;
fm = (fc * (7/5));


imax = 10;
imin = 2;

ring_factor1 = 4;
ring_factor2 = 6;

envelope1 = exp( (-1*ring_factor1) * (1./len) .* t);
envelope2 = exp( (-1*ring_factor2) * (1./len) .* t);



mod_f = ((- fm + 10)/len)*t + fm;
%f_mod = imax*sin( 2 * pi * fm * t); % use this line for actual chowning bell
f_mod = imax*sin( 2 * pi * mod_f .* t);
f_mod = envelope2 .* f_mod;


y = sin( (2 * pi * fc * t) + f_mod );

y = y .* envelope1;

play(y, fs)

