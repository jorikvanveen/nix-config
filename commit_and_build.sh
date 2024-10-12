git add --all &&
sudo nixos-rebuild switch --print-build-logs --flake . &&
git add --all &&
git commit -m "$1"
