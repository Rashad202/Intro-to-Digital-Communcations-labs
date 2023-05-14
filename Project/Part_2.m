
% Set the length of the bit sequence

n = 10;
% Set pulse duration and sampling rate
T = 1;              % Pulse duration in seconds
fs = 100;           % Sampling rate in Hz
t = 0:1/fs:T-1/fs;  % Time vector for one pulse

% Generate random bits
bits   = [1 0 1 0 0  1 1 1 0 0 ];

%% --------------Non return zero inverted ---------------

NRZ_I  = zeros(1, length(bits)*length(t));
 x=-1;
 for i = 1:length(bits)
     if bits(i)==1
         NRZ_I((i-1)*length(t)+1:(i)*length(t)) = -x;
         x=-x;
     else
         NRZ_I((i-1)*length(t)+1:(i)*length(t)) = x;
     end
     
 end
figure
subplot(3,1,1);
 plot(NRZ_I, 'LineWidth', 2);
 axis([0 length(NRZ_I) -1.5 1.5]);
 grid on;
 xlabel('Time');
 ylabel('Amplitude');
 title('NRZ_Inverted ');


%% ----------------------- Polar  ------------------------
 
%---------------------- NRZ   ------------------
Polar_NRZ = zeros(1, length(bits)*length(t));

for i = 1:length(bits)
    if bits(i) == 1
        Polar_NRZ ((i-1)*length(t)+1:i*length(t)) = 1;
    else
        Polar_NRZ ((i-1)*length(t)+1:i*length(t)) = -1;
    end
end

subplot(3,1,2);
plot(Polar_NRZ , 'LineWidth', 2);
axis([0 length(Polar_NRZ) -1.5 1.5]);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('Polar NRZ ');


%% ---------------------- RZ   ------------------

Polar_RZ  = zeros(1, length(bits)*length(t));
s=length(Polar_RZ);
for i = 1:length(bits)
    if bits(i) == 1 
           Polar_RZ((i-1)*length(t)+1:i*length(t)-50) =1;   
    else
         Polar_RZ((i-1)*length(t)+1:i*length(t)-50)=-1;
    end
   
end
       
subplot(3,1,3);
plot(Polar_RZ, 'LineWidth', 2);
axis([0 s -1.5 1.5]);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('Polar RZ ');


%%     Bipolar

%---------------------- NRZ   ------------------
Biolar_NRZ  = zeros(1, length(bits)*length(t));
x=1;
for i = 1:length(bits)
    if bits(i) == 1 
          Biolar_NRZ((i-1)*length(t)+1:(i)*length(t)) = x;   
           x =-x;
    else
        Biolar_NRZ((i-1)*length(t)+1:i*length(t)) = 0;
    end
end
figure
subplot(3,1,1);
plot(Biolar_NRZ, 'LineWidth', 2);
axis([0 length(Biolar_NRZ) -1.5 1.5]);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('Bipolar NRZ ');

%-------------------- RZ ----------------
Biolar_RZ = zeros(1, length(bits)*length(t));
s=length(Biolar_RZ);
c=1;
for i = 1:length(bits)
    if bits(i) == 1 
           Biolar_RZ((i-1)*length(t)+1:i*length(t)-50) =c;
           c=-c;
    else
         Biolar_RZ((i-1)*length(t)+1:i*length(t)-50)=0;
    end
end
subplot(3,1,2);
plot(Biolar_RZ, 'LineWidth', 2);
axis([0 s -1.5 1.5]);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('Bipolar RZ ');

%% ------------------------- Mancheseter ------------------ 
Mancheseter = zeros(1, length(bits)*length(t));
s=length(Mancheseter);
for i = 1:length(bits)
    if bits(i) == 1 
           Mancheseter((i-1)*length(t)+1:i*length(t)-50) =1;
           Mancheseter(i*length(t)-50+1:i*length(t)) =-1;
           
           
    else
         Mancheseter((i-1)*length(t)+1:i*length(t)-50) =-1;
           Mancheseter(i*length(t)-50+1:i*length(t)) =1;
    end
   
end
       
subplot(3,1,3);
plot(Mancheseter, 'LineWidth', 2);
axis([0 s -1.5 1.5]);
grid on;
xlabel('Time');
ylabel('Amplitude');
title(' Manchester NRZ ');

%% ------------------MLT_3-----------------------------

MLT3 = zeros(1, length(bits)*length(t));
prev_value=[ 0 1 0 -1 ];
pulse=ones(1,length(t));
Count=1;
for i = 1:length(bits)
     
    if bits(i) == 0
        MLT3((i-1)*length(t)+1:i*length(t)) =prev_value(Count)*pulse ;
    else
        Count=Count+1;
        if Count>4 % 5 because the size of prev_value is 4 and repeated continuous   
        Count=1;
    end
        MLT3((i-1)*length(t)+1:i*length(t)) =prev_value(Count)*pulse;
    end
    
    end

% Plot the modulated signals
figure
plot( MLT3, 'LineWidth', 2);
axis([0 length(MLT3) -1.5 1.5]);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('MLT_3');


%% --- NRZ-Inverted
figure
subplot(3,1,1)
x=plot(periodogram(NRZ_I,[],'centered',512,100));
title('NRZ-Inverted')

%% --- NRZ

subplot(3,1,2)
x=plot(  periodogram(Polar_NRZ,[],'centered',512,100));
title('NRZ')

%% --- Rz

subplot(3,1,3)
x=plot(  periodogram(Polar_RZ,[],'centered',512,100));
title('RZ')
%% --- AMI
figure
subplot(3,1,1)
x=plot(  periodogram(Biolar_NRZ,[],'centered',512,100));
title('AMI')

%% --- Mancheseter

subplot(3,1,2)
x=plot(  periodogram(Mancheseter,[],'centered',512,100));
title('Mancheseter')

%% --- MLT3

subplot(3,1,3)
x=plot(  periodogram(MLT3,[],[],100,'centered'));
title('MLT3')

%% PSD

% Set pulse duration and sampling rate
T = 1;              % Pulse duration in seconds
fs = 100;           % Sampling rate in Hz
t = 0:1/fs:T-1/fs; 
f=0:0.001:2;
Tb = 1;
A=1;
x=f*Tb;
%%  Polar NRZ

PSD_Pol_NRZ=A.^2*Tb*(sinc(x).*sinc(x));
figure
subplot(4,1,1);
plot(f,PSD_Pol_NRZ,'r')
xlabel('f ---->')
ylabel('P(f) ---->')
title('Non-return to zero ');

%%  Polar NRZi

PSD_Pol_NRZ=A.^2*Tb*(sinc(x).*sinc(x));
subplot(4,1,2);
plot(f,PSD_Pol_NRZ,'r')
xlabel('f ---->')
ylabel('P(f) ---->')
title('Non-return to zero inverted ');
%%  Polar RZ

PSD_Pol_RZ=A.^2*0.25*Tb*(sinc(x).*sinc(x));

subplot(4,1,3);
plot(f,PSD_Pol_RZ,'r')
xlabel('f ---->')
ylabel('P(f) ---->')
title('Return to zero ');
%%  Biolar NRZ
PSD_Bipol_NRZ=A.^2*Tb*(sinc(x)).^2.*(sin(pi*x)).^2;
subplot(4,1,4);
plot(f,PSD_Bipol_NRZ,'b');
xlabel('f ---->')
ylabel('P(f) ---->')
title('AMI ');


%% Manchester NRZ
PSD_Manchester = A.^2*Tb*(sinc(x/2)).^2.*(sin(pi*x/2)).^2;
figure
subplot(2,1,1);
plot(f,PSD_Manchester,'bl')
xlabel('f ---->')
ylabel('P(f) ---->')
title('PSD for Manchester NRZ ');

%%  MLT3
PSD_MLT3=A.^2*Tb*(sinc(x/2)).^2.*(cos(pi*x)).^2;
subplot(2,1,2);
plot(f,PSD_MLT3,'bl');
xlabel('f ---->')
ylabel('P(f) ---->')
title('MLT 3');

