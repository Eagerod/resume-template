src_file := ""
out_file := ""

resume.pdf:
	pdflatex resume.tex
	$(eval src_file := resume.tex)
	$(eval out_file := resume.pdf)

production:
	pdflatex $(src_file)

open:
	open $(out_file)

resume: resume.pdf

clean:
	rm -f *.toc *.synctex *.aux *.log *.synctex.gz *.lof *.upa *.upb *.out *.nav *.snm resume.pdf || echo "";

.PHONY: clean, resume, production, open
