cp /Users/karthik/Documents/Work/Reference/BibTex/Tradeoff.bib .

# Generating a PDF
# pandoc -s -S --bibliography Tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o ms.pdf

# Generating Word
# pandoc -s -S --bibliography Tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o ms.docx

# Generating Tex
# pandoc -s -S --bibliography Tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o ms.tex

# Generating Plain Text
# pandoc -s -S --bibliography Tradeoff.bib --mathjax --csl the-american-naturalist.csl tradeoffms.md -o ms.txt

# Finally opening the PDF for veiwing
#open ms.pdf

# ------------------------------------
# Commented out stuff above while fleshing out lit review

pandoc -s -S --bibliography Tradeoff.bib --csl the-american-naturalist.csl  lit_review.md -o lit_review.pdf 
open lit_review.pdf

