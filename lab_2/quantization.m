A=1;
f=2;
fs=4000;          
t=0:1/fs:1;
y= A*sin(2*pi*f*t);
figure
plot(t,y)
ylabel('Amplitude');
xlabel('time');
title('Signal before quantization');
 figure
n=[3,4,5,10];
m=2.*n+1;
for i=1:length(n)
   yq= (fi(y,1,m(i),n(i)));
   Pe = (sum((yq - y).^2))./length(y);  %qe from the equation
   subplot(2,2,i)
   plot(t,yq,'b')
   ylabel('Amplitude');
   xlabel('time');
  % legend(['qe= ',num2str(Pe)])
   %title(['n =',num2str(n(i))])

end
%% encoding
n=input('choose which n you want to encode with ( n[3,4,5,10] ): ');
m=2*n+1;
yq_e=double(fi(y,1,m,n));
encoded_signal = zeros(length(y),m);
for i=1:length(yq_e)
 if yq_e(i)< 0 % for negtive numbers
    encoded_signal(i,1) = 1;
    x = abs(yq_e(i));
 elseif yq_e(i)> 0
    encoded_signal(i,1) = 0;
    x = yq_e(i);
  end
 x = abs(yq_e(i));
% number bits for integer part and fraction
integer = n;
fraction = n;                      

%get binary number 
encoded_signal(i,2:end) = fix(rem(x*pow2(-(n-1):n),2));
end
