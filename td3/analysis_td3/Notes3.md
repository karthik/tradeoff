
# Notes on simulation.

1. First run `initialziation3.R`
2. comment out lines to generate params.
3. Then make sure the pbs file core number lines up with `mc.cores` in corresponding scripts.
4. Then upload functions, `*_params3.rda`, `3.R`, and `.pbs` file for each script.
5. Be sure to change the ID # of the run in the pbs file.
6. zip the files, scp to server and unzip there.
7. Cat files to make sure right ones got uploaded.
8. Once results are done, then zip up `results/*` and copy to donwload folder and move to results on `td1/results`.
