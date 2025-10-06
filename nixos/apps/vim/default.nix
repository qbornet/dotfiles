{ pkgs, ... }:


with pkgs;

let myVim = vim_configurable.customize {
	name = "vim";
	vimrcConfig = {
		customRC = builtins.readFile ./.vimrc;
	};
};

in {
	environment.systemPackages = with pkgs; [ myVim ];
	environment.variables = { EDITOR = "vim"; };
}
