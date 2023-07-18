# data
description of data repository


## analysis
info - a small info file
### R
R scripts used to make the analisys, divided by folders:

- rq1_evolution - R scripts to perform analyses and plot for the evolution of CS
- rq1_relationship_cs - R scripts to perform analyses and plot for the relationsships of CS
- rq1_trends - R scripts to perform analyses and plot for the trends evolution of CS
- rq2_g_te - R scripts to perform analyses and plot for the causality of CS -granger causality and transfer entropy
- rq2_rel_groups - R scripts to perform analyses and plot for the relations inner goups of CS
- rq3_issues - R scripts to perform analyses and plot for the correlation and causality from CS to issues -correlations, linear regressions, granger causality(4 lags) and transfer entropy(4 lags) - individual CS and in group
- rq4_bugs - R scripts to perform analyses and plot for the correlation and causality from CS to bugs -correlations, linear regressions, granger causality(4 lags) and transfer entropy(4 lags) - individual CS and in group
- rq5_time_to_release - R scripts to perform analyses and plot for the correlation and causality from CS to time-to-telase - granger causality(4 lags) and transfer entropy(4 lags) - individual CS and in group

root: R includes ( to be included in the R analisys scripts)

### Data folders used in the questions  
### rq1 
data to calculate averages and trends
### rq2 
data of correlations, linear regression, granger causality(4 lags) and transfer entropy(4 lags) inter CS groups
### rq3
data of correlations, linear regression, granger causality(4 lags) and transfer entropy(4 lags) from CS to issues, individual and in group, divided by 8 folders:
- data (values of CS density vs issues)
- data_issuesn (values of CS density vs issues density)

 - lm linear regression - values and statistical significance - separated and grouped
 - te(te lag1) to te lag4) transfer entropy values and statistical significance - separated and grouped
- data_corts  - time series correlation (CS density vs issues, no agregation)
- data_corts_absolute - time series correlation (absolute CS vs issues, no agregation)
- data_granger - granger causality (lags 1 to 4) - CS density vs issues absolute
- data_grangernnn - granger causality (lags 1 to 4) - CS density vs issues density

CS groups:
- data_scope (values of CS groups density vs issues - lm and TE - 4 lags - statistical significance and TE values)
- data_issuesn_scope (values of CS goups density vs issues density - lm and TE - 4 lags - statistical significance and TE values)

### rq4
the same as rq3 folders but for bugs
### rq5
the same as rq3 minus the correlations


## data folders
Aggregation of data, each app has two files, CSV and xls, with lines for each released official version and columns for the variable:.
Id;Version;Date;Age;VersionAge; CyclomaticComplexity; NPathComplexity;ExcessiveMethodLength;ExcessiveClassLength;ExcessiveParameterList;ExcessivePublicCount;TooManyFields;TooManyMethods;TooManyPublicMethods;ExcessiveClassComplexity;NumberOfChildren;DepthOfInheritance;CouplingBetweenObjects;DevelopmentCodeFragment;UnusedPrivateField;UnusedLocalVariable;UnusedPrivateMethod;UnusedFormalParameter; embed JS;inline JS;embed CSS;inline CSS;css in JS;css in JS: jquery; max-lines;max-lines-per-function;max-params;complexity;max-depth;max-nested-callbacks;PHP;HTML;JavaScript;CSS;HTML_template;HTML_diff;Client;SUM

## data_sep
5 files for each app, with lines corresponding to the each released official version.
### serversmells
by app and release , columns;.
Id;Version;Date; CyclomaticComplexity; NPathComplexity;ExcessiveMethodLength;ExcessiveClassLength;ExcessiveParameterList;ExcessivePublicCount;TooManyFields;TooManyMethods;TooManyPublicMethods;ExcessiveClassComplexity;NumberOfChildren;DepthOfInheritance;CouplingBetweenObjects;DevelopmentCodeFragment;UnusedPrivateField;UnusedLocalVariable;UnusedPrivateMethod;UnusedFormalParameter
### clientsmells
by app and release , columns;.
Id;Version;Date; embed JS;inline JS;embed CSS;inline CSS;css in JS;css in JS: jquery
### jssmells
by app and release , columns;.
Id;Version;Date; max-lines;max-lines-per-function;max-params;complexity;max-depth;max-nested-callbacks
### Cloc(metrics)
by app and release , columns;.
"id";"version";"PHP";"HTML";"JavaScript";"CSS";"HTML_template";"HTML_diff";"Client";"SUM"
### version
by app and release , columns;.
"id";"version";"date"

## issues_bugs
3 folders
### data
issues by app by release (lines/records) with columns:.
id;version1;version2;date1;date2;count
### data_bugs_more 
the same but only bugs, by app by release (lines/records) with columns:.
id;version1;version2;date1;date2;count

### scripts
scrips used to aggregate issues (from daily issues to by release) anf the same for bugs




