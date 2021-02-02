# zanalyzer

zanalyzer is a macro for ImageJ that performs the following actions for a time series of z-stacks:

- Generates an intensity z-profile using the built-in ImageJ function for each z-stack and outputs each profile as a sequentially numbered CSV file.

- Finds the peak value for each profile and writes out the time point and peak value into a file.

- Plots peak intensity vs time and then performs non-linear regression, fitting an exponential decay with offset function.

## Required inputs:

- Requires a time series of z-stacks.

- The appropriate channel must be selected in the script before running.

- The time interval is set in the script, which is used for generating the intensity vs time plot.

- The script will prompt for a path in which to output the results.
