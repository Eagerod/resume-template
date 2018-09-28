# Resume Template

This is a LaTeX project that I built in the interest of being able to manage the design of my resume separately from the content.

It's set up to allow for users to create their CV and their resume in the same document, and to have the ability to choose how much content to include in a given output document by modifying the `\cvtrue` line in `resume.tex`

# TODO:

- [ ] Provide better examples of how to use `\cvtrue`. 
- [ ] Modify the project to actually define a `.sty` file, rather than inputting the text as it is now.
- [ ] Include a Makefile target that uploads `build/sharelatex.zip` to `aleem.haji.ca/blob` so no one needs to clone the repo to have the template
- [ ] Move some `.tex` files into commands, rather than allowing to have their own inputtable files. Consolidate more into the .sty file. 
