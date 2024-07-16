# -------------------------------------------------------------------
# auto-fix minor lint issues & report the rest with checkcode
# -------------------------------------------------------------------
# https://stackoverflow.com/questions/33187141/how-to-call-matlab-script-from-command-line
# This script runs checkcode, which is the recommended replacement for mlint
# Note, this will check in with the package manager, current user needs to be correct
# matlab -nodesktop -nosplash -r run_issues

# -------------------------------------------------------------------
# auto-format (miss_hit)
# -------------------------------------------------------------------
# Set parsing info for miss_hit
export PYTHONIOENCODING=UTF-8

# Automatically format .m files in this directory per miss_hit standard
# If it can't be auto-fixed, skip it (future: comply w/ company standards)
mh_style --fix .

# -------------------------------------------------------------------
# Potential bug check (miss_hit)
# -------------------------------------------------------------------
# Check for likely bugs
# Documentation says this is complementary to mlint, not in competition
mh_lint .

# -------------------------------------------------------------------
# Check complexity (miss_hit)
# -------------------------------------------------------------------
mh_metrics plot_data_set.m

# -------------------------------------------------------------------
# FUTURE run proper unit tests & check code coverage
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# FUTURE clone detection with PMD's CPD
# -------------------------------------------------------------------

echo "Finished checking code!"