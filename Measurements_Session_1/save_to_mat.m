clear
clc

% Define the directory containing the .txt files
folderPath = 'Measurements_Session_1';

% Get a list of all .txt files in the directory
fileList = dir(fullfile(folderPath, '*.txt'));

% Initialize a cell array to hold the data and filenames
dataStruct = struct();

for i = 1:length(fileList)
    % Get the full path of the file
    fileName = fileList(i).name;
    filePath = fullfile(folderPath, fileName);
    
    % Read file as text and replace commas with periods
    text = fileread(filePath);
    text = strrep(text, ',', '.');
    fid = fopen('processed_data.txt', 'w');
    fwrite(fid, text);
    fclose(fid);
    
    % Now import the corrected file
    data = readtable('processed_data.txt', 'Delimiter', '\t', 'ReadVariableNames', true);

    % Store data and filename in the structure
    fieldName = sprintf('File_%d', i); % Create a unique field name
    dataStruct.(fieldName).fileName = strrep(fileName(1:end-4), '_', ' ');
    dataStruct.(fieldName).data = data;
end

% Save the structure to a .mat file
save(fullfile(folderPath, 'AllData.mat'), 'dataStruct');
delete('processed_data.txt');
clc

disp('Data from all text files saved to AllData.mat');
