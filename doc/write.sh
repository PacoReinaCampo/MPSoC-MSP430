rm -f *.tex
rm -f *.pdf

pandoc ../README.md -s -o MPSoC-MSP430.tex
pandoc ../README.md -s -o MPSoC-MSP430.pdf

pandoc ../README-ES.md -s -o MPSoC-MSP430-ES.tex
pandoc ../README-ES.md -s -o MPSoC-MSP430-ES.pdf
