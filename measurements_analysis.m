clear
clc

measurements = load("Measurements_Session_1\AllData.mat");
m = measurements.dataStruct;

% t1 = m.File_1.data;
% 
% plot(m.File_1.data.Displacement_Plot0, m.File_1.data.Force_Plot0)

fields = fieldnames(m); % Get all field names of the structure

figure; clf; % Create a new figure for each plot
tiledlayout(3,4)


for i = 1:length(fields)
    currentField = fields{i}; % Get the current field name
    if isfield(m.(currentField), 'data') % Check if 'data' field exists
        dataStruct = m.(currentField).data;
        % Check if the required fields exist in the 'data' structure
        % if isfield(dataStruct, 'Displacement_Plot0') && isfield(dataStruct, 'Force_Plot0')
            % Extract data for plotting
            displacement = dataStruct.Displacement_Plot0;
            force = dataStruct.Force_Plot0;
            
            % Plot the data
            nexttile;
            plot(displacement, force);
            title(['Plot for ', currentField]);
            xlabel('Displacement');
            ylabel('Force');
        % else
            % disp(['Fields missing in ', currentField, '.data']);
        % end
    else
        disp(['Field ', currentField, ' does not have a "data" sub-structure.']);
    end
end
