home
====

configuration files for zsh, vim, and the awesome window manager.

To install use

	git clone https://github.com/leinkemmer/home.git
	cd home
	git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
	./install.sh
	vim +BundleInstall

To use command-t

	sudo apt-get install vim-nox ruby-dev # in Ubuntu (to get ruby support)
	cd ~/.vim/bundle/Command-T/ruby/command-t
	ruby extconf.rb
	make


Notes
=====

- The scripts in bin have to be installed manually (if necessary). A possible crontab entry for battery-check is
*/1 * * * * /usr/bin/battery-check.sh

- The .desktop files have to be installed manually (if necessary) to ~/.config/autostart

