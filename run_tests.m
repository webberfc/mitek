%% Test 1: Show both lines, data fits perfectly
% =========================================================================
data_file1 = 'tests/data1.csv';
config_file1 = 'tests/config1.csv';
output_file1 = 'example1.png';
plot_data_set(data_file1, config_file1, output_file1);

%% Test 2: Demonstrate duplicate dates and both missing and fancy labels
% =========================================================================
data_file2 = 'tests/data2_duplicate_dates.csv';
config_file2 = 'tests/config2_no_lines_use_tex.csv';
output_file2 = 'example2.png';
plot_data_set(data_file2, config_file2, output_file2);

%% Test 3: Demonstrate duplicate dates with lines and regular labels
% =========================================================================
data_file3 = 'tests/data2_duplicate_dates.csv';
config_file3 = 'tests/config1.csv';
output_file3 = 'example3.png';
plot_data_set(data_file3, config_file3, output_file3);

%% Test 4: This will thrown an error, invalid dates
% =========================================================================
data_file4 = 'tests/data3_invalid_dates.csv';
config_file4 = 'tests/config1.csv';
output_file4 = 'this_should_not_generate_1.png';
try
    plot_data(data_file4, config_file4, output_file4);
    eid = 'Exception expected: dates are invalid';
    msg = 'Inputs must have valid datetimes';
    throw(MException(eid, msg));
catch
    % expected
end

%% Test 5: This will fail, corrupt data: no plot will be saved
% =========================================================================
data_file5 = 'tests/data4_corrupt.csv';
config_file5 = 'tests/config1.csv';
output_file5 = 'this_should_not_generate_2.png';
try
    plot_data(data_file5, config_file5, output_file5);
    eid = 'Exception expected: data is corrupt';
    msg = 'Input values must not be empty, inf, or NaN.';
    throw(MException(eid, msg));
catch
    % expected
end
