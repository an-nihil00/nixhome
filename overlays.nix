[
  (self: super: {
    discord = super.discord.overrideAttrs (_: {
      version = "0.0.13";
      src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz;
    }
    );
  })
]
