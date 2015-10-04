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

	apt-get install vim-nox ruby-dev is required)  # in Ubuntu (to get ruby support)
	cd ~/.vim/bundle/Command-T/ruby/command-t
  ruby extconf.rb
	make


Notes
=====

- The scripts in bin have to be installed manually (if necessary).
