clear all;clc;

%% _ quantize by quantiz function
A=1;        %amplitude
f=2;        %frequancy
fs=4000;    %sampling freq
t=0:1/fs:1; %time vector
y= A*sin(2*pi*f*t); %the signal

figure
plot(t,y)
ylabel('Amplitude');
xlabel('time');
title('Signal before quantization');

n=[3,4,5,10];%num of bits represents int value and fraction and last bit in the sign bit
m=2.*n+1;    %quantization num
figure
for i=1:length(n)
   q =  quantizer( [m(i) n(i)] , 'fixed'); 
   yq=quantiz(q , y);      %signal quantized by quantiz function
   Pe = sum((yq - y).^2)./length(y);  %quantization error
   subplot(2,2,i)
   plot(t,yq,'b')
   legend(['qe= ',num2str(Pe)])
   ylabel('Amplitude');
   xlabel('time');
   legend(['qe= ',num2str(Pe)])
   title(['at n= ',num2str(n(i))])
end
%% encoding
n=input('choose which n you want to encode with ( n[3,4,5,10] ): ');
m=2*n+1;
quantizer( [m n] , 'fixed'); 
yq_e=quantiz(q , y);
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
