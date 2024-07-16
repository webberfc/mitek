% Function to plot data based on configuration
function plot_data_set(data_file, config_file, output_file)
    % plot_data_set takes data and a configuration file, then generates a
    % plot that it saves to the specified file.
    %   plot_data_set("tests/data1.csv","tests/config1.csv", "example1.png")
    %   will generate a plot of the data in data1.csv according to the
    %   configuration specified in config1.csv and save the resulting plot
    %   to example1.png
    %
    %
    %   See also run_tests.m

    % -------------------------------------------
    % Validate & structure inputs
    % -------------------------------------------
    [date_labels, dates, values, config] = prepInputs(data_file, config_file, output_file);

    % -------------------------------------------
    % Extract configuration parameters
    % -------------------------------------------
    % Note that strcmpi is case invariant, vs strcmp.
    show_mean = strcmpi(getKeyValue(config, MitekConstants.CFG_MEAN_VAL), 'show');
    show_fit = strcmpi(getKeyValue(config, MitekConstants.CFG_LIN_LINE), 'show');
    xlabel_str = getKeyValue(config, MitekConstants.CFG_XLABEL);
    ylabel_str = getKeyValue(config, MitekConstants.CFG_YLABEL);

    if xlabel_str.strlength < 1
        disp("Warning, 'xlabel' was blank or unspecified!");
        xlabel_str = "x unspecified";
    end
    if ylabel_str.strlength < 1
        disp("Warning, 'ylabel' was blank or unspecified!");
        ylabel_str = "y unspecified";
    end

    % Plot data
    figure;
    plot(dates, values, 'b*', 'DisplayName', 'Data');
    % Ensure the x axis is labeled and spaced appropriately
    mindate = date_labels(1);
    maxdate = date_labels(end);
    xlim([mindate, maxdate]);
    hold on;

    % Plot mean line if specified
    if show_mean
        mean_value = mean(values);
        plot([mindate, maxdate], [mean_value, mean_value], 'r:', DisplayName = "Mean Value");
    end

    % Perform linear fit and plot if specified
    if show_fit
        dayvals = days(dates - mindate);

        p = polyfit(dayvals, values, 1);
        % https://www.mathworks.com/matlabcentral/answers/271328-will-polyfit-work-with-datetime-vectors
        fitted_values = polyval(p, dayvals);
        plot(dates, fitted_values, 'k--', 'DisplayName', 'Linear Fit');
    end

    % Plot labels and title
    xlabel(xlabel_str);
    ylabel(ylabel_str);
    title(sprintf('%s vs %s', ylabel_str, xlabel_str));

    % Display legend
    legend('show', location = 'best');

    % Save plot as PNG
    saveas(gcf, output_file);

    % Close figure
    close;
end



%% Prepare & validate inputs
function [datelabels, dates, values, config] = prepInputs(data_file_in, config_file_in, output_file_in)
    % -------------------------------------------
    % Read data and configuration from CSV files
    % -------------------------------------------
    data = readtable(data_file_in);
    dates = data.date;
    [datelabels, ~, ~] = unique(dates);
    values = data.value;

    config = readtable(config_file_in, Delimiter = ",", RowNamesColumn = 1);

    % -------------------------------------------
    % Validate data and configuration
    % -------------------------------------------
    % Note, this is fatal if validation fails. It might be desirable to
    % clean up the output to make correction easier.
    validateDataAndConfig(dates, values, config, output_file_in);
end

%% Additional Datatype Validators
% https://www.mathworks.com/help/matlab/matlab_prog/function-argument-validation-1.html
function mustBeDateTime(dates_in)
    if ~isa(dates_in, class(datetime))
        eid = 'Type:notValid';
        msg = 'Argument must be a datetime';
        throwAsCaller(MException(eid, msg));
    end
end % validate_dates

function mustContainKeys(tableIn)

    % Convert the cell to an array of strings
    % Also remove leading and trailing whitespace
    theKeys = strip(string(tableIn.key));
    % List the keys that are required
    requiredKeys = [MitekConstants.CFG_MEAN_VAL, MitekConstants.CFG_LIN_LINE, MitekConstants.CFG_XLABEL, MitekConstants.CFG_YLABEL];
    % Require that the requiredKeys are present, not the other way around
    % This way, the configuration is extensible later

    if ~ismember(requiredKeys, theKeys)
        eid = 'InputError:Required key missing';
        msg = 'Key not a valid value';
        throwAsCaller(MException(eid, msg));
    end
end

function validateDataAndConfig(dates_fv, vals_fv, config, output_file_name)
    arguments
        dates_fv {mustBeDateTime}
        vals_fv {mustBeReal, mustBeFinite, mustBeNonNan} %#ok<INUSA>
        config {table, mustContainKeys}
        output_file_name {string} %#ok<INUSA> % TODO check for .png
    end

    fprintf("Input contained (%d x %d) data points.\n", size(dates_fv));
    disp("Using the following configuration:");
    disp(config);
end

%% Helper for concise config file access
function val = getKeyValue(cfg_in, key_in)
    % Get the specified key, value from the table
    % Turn it into a string, and remove excess whitespace
    temp = cfg_in{key_in, MitekConstants.CFG_VALUE};
    val = strip(string(temp));
end

% End of plot_data_set.m