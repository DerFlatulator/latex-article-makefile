COMPILER=pdflatex
SPELLER=aspell -t -c
BIBTEX=bibtex
REFERENCES=references.bib # bibtex .bib files
MAIN_TEX=main.tex # main .tex file
BIB_AUX=main.aux # .aux files
WC=texcount
# get just the text word count (no headings, citations, etc)
WC_AFTER=| grep text | head -1 | cut -d ' ' -f 4 
# file to store word count
WC_FILE=wordcount

spell: 
		make bibtex
		make $(WC_FILE)
		$(SPELLER) $(MAIN_TEX) 

nospell: 
		make bibtex
		make $(WC_FILE)
		make compile

compile: $(MAIN_TEX)
		$(COMPILER) $(MAIN_TEX)

printwordcount:
		@make $(WC_FILE)
		cat $(WC_FILE)

$(WC_FILE): $(MAIN_TEX)
		@$(WC) $(MAIN_TEX) $(WC_AFTER) > $(WC_FILE)

bibtex: $(REFRENCES)
		make compile
		$(BIBTEX) $(BIB_AUX)
		make compile
 
