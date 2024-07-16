%% miss_hit
% Automatically format code & check for some issues
% https://florianschanda.github.io/miss_hit/
% (A)GPL shouldn't? be a concern if we aren't selling that functionality
% and just using it internally.

%% Check for fixable lint issues and fix them
issues = codeIssues(["MitekConstants.m", "plot_data_set.m"]);
[status, results] = fix(issues, issues.Issues);

issues2 = codeIssues(["MitekConstants.m", "plot_data_set.m"]);
disp("Remaining `codeIssues` issues:");
disp(issues2);
disp(issues2.Issues);
