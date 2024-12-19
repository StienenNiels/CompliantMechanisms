clear
clc

% measurements = load("Measurements_Session_1\AllData.mat");
measurements = load("Measurements_Session_2\AllData.mat");
m = measurements.dataStruct;
fields = fieldnames(m); % Get all field names of the structure


figure(1); clf; % Create a new figure for each plot
tiledlayout(2,3)
for i = 1:length(fields)
    currentField = fields{i}; % Get the current field name
    if isfield(m.(currentField), 'data') % Check if 'data' field exists
        dataStruct = m.(currentField).data;
        % Extract data for plotting
        displacement = dataStruct.Displacement_Plot0;
        force = dataStruct.Force_Plot0;

        % Extract relevant components from the fileName
        tokens = regexp(m.(currentField).fileName, 'f(\d{2}) (\d{2}) d(\d{2})mm s(\d) r(\d)', 'tokens', 'once');
        flexureXX = tokens{1};
        flexureYY = tokens{2};
        displacementZZ = tokens{3};
        spring = tokens{4};
        run = tokens{5};

        if run == '1' && spring == '0'
            nexttile;
            hold on
        end

        if spring == '1'
            plot(displacement, force, DisplayName=['Run ', run, ' w/ spring']);
        else
            plot(displacement, force, DisplayName=['Run ', run]);
        end
        % plot(displacement, force, DisplayName=['Run ', run]);
        % if spring == '1'
        %     title(['Flexures ', flexureXX, '-', flexureYY, '-', flexureXX, ', and displacement ', displacementZZ, 'mm, with spring']);
        % else
            title(['Flexures ', flexureXX, '-', flexureYY, '-', flexureXX, ', and displacement ', displacementZZ, 'mm']);
        % end
        xlabel('Displacement');
        ylabel('Force');
        grid on
        xlim([0,round(max(5*displacement))/5])
        if flexureXX == '20'
            ylim([0,30])
        else
            ylim([0,20])
        end
        legend(Location="southeast")
    else
        disp(['Field ', currentField, ' does not have a "data" sub-structure.']);
    end
end
