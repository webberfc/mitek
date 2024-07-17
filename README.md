# Project Overview
This project provides a utility to plot timestamped data and configure the plots externally, without modifying code.

## Table of Contents
- [Functionality Description](#functionality-description)
- [Getting Started](#getting-started)
- [User Instructions](#user-instructions)
- [Explanation of the Results](#explanation-of-the-results)
- [File Structure](#file-structure)
- [Contributing](#contributing)

<a name="functionality-description"/></a>
# Functionality Description

The file `plot_data_set.m` contains the function `plot_data_set` that reads data and configuration files, plots data with specified features, and saves the plot as `.png` file.

It comes with support files to demonstrate testing both successful plots as well as demonstrating exceptions when data validation fails. Sample data files and configuration files are contained in the `tests` directory.

<a name="getting-started"></a>
# Getting Started

To get started, clone this repository:
`git clone https://github.com/webberfc/mitek.git`

> [!IMPORTANT]  
> Next, ensure you have the Statistics and Machine Learning toolbox installed, as it provides features required to run this function.

Then, run `run_tests.m` to generate three plots. 

Example call:
`plot_data_set("tests/data1.csv","tests/config1.csv", "example1.png")`
Will generate a plot of the data in data1.csv according to the
configuration specified in config1.csv and save the resulting plot to
`example1.png`.

<a name="user-instructions"></a>
# User Instructions  

This section covers how to author compatible configuration and data files.

## Configuration
To configure the plot, create a new comma-separated value (.csv) file with the headers `key, value, comment` (it may be helpful to copy a configuration such as `tests/config1.csv`).

### Keys
The configuration file is required to have four entries under `key`:
* Mean value line
* Linear data fit line
* xlabel
* ylabel

These are case-sensitive. If you are programmatically generating this file, you may reference `MitekConstants.m` where they are pre-defined.

### Values
Each of the keys requires a string under `value`. For `Mean value line` and `Linear data fit line` the options are `show` or `not`, and any other value is treated as a `not`. For the `xlabel` and `ylabel` values, any string including usage of TeX is permitted.

### Comments
The third column contains comments, which are intended to help the author curate data. For example, if it is doesn't make sense to show a `Linear data fit line`, then that row should have a value of `not` and an explanation why, such as `the pounds of gas burned is based on tasking, not wear and tear`.

### Example configuration
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>

<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 15">
<link id=Main-File rel=Main-File
href="file:///C:/Users/dev/AppData/Local/Temp/msohtmlclip1/01/clip.htm">
<link rel=File-List
href="file:///C:/Users/dev/AppData/Local/Temp/msohtmlclip1/01/clip_filelist.xml">
</head>

<body link="#467886" vlink="#96607D">

key | value | comment
-- | -- | --
Mean value line | show | Options are "show" or "not". Default is   "not". Using default will log a warning.
Linear data fit line | show | Options are "show" or "not". Default is   "not". Using default will log a warning.
xlabel | last service date | Label should conform to   https://www.mathworks.com/help/matlab/titles-and-labels.html
ylabel | flight hours remaining to next service | Label should conform to   https://www.mathworks.com/help/matlab/titles-and-labels.html

</body>
</html>

## Data Interface Specifications
Data must be provided in a .csv format. The .csv must contain two columns. In the first row, there must be headers. The first column requires the header `date` (not `dates`) and the second column requires `value` (not `values`). 

### Dates
Dates should be entered in `numerical month/day/four digit year` format.
For example, July 21, 2024 should be entered as `07/21/2024`.

> [!IMPORTANT]
> If you use a tool like Excel, ensure that the displayed date is what is being rendered to the file on export, and that the year has four digits.

_Note: some of the test data has been generated with Microsoft Excel, and demonstrates that the system will attempt to handle other formats; results are only guaranteed as specified above._

Dates that are unable to be rendered will cause a validation error.

### Values
Values are required to be real numbers. The values `NaN`, negative infinity, and positive infinity will cause validation errors.

### Example Data File

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 15">
<link id=Main-File rel=Main-File
href="file:///C:/Users/dev/AppData/Local/Temp/msohtmlclip1/01/clip.htm">
<link rel=File-List
href="file:///C:/Users/dev/AppData/Local/Temp/msohtmlclip1/01/clip_filelist.xml">
</head>
<body link="#467886" vlink="#96607D">

date | value
-- | --
7/15/2024 | -2
8/30/2024 | -1
08/30/2024 | 0
8/2/2024 | 1
12/25/2024 | 2
07/4/2025 | 1
</body></html>

## Specifying an output
The file name must end in ".png". If does not, ".png" will be appended. The user must create any folders required to support the provided path.

<a name="explanation-of-the-results"></a>
# Explanation of the Results

This shows a sample input and sample results.
```
data_file3 = 'tests/data5.csv';
config_file3 = 'tests/config1.csv';
output_file3 = 'example3.png';
plot_data_set(data_file3, config_file3, output_file3);
```

The title is derived from the xlabel and ylabel provided in the configuration
file. The x values comes from the dates in the `date` column of `data5.csv`,
and the y values come from the `value` column. This version shows both
the mean value, which is a red dotted line, and the fit line, which is
black dashed. This helps the customer see the correlation between the last
time since the engine was serviced by the depot and the expected number of
hours remaining.

![Example of Output](https://github.com/webberfc/mitek/blob/main/example3.png)

<a name="file-structure"></a>
# File Structure

``` ~bash
mitek/
│
├── plot_data_set.m          # Main script to plot data based on configuration
├── MitekConstants.m         # Class containing constant values
│
├── run_tests.m              # Script demonstrating usage
├── README.md                # Project overview and instructions (you are here)
└── tests                    # Folder containing sample data and configurations
    ├── config1.csv          # Configuration demonstrating two lines and two labels
    ├── config2_no_lines_use_tex.csv # Configuration with no lines. One label uses TeX
    ├── data1.csv                    # A small data set
    ├── data2_duplicate_dates.csv    # A data set with duplicate and out of sequence dates
    ├── data3_invalid_dates.csv      # A data set that with invalid dates
    ├── data4_corrupt.csv            # A data set that with invalid value
    └── data5.csv                    # An additional data set
```

<a name="contributing"></a>
# Contributing

Please ensure pull requests conform to company CI standards.
Here are the tools demonstrated in this project:
- `miss_hit` auto formatter, `mh_style`
- `miss_hit` bug detector, `mh_lint`
- `miss_hit` complexity checker, `mh_metrics`
- Matlab's `codeIssues` auto fixer & issue detector

