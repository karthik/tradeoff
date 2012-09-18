# Life-history tradeoff analysis

author: Karthik Ram, [karthik.ram@gmail.com](mailto:karthik.ram@gmail.com)

This repository contains all the code for my paper on life history trade off analysis. I'll flesh this README more shortly but for the time being, here is the organizational set up:

```
td1 (growth rate versus juvenile survival)
	|_analysis
	|_results
	|_viz (visualization)

td2 (adult survival versus fecundity). This is now deprecated.
	|_analysis
	|_results
	|_viz (visualization)

td1 (growth rate versus fecundity)
	|_analysis
	|_results
	|_viz (visualization)
```
Each trade off folder has a more detailed README.

## Manuscript

Current version of the manuscript is in the `manuscript/` folder. To update the `PDF` and `.docx` version to most current, run the following commands:

```
# To generate a PDF
pandoc -s -S --bibliography tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o test.pdf
# To generate a word document.
pandoc -s -S --bibliography tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o test.docx

```
