
clear all;close all; clc;

Fs = 4000;
F = 2;
t = 0:1/Fs:1;         
y = sin(2*pi*F*t);
%%%%Plot
figure(1); 
plot(t,y);
title('Original Signal')
xlabel('Time'); ylabel('Amplitude')

% Non-Uniform Quantization/Companding
n = [3, 4, 5, 10];
m = 2.*n+1;         %Quantization Levels 
law_param_mu = 255;  
law_param_A = 87.6;
%mu/compressor
for i=1:length(n)
    compressed_mu = compand(y,255,max(y),'mu/compressed');
    quantized_mu =double(fi(compressed_mu,1,m(i),n(i)));
    mse_mu = sum((quantized_mu - y).^2) / length(y);
    figure(1); 
    subplot(2,2,i)
    plot(t,quantized_mu)
    xlabel(' time')
    ylabel(' quantization mu samples')
    legend(['mse_mu= ',num2str((mse_mu))])
    title(['n = ',num2str(n(i))])
end

% A-law
for i = 1:length(n)
    compressed_A = compand(y,law_param_A,max(y),'A/compressor');
    quantized_A = double(fi(compressed_A,1 ,m(i) ,n(i)));
    MSQE_A_law =sum((quantized_A-y).^2)/length(y);
    figure(3); subplot(2,2,i); 
    plot(t,quantized_A);
    xlabel('Time'); ylabel('A-law Quantized Signal');
    title(['n=', num2str(n(i))])
    legend(['MSQE=', num2str((MSQE_A_law))])
end

%% encoding
n=input('choose which n you want to encode with ( n[3,4,5,10] ): ');
yq=input('choose mu pr A : ','s');
if(yq == 'A'  )
    yq_e= quantized_A;
elseif (yq == 'mu')
    yq_e= quantized_mu;
end
m=2*n+1;
encoded_signal = zeros(length(y),m);

for i=1:length(yq_e)
 if yq_e(i)< 0 % for negtive numbers
    encoded_signal(i,1) = 1;
    x = abs(yq_e(i));
 elseif yq_e(i)> 0
    encoded_signal(i,1) = 0;
    x = yq_e(i);
  end

% number bits for integer part
integer = n;
encoded_signal(i,2:4) = fix(rem(x*pow2(-(n-1):0),2));                    

% number bits for  fraction
fraction = n;  
encoded_signal(i,5:end) = fix(rem(x*pow2(1:n),2));

end

