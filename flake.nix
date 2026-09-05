{
  description = "Lua dev environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem ( system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default= pkgs.mkShell {
          packages = with pkgs; [
            lua5_1
            luajit
            lua-language-server
            stylua
            neovim
          ];
        };
      }
    );
}
