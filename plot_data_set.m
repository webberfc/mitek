% Function to plot data based on configuration
function plot_data_set(data_file, config_file, output_file)
    % PLOT_DATA_SET reads data and configuration files, plots data with specified features, and saves the plot.
    %   plot_data_set(data_file, config_file, output_file)
    %
    % INPUTS:
    %   data_file       - Path to the CSV file containing data with columns 'date' and 'value'.
    %   config_file     - Path to the CSV file containing configuration settings with columns 'key', 'value', and 'comment'.
    %   output_file     - Path where the PNG plot will be saved.
    %
    % DESCRIPTION:
    %   The function reads data from 'data_file' and configuration from 'config_file',
    %   then generates a plot based on specified features such as mean value line,
    %   linear data fit line, xlabel, and ylabel, as configured in 'config_file'.
    %   It saves the resulting plot as a PNG file specified by 'output_file'.
    %
    %   The plot includes:
    %   - Data points from 'data_file'
    %   - Mean value line (if specified in 'config_file')
    %   - Linear data fit line (if specified in 'config_file')
    %   - Legends for plotted lines
    %   - X-axis label ('xlabel') and Y-axis label ('ylabel')
    %   - Title in the format 'ylabel vs xlabel'
    %
    % EXAMPLE USAGE:
    %   data_file = 'tests/data1.csv';
    %   config_file = 'tests/config1.csv';
    %   output_file = 'example1.png';
    %   plot_data_set(data_file, config_file, output_file);
    %   will generate a plot of the data in data1.csv according to the
    %   configuration specified in config1.csv and save the resulting plot
    %   to example1.png
    %
    %   See also run_tests.m

    % ---------------------------------------------------------------------
    % Ensure the output file name ends with .png
    % Note, this doesn't ensure a full path is valid
    % ---------------------------------------------------------------------
    if ~endsWith(output_file, '.png')
        disp("WARNING! Output file name does not end in .png")
    end

    % ---------------------------------------------------------------------
    % Validate & structure inputs. See prepInputs for more details.
    % ---------------------------------------------------------------------
    [date_labels, dates, values, config] = prepInputs(data_file, config_file, output_file);

    % ---------------------------------------------------------------------
    % Extract configuration parameters
    % ---------------------------------------------------------------------
    % Note that strcmpi is case invariant, vs strcmp.
    show_mean = strcmpi(getKeyValue(config, MitekConstants.CFG_MEAN_VAL), 'show');
    show_fit = strcmpi(getKeyValue(config, MitekConstants.CFG_LIN_LINE), 'show');
    xlabel_str = getKeyValue(config, MitekConstants.CFG_XLABEL);
    ylabel_str = getKeyValue(config, MitekConstants.CFG_YLABEL);

    % ---------------------------------------------------------------------
    % Set defaults if a label wasn't specified.
    % ---------------------------------------------------------------------
    if xlabel_str.strlength < 1
        disp("Warning, 'xlabel' was blank or unspecified!");
        xlabel_str = "x unspecified";
    end
    if ylabel_str.strlength < 1
        disp("Warning, 'ylabel' was blank or unspecified!");
        ylabel_str = "y unspecified";
    end

    % ---------------------------------------------------------------------
    % Plot the datapoints themselves.
    % ---------------------------------------------------------------------
    figure;
    plot(dates, values, 'b*', 'DisplayName', 'Data');
    % Ensure the x axis is labeled and spaced appropriately
    % Use the earliest and latest dates to set the limits
    mindate = date_labels(1);
    maxdate = date_labels(end);
    xlim([mindate, maxdate]);
    % Keep previous plots and continue to build on top
    hold on;

    % ---------------------------------------------------------------------
    % Plot mean line if specified.
    % ---------------------------------------------------------------------    
    if show_mean
        mean_value = mean(values);
        plot([mindate, maxdate], [mean_value, mean_value], 'r:', DisplayName = "Mean Value");
    end

    % ---------------------------------------------------------------------
    % Perform linear fit and plot if specified
    % ---------------------------------------------------------------------
    if show_fit
        % dayvals converts the days into a duration, then into an integer.        
        dayvals = days(dates - mindate);
        p = polyfit(dayvals, values, 1);
        % https://www.mathworks.com/matlabcentral/answers/271328-will-polyfit-work-with-datetime-vectors
        fitted_values = polyval(p, dayvals);
        plot(dates, fitted_values, 'k--', 'DisplayName', 'Linear Fit');
    end

    % ---------------------------------------------------------------------
    % Plot labels and title
    % ---------------------------------------------------------------------
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
    % prepInputs performs validation on data and configuration inputs and 
    % the filename.
    %
    % INPUTS:
    %   data_file_in    - Path to the CSV file containing data with columns 'date' and 'value'.
    %   config_file_in  - Path to the CSV file containing configuration settings with columns 'key', 'value', and 'comment'.
    %   output_file_in  - Path where the PNG plot will be saved.
    %
    % OUTPUTS:
    %   datelabels  - the sorted list of unique dates.
    %   dates       - array of dates.
    %   values      - Numeric array of values.
    %   config      - The .csv file containing the configuration
    %
    % DESCRIPTION:
    %   The function reads data from 'data_file_in' and configuration from
    %   'config_file_in', then prepares the input parameters required for
    %   plotting. It extracts date labels, dates, and values from the data
    %   file, and configuration settings from the configuration file. The
    %   function does not plot directly but prepares inputs for subsequent
    %   plotting functions.
    %
    % EXAMPLE USAGE:
    %   data_file = 'data.csv';
    %   config_file = 'config.csv';
    %   output_file = 'output_plot.png';
    %   [datelabels, dates, values, config] = prepInputs(data_file, config_file, output_file);
    %
    % See also: readtable, run_tests.m

    % -------------------------------------------
    % Read data and configuration from CSV files
    % -------------------------------------------
    data = readtable(data_file_in);
    dates = data.date;
    if any(year(dates) < 1900)
        disp("WARNING! Some dates are before the year 1900, please verify")
    end

    % This identifies unique dates, and then sorts the list.
    % This is used to set the domain of the x axis.
    % The other two outputs are unused, hence ~ ~    
    [datelabels, ~, ~] = unique(dates);
    values = data.value;

    % Read the specified .csv file containing the configuration
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
% MUSTBEDATETIME validates that input dates_in is in datetime format.
%   mustBeDateTime(dates_in)
%   This is not intended to be called directly; rather, it is a data
%   validator.
%
% INPUT:
%   dates_in    - Input dates to be validated.
%
% DESCRIPTION:
%   The function checks if dates_in is in datetime format.
%   If not, it throws an error with an appropriate message.
%
% EXAMPLE USAGE:
%   dates = datetime('now');
%   mustBeDateTime(dates);
%
% See also: datetime, error
    if ~isa(dates_in, class(datetime)) || any(isnat(dates_in))
        eid = 'Type:notValid';
        msg = 'Argument must be a datetime';
        throwAsCaller(MException(eid, msg));
    end
end % validate_dates

function mustContainKeys(tableIn)
% MUSTCONTAINKEYS validates that input tableIn contains required keys.
%   mustContainKeys(tableIn)
%
%   The keys that are required have been previously defined in the
%   requirements document, but can be seen in MitekConstants.
%
%   This is not intended to be called directly; rather, it is a data
%   validator.
%
% INPUT:
%   tableIn     - Input table to be validated.
%
% DESCRIPTION:
%   The function checks if the kesy specified are contained in the key
%   column of tableIn. If not, it throws an error with an appropriate
%   message. This design does not preclude additional keys.
%
% EXAMPLE USAGE:
%   config = readtable('config.csv');
%   mustContainKeys(config);
%
% See also: MitekConstants

    % Convert the cell to an array of strings
    % Also remove leading and trailing whitespace
    theKeys = strip(string(tableIn.key));

    % List the keys that are required
    requiredKeys = [MitekConstants.CFG_MEAN_VAL, ...
        MitekConstants.CFG_LIN_LINE, ...
        MitekConstants.CFG_XLABEL, ...
        MitekConstants.CFG_YLABEL];

    % Require that the requiredKeys are present, not the other way around
    % This way, the configuration is extensible later
    if ~ismember(requiredKeys, theKeys)
        eid = 'InputError:Required key missing';
        msg = 'Key not a valid value';
        throwAsCaller(MException(eid, msg));
    end
end

function validateDataAndConfig(dates_fv, vals_fv, config, output_file_name)
% VALIDATEDATAANDCONFIG validates dates, values, configuration, and output file name.
%   validateDataAndConfig(dates_fv, vals_fv, config, output_file_name)
%
% This function leverages Matlab data validation using the `arguments`
% keyword.
%
% INPUTS:
%   dates_fv            - Dates extracted from data file.
%   vals_fv             - Values extracted from data file.
%   config              - Configuration table read from config file.
%   output_file_name    - Output file name to be validated.
%
% DESCRIPTION:
%   The function validates the inputs to ensure they meet the required
%   criteria:
%   - dates_fv and vals_fv are numeric arrays.
%   - config is a table with necessary keys and valid values.
%   - output_file_name is a character vector ending with '.png'.
%   If any validation fails, an error is thrown with an appropriate message.
%
% EXAMPLE USAGE:
%   dates = datetime('now');
%   values = rand(10, 1);
%   config = readtable('config.csv');
%   output_file = 'output_plot.png';
%   validateDataAndConfig(dates, values, config, output_file);
%
% See also: arguments, mustContainKeys, mustBeDateTime

    % Validate the arguments. This must be first.
    % Because this must be first, a separate function is required.
    % The #ok<INUSA> tells Matlab that we intentionally are not using
    % a variable again; this is deliberate, as it leverages Matlab's
    % established validation system.
    arguments
        dates_fv {mustBeDateTime}
        vals_fv {mustBeReal, mustBeFinite, mustBeNonNan} %#ok<INUSA>
        config {table, mustContainKeys}
        output_file_name {string} %#ok<INUSA>
    end

    % Provide the user with feedback regarding how well the data was
    % parsed.
    fprintf("Input contained (%d x %d) data points.\n", size(dates_fv));
    disp("Using the following configuration:");
    disp(config);
end

%% Helper for concise config file access
function val = getKeyValue(cfg_in, key_in)
% GETKEYVALUE retrieves a value associated with a specified key from the input table.
%   val = getKeyValue(cfg_in, key_in)
%
% INPUTS:
%   cfg_in      - Input table containing configuration data with columns 'key', 'value', and 'comment'.
%   key_in      - Key for which the corresponding value is to be retrieved.
%                 Use MitekConstants
%
% OUTPUT:
%   val         - Value associated with the specified key from cfg_in.
%
% DESCRIPTION:
%   The function searches for the entry in cfg_in where the 'key' matches key_in,
%   and retrieves the corresponding 'value'. If the key is not found, an error
%   is thrown with an appropriate message.
%
% EXAMPLE USAGE:
%   config = readtable('config.csv');
%   key = 'MeanLine';
%   mean_line_flag = getKeyValue(config, key);
%
% See also: MitekConstants.m

    % Get the specified key, value from the table
    % Turn it into a string, and remove excess whitespace
    temp = cfg_in{key_in, MitekConstants.CFG_VALUE};
    val = strip(string(temp));
end

% End of plot_data_set.m