rm -f *.tex
rm -f *.pdf

pandoc BOOK.md -s -o MPSoC-MSP430.tex
pandoc BOOK.md -s -o MPSoC-MSP430.pdf
