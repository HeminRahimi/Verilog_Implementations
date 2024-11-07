clc
close all;
clear all;


M = 16;     % M-QAM
Nfft  = 1024;
bw = 10e6;    %% signal bandwidth
delta_f = bw / Nfft;           %% Subcarrier Spacing
Ng = Nfft/4;    %% Guard interval
cplen = Ng;
nSym  = 2; %% number of symbol
numofCarrs = Nfft;
inp_data = randi([0 M-1],numofCarrs,nSym); %% random data generation
snr = 25;      %% SNR in dB
f_cfo = -3500;  %% Carrier Frequency Offset 
cfo = f_cfo/delta_f; %% normalized CFO
Ft = 100e6;  %% Sampling frequency at transmitter
Fr = 99.999e6;  %% Sampling frequency at Reciver
sco = (Fr - Ft)/Ft;
STO = -25;
com_delay = Ng;

%%%%%%%%% Transmitter
inp_data = randi([0 M-1],numofCarrs,nSym);
tx_mod = qammod(inp_data,M,'UnitAveragePower',true);
tx = ofdmmod(tx_mod, Nfft, Ng);
tx_noisy = awgn (tx, snr, 'measured')';
rx_offset = Add_offset (tx_noisy, 0, cfo, Nfft); %% add offset
CFO_est_norm = CFO_CP(rx_offset, Nfft, Ng);

%%% 2^9   ->  [-255    255]
len = 9;

cmplx_data = rx_offset;

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

%%%%%%%%%%% data generation %%%%%%%%%%%

% fid_real = fopen('.\..ADD YOUR PATH HERE...\real_data.txt','wb');
% fid_img = fopen('.\..ADD YOUR PATH HERE...\img_data.txt','wb');
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


%%% for HDL debuging and data comparing
norm_re = quant_real_data/(2^8);
norm_img = quant_img_data/ (2^8);
nq_sig = complex(norm_re, norm_img);
CFO_est_quant = CFO_CP(nq_sig, Nfft, Ng);



%%% reconstruction phase
recov = remove_CFO(rx_offset, CFO_est_norm, Nfft);
temp_rx = recov';
rx = ofdmdemod (temp_rx, Nfft, cplen);
rx_demod = qamdemod(rx, M, 'UnitAveragePower',true);

%%%%%%%% Ploting
 
figure(2);
subplot(1, 3, 1);
plot (tx_mod,'b*');
title ("tx");
subplot(1, 3, 2);
plot (rx_offset, 'r*');
title ("rx with noise and cfo");
subplot(1, 3, 3);
plot (rx, 'm*');
title ("recovered rx");


%%% **************************
% Funcs:

 function y_SCO = Add_offset(y, SCO, CFO, Nfft)

        %%% y : Rx signal without offset
        %%% SCO : normalized sample clock offset
        %%% CFO : mormalized carrier freq offset
        %%% Nfft : num of FFT points
        n = 1:length(y);
        y_SCO = y.* ... 
             (exp((j*2*pi*CFO*(n + Nfft)*(1 + SCO))/Nfft));
 end

function CFO_est=CFO_CP(y,Nfft,Ng)
    %%% y: Rx signal with carrier freq. offset
    %%% Ng : guard interval size
    %%% Nfft: num of FFT points
    nn=1:Ng-1; 
    CFO_est = 1/(2*pi) * angle(y(nn+Nfft)*y(nn)');
end


function y_rec = remove_CFO(y,CFO,Nfft) 
     %%% y: Rx signal with carrier freq. offset
     %%% CFO: normalized carrier freq. offset
     %%% Nfft: num of FFT points
     y_rec = y.* ( exp(-(j*2*pi*CFO*(1:length(y)))/Nfft) ...
                 * exp(-(j*2*pi*CFO)) ) ;
end

%%%%%%%







