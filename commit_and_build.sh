git add --all
git commit -m "$1"
sudo nixos-rebuild switch --flake .
