
{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";

  outputs = { self, nixpkgs, nixpkgs-terraform, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nixpkgs-terraform.overlays.default ];
          config.allowUnfree = true;
          config.extra-substituters = "https://nixpkgs-terraform.cachix.org";
          config.extra-trusted-public-keys = "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw=";
        };

        terraform = nixpkgs-terraform.packages.${system}."1.9.5";
      in {
        devShells.default = pkgs.mkShellNoCC {
          packages = [
            pkgs.zsh
            pkgs.tflint
            terraform
          ];
          shellHook = ''
            exec $(which zsh)
          '';
        };
      }
    );
}
