SHELL := sh

default: dotfiles

dotfiles:
	@echo -e "\nCreating symlinks..."
	@for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" -not -name ".gitignore"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; 
	@echo -e "\n\033[0;32mDone! \033[0mReset your terminal with 'exec bash'.\n"
	@exit 0
