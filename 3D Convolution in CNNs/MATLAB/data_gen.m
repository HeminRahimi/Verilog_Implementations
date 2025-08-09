clc
close all
clear all
%%%%%%%%%%%%%%%%%%%%

rng('shuffle');
N = 81;
dim = 3;
base_path = '../Generated_data';

act = {fullfile(base_path, 'data_R.txt'), ...
       fullfile(base_path, 'data_G.txt'), ...
       fullfile(base_path, 'data_B.txt')};
for f = 1:dim
    data = int16(randi([-128, 127], N, 1));
    fid = fopen(act{f}, 'w');
    for i = 1:N
        if data(i) < 0
            val = 256 + data(i);
            hex_val = dec2hex(val, 2);
        else
            hex_val = dec2hex(data(i), 2);
        end
        fprintf(fid, '%s\n', hex_val);
    end
    fclose(fid);
end

%%%%%%%%%%%%%%%%%%%%
clear all

rng('shuffle');
N = 9;

base_path = '../Generated_data';

filter = {fullfile(base_path, 'first_filterR.txt'), ...
          fullfile(base_path, 'first_filterG.txt'), ...
          fullfile(base_path, 'first_filterB.txt'),...
          fullfile(base_path, 'second_filterR.txt'), ...
          fullfile(base_path, 'second_filterG.txt'), ...
          fullfile(base_path, 'second_filterB.txt')};

num_of_filters = 2;
dim = 3;
for f = 1:num_of_filters * dim
    data = int16(randi([-128, 127], N, 1));
    fid = fopen(filter{f}, 'w');
    for i = 1:N
        if data(i) < 0
            hex_val = dec2hex(256 + data(i), 2);
        else
            hex_val = dec2hex(data(i), 2);
        end
        fprintf(fid, '%s\n', hex_val);
    end
    fclose(fid);
end
