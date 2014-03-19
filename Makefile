DOT_FILES = .zshrc .vimrc .vim .gvimrc

all: zsh vim gvim

zsh: $(foreach f, $(filter .zsh%, $(DOT_FILES)), link-dot-file-$(f))

vim: $(foreach f, $(filter .vim%, $(DOT_FILES)), link-dot-file-$(f))
  
gvim: $(foreach f, $(filter .gvim%, $(DOT_FILES)), link-dot-file-$(f))

.PHONY: clean
clean: $(foreach f, $(DOT_FILES), unlink-dot-file-$(f))
  

link-dot-file-%: %
	@echo "Create Symlink $< => $(HOME)/$<"
ifeq ($(OS),Windows_NT)
	cmd /c mklink "$(shell cygpath -w $(HOME) )\$<" "$(shell cygpath -w $(CURDIR))\$<"
else
	@ln -snf $(CURDIR)/$< $(HOME)/$<
endif

unlink-dot-file-%: %
	@echo "Remove Symlink $(HOME)/$<"
	@$(RM) $(HOME)/$<
