
clear all;clc;
%% __1  construction for over sampling    "fs>Fn"
t=0:0.001:1;            % time vector   fs=1000(sampling freq)
y=2*cos(2*pi*5*t);      %the signal
[B,A] = butter(3,1000/100000,'low' );       % butter fly filter "LB"
zero_added_signal=zeros(1,length(y)*10);    %to change sample freq
for i=1:length(y)
zero_added_signal(i*10)=y(i);
end
zero_added_signal(1:9)=[];
% Adding zeros enhances the signal display and 
%don't change the spectrum,it changes sampling freq. only
t=linspace(0,1,length(zero_added_signal));
filtered_signal = filter(B,A,zero_added_signal);
figure
plot(t,filtered_signal,'r' )
xlabel('time')
ylabel('oversampled signals')
s=fft(filtered_signal);
s=fftshift(s);
fs=1000; % f=5 FN=10 over samping fs>FN so assume fs=100 after up sampling fs=1000
freq=linspace(-fs/2,fs/2,length(s));
figure
plot(freq,abs(s))
xlabel('freq')
ylabel('magnitude of over sampled signals')


%% __2  construction for minimum sampling   "fs=Fn"

t=0:0.1:1;      % 0.1 because f=5 ,FN=10 at ""critcal niquect"" fs=FN=10 ,t=0:1/fs:1
y=2*cos(2*pi*5*t);
[B,A] = butter(10,0.1,'low' );
zero_added_signal=zeros(1,length(y)*10);
for i=1:length(y)
zero_added_signal(i*10)=y(i);
end
zero_added_signal(1:9)=[];
%
t=linspace(0,1,length(zero_added_signal));
filtered_signal = filter(B,A,zero_added_signal);
figure
plot(t,filtered_signal,'r' )
xlabel('time')
ylabel('minimum sampled signals')
%
s=fft(filtered_signal);
s=fftshift(s);
fs=100; % f=5 FN=10 minumum samping fs=FN so fs=10 after up sampling fs=100
freq=linspace(-fs/2,fs/2,length(s));
figure
plot(freq,abs(s))
xlabel('freq')
ylabel('magnitude of minimum sampled signals')
%% __3  construction for undersampling sampling  "fs<Fn"

t=0:0.2:1;  %fs=5 <Fn'10' 
y=2*cos(2*pi*5*t);
[B,A] = butter(10,0.2,'low' );
zero_added_signal=zeros(1,length(y)*10);
for i=1:length(y)
zero_added_signal(i*10)=y(i);
end
zero_added_signal(1:9)=[];
%
t=linspace(0,1,length(zero_added_signal));
filtered_signal = filter(B,A,zero_added_signal);
figure
plot(t,filtered_signal,'r' )
xlabel('time')
ylabel('undersampling  signals')
%
s=fft(filtered_signal);
s=fftshift(s);
fs=50;  % after upsampling
freq=linspace(-fs/2,fs/2,length(s));
figure
plot(freq,abs(s))
xlabel('freq')
ylabel('magnitude of  undersampling  signals')
