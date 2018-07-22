LATEX_COMMAND:=pdflatex

BUILD_DIR:=build
PUBLISH_DIR:=pub
SRC_DIR:=src
DEST_DIRS:=$(BUILD_DIR) $(PUBLISH_DIR)

OUTPUT_PDFS:=resume.pdf
PUBLISH_PDFS:=$(foreach f,$(OUTPUT_PDFS),$(PUBLISH_DIR)/$(f))
BUILD_PDFS:=$(foreach f,$(OUTPUT_PDFS),$(BUILD_DIR)/$(f))

src_file := ""
out_file := ""

.PHONY: all
all: $(PUBLISH_PDFS)

.PHONY: quick
quick: $(BUILD_PDFS)

$(DEST_DIRS):
	mkdir $@

$(PUBLISH_PDFS): $(PUBLISH_DIR)
	cd $(SRC_DIR) && openout_any=r $(LATEX_COMMAND) -jobname=../$(basename $@) $(notdir $(basename $@)).tex
	cd $(SRC_DIR) && openout_any=r $(LATEX_COMMAND) -jobname=../$(basename $@) $(notdir $(basename $@)).tex

$(BUILD_PDFS): $(BUILD_DIR)
	cd $(SRC_DIR) && openout_any=r $(LATEX_COMMAND) -jobname=../$(basename $@) $(notdir $(basename $@)).tex

.PHONY: clean
clean:
	git clean -Xdf
