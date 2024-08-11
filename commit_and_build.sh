git add --all &&
sudo nixos-rebuild dry-build --flake . &&
git commit -m "$1" &&
sudo nixos-rebuild switch --flake .
