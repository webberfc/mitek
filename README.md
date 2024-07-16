Webber programming test

# plot_data_set.m
This function reads in a data set, a configuration file, and outputs a
.png of a graph of the data.

It comes with support files to demonstrate testing both successful plots
as well as demonstrating exceptions when data validation fails. Data
requirements are described below.

# Functionality Description


# User Instructions  
Example call:
`plot_data_set("tests/data1.csv","tests/config1.csv", "example1.png")`
Will generate a plot of the data in data1.csv according to the
configuration specified in config1.csv and save the resulting plot to
example1.png

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
Mean value line | show | Options are "show" or "not". Default is   "not". Using default will log a warning.
Linear data fit line | show | Options are "show" or "not". Default is   "not". Using default will log a warning.
xlabel | date | Label should conform   to     https://www.mathworks.com/help/matlab/titles-and-labels.html
ylabel | hours engine running

</body></html>


## Data Interface Specifications
Data can be generated in a tool such as Excel and saved as a .csv.

> [!IMPORTANT] If you use a tool like Excel, ensure that the
display is what is being rendered to the file on export. In Excel, this
means to format everything as text, NOT as a date (the author had an issue
where a date rendered correctly in Excel, but the year rendered as 24
instead of 2024 in Matlab; there may be other ways to avoid this).

### Data
The data must be supplied in a comma-separated value (csv) document.
It must have two columns, one with the word `date` up top (lower case),
and one with the word `value` up top (lower case). The dates must be
parseable to a Matlab `datetime` object

# Explanation of the Results

# Contributing
Please ensure changes conform to company CI standards.
Here are the tools used in this:
- `miss_hit` auto formatter, `mh_style`
- `miss_hit` bug detector, `mh_lint`
- `miss_hit` complexity checker, `mh_metrics`
- Matlab's `codeIssues` auto fixer & issue detector

## TODO list prior to final submission
- [ ] ***Comply with directions on commenting!***
- [ ] ***Finish this GitHub document!***
- [ ] handle case where the config file doesn't exist - warn & use defaults
- [ ] fix issue where date renders as year 0024 & catch w/ validator 
- [ ] Check mh_lint, codecheck for actionable fixes


Other notes:
1. checking for copy-paste / duplications was done by inspection, normally 
I would use PMD's `CPD` (Copy Paste Detector).
2. checking for excess complexity was done by inspection rather than a
tool, though `miss_hit.mh_metrics` offers this.
3. I aggressively type check statically in Python, data typing seems to
only be done at run time from what I could find.
4. This repo is public for my convenience, however, I would be happy to
make it private or delete it on request.
5. This code base was NOT checked to ensure smooth compilation to Java
6. I used fewer commits than usual (every 1-2 hours) because I was ramping
back up with Matlab, this will keep the commit history cleaner.
7. I would typically turn TODOs in the code into GitHub issues and link
them; some will be changed after questions, and some will not be changed.