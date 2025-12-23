# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.go
    pkgs.nodejs_20
    pkgs.nodePackages.nodemon
    #pkgs.postgresql_15
    pkgs.docker
    pkgs.docker-compose
    pkgs.go-migrate
  ];
  services = {
    docker.enable = true;
    postgres.enable = false;
  };
  # Sets environment variables in the workspace
  env = rec {
    DB_USER = "admin";
    DB_PASSWORD = "admin";
    DB_NAME = "go_db";
    DATABASE_URL = "postgres://${DB_USER}:${DB_PASSWORD}@localhost:5432/${DB_NAME}?sslmode=disable";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "golang.go"
      "google.gemini-cli-vscode-ide-companion"
    ];



    workspace = {
      # Commands to run when the workspace is created.
      onCreate = {
        setup = {
          openFiles = ["backend/cmd/api/app.go" ".idx/dev.nix" "backend/start.sh" ];
        };
      };
      # Commands to run when the workspace is started.
      onStart = {};
    };

    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["backend/start.sh"];
          manager = "web";
        };
      };
    };
  };
}
