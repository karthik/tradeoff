# Karthik's OCD notes on the model


1. ### First, understand how the trade-off functions work.

working on it.

2. ### Code up a range of parameter values

working on it.

3. ### Write up a spline function.

working on it.

4. ### Get some values into a table

working on it.

5. ### How to create a final PDF document

<pre>
# In R

knit('results_knit_.md')

# In Terminal

Rscript -e "library(knitr); knit('results_knit_.md')"

**Then to convert to PDF:**

pandoc -s report.md -t latex -o report2.pdf
</pre>

