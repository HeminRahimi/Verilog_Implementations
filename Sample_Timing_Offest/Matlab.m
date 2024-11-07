clc
close all;
clear all;


M = 16;     % M-QAM
Nfft  = 128;
bw = 10000000;    %% signal bandwidth
delta_f = bw / Nfft;           %% Subcarrier Spacing
Ng = Nfft/4;    %% Guard interval
cplen = Ng;
nSym  = 4; %% number of symbol
numofCarrs = Nfft;
inp_data = randi([0 M-1],numofCarrs,nSym); %% random data generation
snr = 25;      %% SNR in dB
f_cfo = -100;  %% Carrier Frequency Offset 
cfo = f_cfo/delta_f; %% normalized CFO
Ft = 100e6;  %% Sampling frequency at transmitter
Fr = 99.999e6;  %% Sampling frequency at Reciver
sco = (Fr - Ft)/Ft;
STO = 20;
com_delay = Ng;

%%%%%%%%% Transmitter
inp_data = randi([0 M-1],numofCarrs,nSym);
tx_mod = qammod(inp_data,M,'UnitAveragePower',true);
tx = ofdmmod(tx_mod, Nfft, Ng);
tx_noisy = awgn (tx, snr, 'measured')';
rx_offset = Add_offset (tx_noisy, 0, cfo, Nfft); %% add offset
tx_STO = add_STO(rx_offset, STO);

%load('gendata.mat');

%% 2^9   ->  [-255    255]
len = 9;

cmplx_data = tx_STO;

real_data  = real(cmplx_data);
img_data   = imag(cmplx_data);

% Find the maximum absolute values
[max_real, idx_r] = max(abs(real_data));
[max_img, idx_i]  = max(abs(img_data));
max_val = max([max_real, max_img]);
% Quantization
quant_real_data = round((real_data / max_val) * (2^(len-1) - 1));
quant_img_data  = round((img_data / max_val) * (2^(len-1) - 1));

for i = 1 : length(quant_real_data)
    a = quant_real_data(i);
    if (a < 0)
        t1 = (2^(len)) - abs(a);
        t1 = dec2bin(t1, len);
        bin_real_data(i, :) = t1;
    else
        t1 = dec2bin(a, len);
        bin_real_data(i, :) = t1;
    end

    b = quant_img_data(i);
    if (b < 0)
        t2 = (2^(len)) - abs(b);
        t2 = dec2bin(t2, len);
        bin_img_data(i, :) = t2;
    else
        t2 = dec2bin(b, len);
        bin_img_data(i, :) = t2;
    end
end

%%%%%%%%%%% data generation stage %%%%%%%%%%%
% fid_real = fopen('.\Path_to_file\real_data.txt','wb');
% fid_img = fopen('.\Path_to_file\img_data.txt','wb');
% 
% if fid_real == -1 || fid_img == -1
%     error('Error opening files for writing');
% end
% 
% % Write the content of bin_real_data and bin_img_data to the respective files
% for i = 1:length(quant_real_data)
%     % Write bin_real_data(i, :) to real_data_file
%     fwrite(fid_real, bin_real_data(i, :), 'char');
%     fprintf(fid_real, '\n'); % Add a newline after each line
% 
%     % Write bin_img_data(i, :) to img_data_file
%     fwrite(fid_img, bin_img_data(i, :), 'char');
%     fprintf(fid_img, '\n'); % Add a newline after each line
% end
% 
% % Close the files
% fclose(fid_real);
% fclose(fid_img);

norm_re = quant_real_data/(2^8);
norm_img = quant_img_data/ (2^8);
nq_sig = complex(norm_re, norm_img);
[STO_est, ~] = STO_by_diff (nq_sig, Nfft, Ng, com_delay)
% nq_sig = complex(quant_real_data, quant_img_data);
% %CFO_est = CFO_CP(nq_sig, Nfft, Ng);
% [STO_est, ~] = STO_by_diff (nq_sig, Nfft, Ng, com_delay)



%% **************************
% Funcs:



function [STO_est,Mag]=STO_by_diff(rx, Nfft, Ng, com_delay)  
%   Input:        
%               y   = Received OFDM signal including CP
%               Ng  = Number of samples in CP (Guard Interval)
%         com_delay = Common delay
%   Output: 
%         STO_est   = STO estimate
%          Mag      = Correlation function trajectory varying with time
    
    N_ofdm=Nfft+Ng;
    minimum=10000;
    STO_est=0;

    if nargin<4 
        com_delay = Ng;
    end
    %%%%
for n=1:N_ofdm
        nn = n + com_delay + [0:Ng-1]; 
        res = abs(rx(nn))-abs(rx(nn+Nfft));
        Mag = res * res'; 
        Mag_rec(n) = Mag; 
        RES = res.^2;
        accu(1) = 0 ;
        for i = 1 : length(res)
            if (i == 1)
                accu(i) = RES(i);
            else
                accu(i) = accu(i-1) + RES(i);
            end
        end

%         if (Mag<minimum)
%             minimum=Mag;  
%             STO_est = N_ofdm - com_delay - (n-1); 
%         end  
    end
    [minval, minidx] = min(Mag_rec);
    STO_est = N_ofdm - minidx - (com_delay-1);
end









 function y_SCO = Add_offset(y, SCO, CFO, Nfft)

        %%% y : Rx signal without offset
        %%% SCO : normalized sample clock offset
        %%% CFO : mormalized carrier freq offset
        %%% Nfft : num of FFT points
        
         y_SCO = y.* ... 
             ( exp(((j*2*pi*CFO*(1:length(y))*(1 + SCO))/Nfft)) ) ;
 end

function CFO_est=CFO_CP(y,Nfft,Ng)
    %%% y: Rx signal with carrier freq. offset
    %%% Ng : guard interval size
    %%% Nfft: num of FFT points
    tmp = 0 ; 
    
    for n=1:Ng 
        mul = y(n+Nfft)*y(n)';
        tmp = tmp + mul;
        mul_rec(n, 1) = mul;
        tmp_rec(n, 1) = tmp;
    end
    CFO_est = 1/(2*pi) *angle(tmp);
end


function y_rec = remove_CFO(y,CFO,Nfft) 
     %%% y: Rx signal with carrier freq. offset
     %%% CFO: normalized carrier freq. offset
     %%% Nfft: num of FFT points
     y_rec = y.* ( exp(-(j*2*pi*CFO*(1:length(y)))/Nfft) ...
                 * exp(-(j*2*pi*CFO)) ) ;
end

%%%%%%%
function SCO_est=Est_SCO(y,Nfft,Ng, CFO)
    %%% y: Rx signal with sample clock offset
    %%% CFO: normalized carrier freq. offset
    %%% Ng : guard interval size
    %%% Nfft: num of FFT points
    n=1:Ng; 
    SCO_est = (1/(2*pi * CFO) *...
              angle(y(n+Nfft)*y(n)') ) - 1;
end


function y_STO=add_STO(rx, STO_val)

    if STO_val>=0 
        y_STO = [rx(STO_val+1:end) zeros(1,STO_val)]; 
    else
        y_STO = [zeros(1,-STO_val) rx(1:end+STO_val)];
    end
end







