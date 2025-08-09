function Eval(stride)
% Verification script that accepts stride as input parameter

clc;
close all;

% Validate stride input
if ~ismember(stride, [1, 2])
    error('Stride must be 1 or 2');
end

% Display header
fprintf('\n');
fprintf('╔════════════════════════════════════════╗\n');
fprintf('║        Operation Verification          ║\n');
fprintf('╚════════════════════════════════════════╝\n\n');

fprintf('Running verification with stride = %d\n\n', stride);


% Define the common directory path
base_path = '../Generated_data';

% File paths
file_paths = {
    fullfile(base_path, 'data_R.txt'), 'Red Channel Data';
    fullfile(base_path, 'data_G.txt'), 'Green Channel Data';
    fullfile(base_path, 'data_B.txt'), 'Blue Channel Data';
    fullfile(base_path, 'first_filterR.txt'), 'Filter 1 (Red)';
    fullfile(base_path, 'first_filterG.txt'), 'Filter 1 (Green)';
    fullfile(base_path, 'first_filterB.txt'), 'Filter 1 (Blue)';
    fullfile(base_path, 'second_filterR.txt'), 'Filter 2 (Red)';
    fullfile(base_path, 'second_filterG.txt'), 'Filter 2 (Green)';
    fullfile(base_path, 'second_filterB.txt'), 'Filter 2 (Blue)';
};

% Check if all files exist
fprintf('🔍 Checking input files for stride=%d...\n', stride);
all_files_exist = true;
for i = 1:size(file_paths, 1)
    if ~exist(file_paths{i,1}, 'file')
        fprintf('❌ Missing: %s\n', file_paths{i,2});
        all_files_exist = false;
    end
end

if ~all_files_exist
    error('Missing input files - please run data_gen.m first');
else
    fprintf('✅ All input files found\n\n');
end

% Parameters
n = 9;  % Input size
f = 3;  % Filter size
outsize = floor((n - f)/stride + 1);

% Read input data
fprintf('📖 Reading input data...\n');
numRowsRGB = 81;
numRowsF = 9;
R = readHexFile(file_paths{1,1}, numRowsRGB);
G = readHexFile(file_paths{2,1}, numRowsRGB);
B = readHexFile(file_paths{3,1}, numRowsRGB);
f0R = readHexFile(file_paths{4,1}, numRowsF);
f1R = readHexFile(file_paths{7,1}, numRowsF);
f0G = readHexFile(file_paths{5,1}, numRowsF);
f1G = readHexFile(file_paths{8,1}, numRowsF);
f0B = readHexFile(file_paths{6,1}, numRowsF);
f1B = readHexFile(file_paths{9,1}, numRowsF);
base_address = [0, 1, 2, 9, 10, 11, 18, 19, 20];

% Compute expected outputs
fprintf('🧮 Calculating expected outputs for stride=%d...\n', stride);
[out0, out1] = computeOutputs(R, G, B, f0R, f0G, f0B, f1R, f1G, f1B, base_address, stride);

% Read and verify RTL output
out_from_RTL = fullfile(base_path, 'output_from_RTL.txt');
fprintf('\n🔎 Verifying RTL output for stride=%d...\n', stride);

% Wait for file (max 10 seconds)
max_wait = 10;
waited = 0;
while ~exist(out_from_RTL, 'file') && waited < max_wait
    pause(1);
    waited = waited + 1;
    fprintf('⏳ Waiting for RTL output (%d/%d sec)...\n', waited, max_wait);
end

if ~exist(out_from_RTL, 'file')
    error('❌ RTL output file not found after %d seconds', max_wait);
end

% Process RTL output
[out_from_RTL0, out_from_RTL1] = processRTLOoutput(out_from_RTL, stride);
% Verification results
fprintf('\n📊 VERIFICATION RESULTS FOR STRIDE=%d:\n', stride);
fprintf('─────────────────────────────────────\n');

printComparisonResult('First Filter', out0, out_from_RTL0, stride);
printComparisonResult('Second Filter', out1, out_from_RTL1, stride);

fprintf('\n✅ Verification complete for stride=%d!\n', stride);

end % Main function end

%% Helper Functions
function [out0, out1] = computeOutputs(R, G, B, f0R, f0G, f0B, f1R, f1G, f1B, base_address, stride)
    n = 9; f = 3;
    outsize = floor((n - f)/stride + 1);
    out0 = zeros(outsize, outsize);
    out1 = zeros(outsize, outsize);
    
    % First filter output
    row_num = 0;
    for r = 0:stride:6
        row_num = row_num + 1;
        col_num = 0;
        for c = 0:stride:6
            col_num = col_num + 1;
            acc = 0;
            for idx = 1:9
                i = 9 * r + c + base_address(idx);
                y1 = f0R(idx) * R(i+1) + f0G(idx) * G(i+1) + f0B(idx) * B(i+1);
                acc = acc + y1;
            end
            out0(row_num, col_num) = acc;
        end
    end
    
    % Second filter output
    row_num = 0;
    for r = 0:stride:6
        row_num = row_num + 1;
        col_num = 0;
        for c = 0:stride:6
            col_num = col_num + 1;
            acc = 0;
            for idx = 1:9
                i = 9 * r + c + base_address(idx);
                y1 = f1R(idx) * R(i+1) + f1G(idx) * G(i+1) + f1B(idx) * B(i+1);
                acc = acc + y1;
            end
            out1(row_num, col_num) = acc;
        end
    end
end

function [out_from_RTL0, out_from_RTL1] = processRTLOoutput(filename, stride)
    % Calculate expected output size based on stride
    n = 9; f = 3;
    outsize = floor((n - f)/stride + 1);
    
    fileID = fopen(filename, 'r');
    hexData = textscan(fileID, '%s');
    fclose(fileID);
    hexValues = hexData{1};
    numValues = length(hexValues);
    Y = zeros(numValues, 1);
    
    for i = 1:numValues
        decVal = hex2dec(hexValues{i});
        if decVal >= 2^31
            decVal = decVal - 2^32;
        end
        Y(i) = decVal;
    end
    
    % Calculate expected number of outputs
    expected_outputs = outsize * outsize * 2; % Two filters
    
    if numValues ~= expected_outputs
        error('Expected %d outputs for stride=%d but got %d', ...
              expected_outputs, stride, numValues);
    end
    
    % Split results for two filters
    out_from_RTL0 = reshape(Y(1:expected_outputs/2), outsize, outsize)';
    out_from_RTL1 = reshape(Y(expected_outputs/2+1:end), outsize, outsize)';
end

function printComparisonResult(filterName, expected, actual, stride)
    if isequal(expected, actual)
        fprintf('✔️ %s output is CORRECT for stride: %d\n', filterName, stride);
    else
        fprintf('❌ %s output is INCORRECT for stride: %d!\n', filterName, stride);
        fprintf('Expected (%dx%d):\n', size(expected,1), size(expected,2));
        disp(expected);
        fprintf('RTL Output (%dx%d):\n', size(actual,1), size(actual,2));
        disp(actual);
        fprintf('Difference (%dx%d):\n', size(actual,1), size(actual,2));
        disp(expected - actual);
    end
    fprintf('─────────────────────────────────────\n');
end

function data = readHexFile(filename, numRows)
    fileID = fopen(filename, 'r');
    hexData = textscan(fileID, '%s');
    fclose(fileID);
    hexValues = hexData{1};
    
    if length(hexValues) ~= numRows
        error('File %s has %d rows, expected %d', filename, length(hexValues), numRows);
    end
    
    data = zeros(numRows, 1);
    for i = 1:numRows
        decVal = hex2dec(hexValues{i});
        if decVal > 127
            decVal = decVal - 256;
        end
        data(i) = decVal;
    end
end