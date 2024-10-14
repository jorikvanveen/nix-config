{ pkgs, ... }: {
  # NodeJS workaround for Zed https://github.com/zed-industries/zed/issues/12631
  xdg.dataFile = let
    nodeVersion = "node-v22.5.1-linux-x64";
    nodePackage = pkgs.nodejs_22;
  in {
    # Adding different directories one by one, as Zed wants to write to the "./cache" dir
    "zed/node/${nodeVersion}/bin".source = "${nodePackage}/bin";
    "zed/node/${nodeVersion}/include".source = "${nodePackage}/include";
    "zed/node/${nodeVersion}/lib".source = "${nodePackage}/lib";
    "zed/node/${nodeVersion}/share".source = "${nodePackage}/share";
  };
}
