home
====

configuration files for zsh, vim, and the awesome window manager.

To install use

	git clone https://github.com/leinkemmer/home.git
	git submodule init
	git submodule update
	./install.sh
	vim +BundleInstall

Notes
=====

- The submodule is used to fetch the vundle plugin manager which then installs the remaining plugins.
- The scripts in bin have to be installed manually (if necessary).
