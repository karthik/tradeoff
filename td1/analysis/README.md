
# Tradeoff between juvenile growth rate and maturation.


`initialize.R` - generates all the parameter combinations
`tfunctions.R` - contains all the functions necessary to run all the different tradeoffs including several helper functions. All functions are annotated.

## Simple model
`simple.R`

## using the varDev version
`vardev.R` 

`vardev.pbs`(not in the public repo)

## Now with variation in juvenile development
`juvshape.R`

`juvshape.pbs`(not in the public repo)

## Now with added correlation.
`corr.R`

`corr.pbs`(not in the public repo)


To run any scenario (`simple.R`, `vardev.R`, `juvshape.R`, or `corr.R`), run the associated R script. If running locally, comment out the `mclapply` and run only the `llply`. If running on a HPC with minimum of 4 cores (but no more than 72 since there is no performance gain after that), then use mclapply for a faster run.

