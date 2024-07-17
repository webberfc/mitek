Webber programming test

# Functionality Description for plot_data_set.m
This function reads in a data set, a configuration file, and outputs a
.png of a graph of the data.

It comes with support files to demonstrate testing both successful plots
as well as demonstrating exceptions when data validation fails.

> [!IMPORTANT]  
> Note, the Statistics and Machine Learning toolbox is required to run this
function.

# User Instructions  
Example call:
`plot_data_set("tests/data1.csv","tests/config1.csv", "example1.png")`
Will generate a plot of the data in data1.csv according to the
configuration specified in config1.csv and save the resulting plot to
`example1.png`.

## Configuration
To configure the plot, copy a configuration such as `tests/config1.csv`
and modify the `csv` file.

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
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
td
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Aptos Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl65
	{font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:#D9D9D9;
	mso-pattern:black none;}
.xl66
	{font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl67
	{text-align:left;
	white-space:normal;}
-->
</style></head>
<body link="#467886" vlink="#96607D">
key | value | comment
-- | -- | --
Mean value line | show | Options are "show" or "not". Default is "not". Using default will log a warning.
Linear data fit line | show | Options are "show" or "not". Default is "not". Using default will log a warning.
xlabel | date | Label should conform to https://www.mathworks.com/help/matlab/titles-and-labels.html
ylabel | hours engine running
</body></html>


## Data Interface Specifications
Data can be generated in a tool such as Excel and saved as a .csv.

> [!IMPORTANT] If you use a tool like Excel, ensure that the
display is what is being rendered to the file on export. In Excel, this
means to format everything as text, NOT as a date (the author had an issue
where a date rendered correctly in Excel, but the year rendered as 24
instead of 2024 in Matlab; there may be other ways to avoid this).

User responsibilities not presently handled (if these are requirements or
frequent issues, please open an issue and tag @webberfc):
- The data csv should have the first row with two entries: `date` and
`value`.
- Dates should be entered in `numerical month/day/four digit year` format.
For example, July 21, 2024 should be entered as `07/21/2024`.
- The file name must end in ".png", and ensuring the path exists is left to
the user. If it does not, ".png" will be appended.

Example:

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
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
td
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Aptos Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl65
	{font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:#D9D9D9;
	mso-pattern:black none;}
.xl66
	{mso-number-format:"Short Date";}
-->
</style></head>
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

_Note: some of the test data has been generated with Microsoft Excel, and
demonstrates that the system will attempt to handle other formats._

### Data
The data must be supplied in a comma-separated value (csv) document.
It must have two columns, one with the word `date` up top (lower case),
and one with the word `value` up top (lower case). 

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

[!example3.png]

# Contributing
Please ensure pull requests conform to company CI standards.
Here are the tools demonstrated in this project:
- `miss_hit` auto formatter, `mh_style`
- `miss_hit` bug detector, `mh_lint`
- `miss_hit` complexity checker, `mh_metrics`
- Matlab's `codeIssues` auto fixer & issue detector

