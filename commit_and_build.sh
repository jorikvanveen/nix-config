git add --all &&
sudo nixos-rebuild switch --flake . &&
git commit -m "$1"
