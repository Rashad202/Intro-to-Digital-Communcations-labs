function BER = ComputeBER(bit_seq,rec_bit_seq)
%
% Inputs:
%   bit_seq:     The input bit sequence
%   rec_bit_seq: The output bit sequence
% Outputs:
%   BER:         Computed BER
%
% This function takes the input and output bit sequences and computes the
% BER

%%% WRITE YOUR CODE HERE
N1 = length(bit_seq);
N2 = length(rec_bit_seq);
if(N1==N2)
 
    N= N1;
    e=0;
   for i=1:N
   
    if( bit_seq(i) ~= rec_bit_seq(i))
            e=e+1;
    end
   
   end
   BER = e/N;
else
   BER = 1;
end




%%%
