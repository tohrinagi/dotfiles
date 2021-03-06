DOT_FILES = .zshrc .vimrc .vim .gvimrc .vsvimrc .xvimrc .atom .tmux.conf .editorconfig

all: zsh vim gvim vsvim xvim atom tmux editorconfig

zsh: $(foreach f, $(filter .zsh%, $(DOT_FILES)), link-dot-file-$(f))

vim: $(foreach f, $(filter .vim%, $(DOT_FILES)), link-dot-file-$(f))

gvim: $(foreach f, $(filter .gvim%, $(DOT_FILES)), link-dot-file-$(f))

vsvim: $(foreach f, $(filter .vsvimrc, $(DOT_FILES)), link-dot-file-$(f))

xvim: $(foreach f, $(filter .xvimrc, $(DOT_FILES)), link-dot-file-$(f))

atom: $(foreach f, $(filter .atom%, $(DOT_FILES)), link-dot-file-$(f))

tmux: $(foreach f, $(filter .tmux.conf, $(DOT_FILES)), link-dot-file-$(f))

editorconfig: $(foreach f, $(filter .editorconfig, $(DOT_FILES)), link-dot-file-$(f))

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
