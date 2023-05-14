function rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,case_type,fs)
%
% Inputs:
%   rec_sample_seq: The input sample sequence to the channel
%   case_type:      The sampling frequency used to generate the sample sequence
%   fs:             The bit flipping probability
% Outputs:
%   rec_sample_seq: The sequence of sample sequence after passing through the channel
%
% This function takes the sample sequence after passing through the
% channel, and decodes from it the sequence of bits based on the considered
% case and the sampling frequence

if (nargin <= 2)
    fs = 1;
end

switch case_type
    
    case 'part_1'
        %%% WRITE YOUR CODE FOR PART 1 HERE
        rec_bit_seq=rec_sample_seq;
        %%%
    case 'part_2'
        %%% WRITE YOUR CODE FOR PART 2 HERE
       for i=1:length(rec_sample_seq)/fs
            N_one=0;
            N_zero=0;
            for j=1:fs
                if rec_sample_seq(((i-1)*fs)+j) == 1
                   N_one =N_one +1;
                else
                    N_zero= N_zero+1;
                end
            end
            
            if(N_one > N_zero)
              rec_bit_seq (i) =1;
            else
              rec_bit_seq (i) =0;
            end
        end
        %%%
    case 'part_3'
        %%% WRITE YOUR CODE FOR PART 3 HERE
         x=0;
        for j= 1:fs:length(rec_sample_seq)
            x=x+1;
            rec_bit_seq(x)=rec_sample_seq(j);
        end
end