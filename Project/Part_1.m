clc; clear all; close all;
%% (1)__Simulation Parameters

numBits = 1e5;      %bits number
snrRange = 0:2:30;  %SNR(0,2,4,6,...,30)dB
m_user=input('Enter  the Number of samples that represents waveform : ');
if isempty(m_user)
    numSamples=20; %defualt number of samples
else
    numSamples=m_user;
end 
samplingInstant = 20;

% Generate rectangular pulse s1(t)
Amp_s1 = input('Enter  an amplitude number for s1(t) : ');
if isempty(Amp_s1)
    s1 = ones(1,numSamples);	
else
		s1 = Amp_s1 * ones(1,numSamples);
end
% Generate rectangular pulse s2(t)
Amp_s2 = input('Enter  an amplitude number for s2(t) : ');
if isempty(Amp_s2)
    s2 = zeros(1,numSamples); %defualt 	
else
		s2 = Amp_s2 * ones(1,numSamples);
end

receiverType = {'Matched Filter', 'Correlator'};

%% (2)__Generate random binary data vector

bits = randi([0 1], 1, numBits);    % Generate Random Binary Data Vector

%% (3)__Represent Bits with Proper Waveform (20 sample for each) & calculate power
                 
waveform=repelem(bits,numSamples);
Powerr = 1/(numBits*numSamples) * (sum(waveform.^2))  % calculate power --------->

%% .............................................................................
BER_MF=zeros(1, length(snrRange)); %array for BER valuse at every SNR

for SNR_i = 1:length(snrRange)
%% (4)__Apply noise to samples & calculate noise power based on SNR

SNR=snrRange(SNR_i);

ReSequence = awgn(bits, SNR, 'measured'); % recived waveform with noise

SNR_not_dB = 10^(SNR/10);  % SNR ratio    SNRdB=10*log_10(snr)
s1_power = Amp_s1^2; 
noise_power(SNR_i) = s1_power/SNR_not_dB

%% (5)__Apply convolution process in the receiver

% matched
filter=fliplr(s1 - s2);         FL=length(filter);  %filter length
output_MF = zeros(1, (2*20-1)*numBits);

for i = 0:numBits-1
    Bit_20 = ReSequence((i*20)+1:(i+1)*20);         %take 20 samples
    conv_20 = conv(Bit_20,filter);  %length = (20+20-1)=  39
    output_MF( (FL+numSamples-1)*i+1:(FL+numSamples-1)*i+length(conv_20) ) = conv_20;
end          %  (20+20-1)=  39          (1:39 40:78 79:. .....)

% Correlator Receiver
    y_t = zeros(1, numBits);
 g=s1 - s2;
     for k=1:numBits
    y_t = sum(ReSequence(((k-1)*numSamples+1:k*numSamples).*g));
    end
% simple detector

for i = 1:1:length(bits)
 S_t(i)= ReSequence(i*numSamples);
end

%% (6)__Sample the output of the Matched filter

sampledOutput_MF = output_MF(numSamples:(samplingInstant+numSamples)-1:end); 
% take sample num 20 every 39 samples 

%% (7)__Decide whether the recived seq is 1 or 0       %   ()   ----------------->

%sample detector
Vth = (s1(10)+s2(10))/2;
rx_bits_s = S_t >= Vth;  % 1 or 0
% '''matched'''
Vth_m_c =mean(sampledOutput_MF);
detectedBits_MF = sampledOutput_MF >= Vth;  % 1 or 0

% '''CorrelatorMake''' decision based on threshold 
rx_bits_c = y_t >= Vth;  % 1 or 0

%% (8,9)__calculate number of errors,Save the BER of each SNR in matrix

numErrorsMF = biterr(bits, detectedBits_MF);
BER=numErrorsMF/numBits;
BER_MF(SNR_i) =BER;
if BER==0
    fprintf('MF BER=0 at SNR= %d',SNR);
end

errors(SNR_i) = sum(xor(bits,rx_bits_c));
    BER_c(SNR_i) = errors(SNR_i)/numBits;

error(SNR_i) = sum(xor(bits,rx_bits_s));
    BER_S(SNR_i) = error(SNR_i)/numBits;

end

%BER_MF
%% (10)__Plot the BER curve against SNR
figure;
semilogy(snrRange, BER_S, 'r-x');
xlabel('SNR (dB)');
ylabel('BER');
title('Simple Detector SNR & BER relation');

figure;
semilogy(snrRange, BER_MF, 'b-x');
xlabel('SNR (dB)');
ylabel('BER');
title('Matched Filter SNR & BER relation');

figure;
semilogy(snrRange, BER_c, 'g-o');
xlabel('SNR (dB)');
ylabel('BER');
title('Matched Filter SNR & BER relation');


figure;
semilogy(snrRange, BER_c, 'g-o');
hold on;
semilogy(snrRange, BER_MF, 'b-x');
hold on;
semilogy(snrRange, BER_S, 'r-x');
xlabel('SNR (dB)');
ylabel('BER');
title('Matched Filter & Correlated SNR & BER relation');


