pandoc -s -S --bibliography tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o ms.pdf
# open ms.pdf

pandoc -s -S --bibliography tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o ms.docx
pandoc -s -S --bibliography tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o ms.tex
pandoc -s -S --bibliography tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o ms.txt

open ms.pdf

