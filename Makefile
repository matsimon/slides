.PHONY    : view clean veryclean

# Commands
PDFLATEX = pdflatex -halt-on-error -interaction errorstopmode

# Temporary file
AUX    = $(wildcard *.aux *.log *.nav *.out *.snm *.toc *~)
BACKUP = $(wildcard *~ *.bak)
FINAL  = $(wildcard *.pdf)

# main target : create a pdf file
all: md5 main.pdf

md5:
	@echo "md5"
	[ ! "`md5sum main.tex`" = "`cat main.tex.md5`" ] && md5sum main.tex > main.tex.md5

# run pdflatex two times or the table of contents does not appear
main.pdf: main.tex.md5
	$(PDFLATEX) main.tex
	$(PDFLATEX) main.tex
	cp main.pdf final.pdf
	@echo "-> done"

clean:
	$(RM) $(AUX) $(FINAL) main.tex.md5
