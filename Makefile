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
	git clean -fX

.PHONY: clean, resume, production, open
