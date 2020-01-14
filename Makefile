# This makefile is provided to create the tools needed to either build this
#   document locally, or package it up to be imported to a sharelatex
#   deployment
LATEX_COMMAND:=lualatex

BUILD_DIR:=build
PUBLISH_DIR:=pub
SRC_DIR:=src
DEST_DIRS:=$(BUILD_DIR) $(PUBLISH_DIR)

SRC_FILES=$(shell find $(SRC_DIR) -type f -iname "*.tex")

OUTPUT_PDFS:=resume.pdf
PUBLISH_PDFS:=$(foreach f,$(OUTPUT_PDFS),$(PUBLISH_DIR)/$(f))
BUILD_PDFS:=$(foreach f,$(OUTPUT_PDFS),$(BUILD_DIR)/$(f))

IMG_DIR:=$(SRC_DIR)/img
IMAGES:=\
	$(IMG_DIR)/In-Black-0p5in-TM.eps \
	$(IMG_DIR)/GitHub-Mark.eps


.PHONY: all
all: $(PUBLISH_PDFS)

.PHONY: quick
quick: $(BUILD_PDFS)

$(BUILD_DIR)/sharelatex.zip: $(BUILD_DIR) $(IMAGES) $(SRC_FILES)
	cd $(SRC_DIR) && zip -r ../$@ $$(find . -type f)

# Unwrap an existing build/sharelatex.zip into the source directory.
# For loading source packages from sharelatex
.PHONY: unzip
unzip:
	if [ ! -z "$$(git diff $(SRC_DIR))" ]; then \
		echo >&2 "There are unstaged changes in the $(SRC_DIR) dir. Cannot extract."; \
		exit -1; \
	fi
	rm -rf $(SRC_DIR)
	mkdir -p $(SRC_DIR)
	unzip $(BUILD_DIR)/sharelatex.zip -d $(SRC_DIR)

$(DEST_DIRS) $(IMG_DIR):
	mkdir $@

$(PUBLISH_PDFS): $(PUBLISH_DIR) $(IMAGES) $(SRC_FILES)
	cd $(SRC_DIR) && openout_any=r $(LATEX_COMMAND) -jobname=../$(basename $@) $(notdir $(basename $@)).tex
	cd $(SRC_DIR) && openout_any=r $(LATEX_COMMAND) -jobname=../$(basename $@) $(notdir $(basename $@)).tex

$(BUILD_PDFS): $(BUILD_DIR) $(IMAGES) $(SRC_FILES)
	cd $(SRC_DIR) && openout_any=r $(LATEX_COMMAND) -jobname=../$(basename $@) $(notdir $(basename $@)).tex

.PHONY: clean
clean:
	git clean -Xdf

.PHONY: mostlyclean
mostlyclean:
	git clean -xdf --exclude='$(IMG_DIR)/*'

.INTERMEDIATE: linkedin_brand_package.zip
linkedin_brand_package.zip:
	curl https://content.linkedin.com/content/dam/brand/site/brand-assets/linkedin_brand_package.zip -o linkedin_brand_package.zip

$(IMG_DIR)/In-Black-0p5in-TM.eps: $(IMG_DIR) linkedin_brand_package.zip
	if [ ! -d linkedin_brand_package ]; then \
		unzip linkedin_brand_package.zip -d linkedin_brand_package; \
	fi
	cp "linkedin_brand_package/linkedin_brand_package/LinkedIn [in]/Print/Black/In-Black-0p5in-TM.eps" $@

.INTERMEDIATE: GitHub-Mark.zip
GitHub-Mark.zip:
	curl https://github-media-downloads.s3.amazonaws.com/GitHub-Mark.zip -o GitHub-Mark.zip

$(IMG_DIR)/GitHub-Mark.eps: $(IMG_DIR) GitHub-Mark.zip
	if [ ! -d GitHub-Mark ]; then \
		unzip GitHub-Mark.zip -d GitHub-Mark; \
	fi
	cp "GitHub-Mark/GitHub-Mark/Vector/GitHub-Mark.eps" $@
