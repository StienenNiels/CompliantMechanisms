clear
clc

% measurements = load("Measurements_Session_1\AllData.mat");
measurements = load("Measurements_Session_2\AllData.mat");
m = measurements.dataStruct;
fields = fieldnames(m); % Get all field names of the structure


figure(1); clf; % Create a new figure for each plot
tiledlayout(4,4)
for i = 1:length(fields)
    currentField = fields{i}; % Get the current field name
    if isfield(m.(currentField), 'data') % Check if 'data' field exists
        dataStruct = m.(currentField).data;
        % Extract data for plotting
        displacement = dataStruct.Displacement_Plot0;
        force = dataStruct.Force_Plot0;
        
        % Plot the data
        nexttile;
        plot(displacement, force);
        title(['Plot for ', m.(currentField).fileName]);
        xlabel('Displacement');
        ylabel('Force');
        grid on
    else
        disp(['Field ', currentField, ' does not have a "data" sub-structure.']);
    end
end
