git add --all &&
sudo nixos-rebuild switch --flake . &&
git add --all &&
git commit -m "$1"
