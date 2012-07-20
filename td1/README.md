# Tradeoff 1 (juvenile growth versus survival.)

Structure of the analysis.

```
Analysis (folder)

# Supporting scripts

|_ initialize.R 
|_ recreate_parameters.R (not necessary to run unless I change something. Be sure to comment out the line in initialize.R)
|_ tfunctions.R (contains all functions for the analysis)

# RDA Files
|_ basic_params.rda (use for simple and basic)
|_ vd_params.rda (use for juvshape)
|_ corr_params.rda (use for corr) - split into 9 files under the corr folder for faster running.


# Actual analysis scripts
|_ simple.R (easy to run locally)
|_ vardev.R + vardev.pbs (runs the vardev case, should be similar to simple)
|_ juvshape.R + juvshape.pbs (runs the juvshape version)
|_ corr.R + corr.pbs (runs the ones with correlations, takes the longest.)

```

