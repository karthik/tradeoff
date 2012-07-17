# Readme for the viz folder.

1. First run `prep_plots.R` to read all the simulation results, calculate the `arg_max()` and then save those to a `data.table`
This will generate a set of 5 files:
	 * `all_results_new.rda`
	 * `working_simple.rda`
	 * `working_vd.rda`
	 * `working_js.rda`
	 * `working_corr.rda`

2. Next run `generate_all_plots.R` to plot these results. Required functions are sourced from `plot_functions.R`. The resulting PDF files are saved to the pdf folder. In the next iteration of this script you will have to save `.eps` files instead for publication quality figures.