with (import ./helpers.nix);
let
  getByRevision = revision: name: builtins.getAttr name (channelFromRevision revision);

  defaultRevision = "e18275de12715ec0296a1e7177bb6f8c583d769c";
  defaultChannel = channelFromRevision defaultRevision;
  load = plugin defaultChannel;
  loadZip = pluginZip defaultChannel;
  loadObject = { inherit load loadZip; };

  revisions = {
    "0.15.0" = ["e18275de12715ec0296a1e7177bb6f8c583d769c" "terraform_0_15"];
    "0.14.10" = ["e18275de12715ec0296a1e7177bb6f8c583d769c" "terraform_0_14"];
    "0.14.9" = ["6e2ec95de8804f4f7d44acb97d1557eb17280947" "terraform_0_14"];
    "0.14.8" = ["810d22fb35287e14125470e3b917b90488ae5ed5" "terraform_0_14"];
    "0.14.7" = ["e03c068af5c9ca950214cd6c3b5cfe67f595da88" "terraform_0_14"];
    "0.14.6" = ["ead24f04b06a5d5cb224b1cb5be6ae59c58c6915" "terraform_0_14"];
    "0.14.5" = ["71cda4f1118d41db29e50077fb8611f9ac472b8e" "terraform_0_14"];
    "0.14.4" = ["4a7f99d55d299453a9c2397f90b33d1120669775" "terraform_0_14"];
    "0.14.3" = ["51d0a416d4c4ab1ad6b050ed8cb1c123ab673dd2" "terraform_0_14"];
    "0.14.2" = ["cc9c82074ea179460a1ca0b99322c1e52739f2f2" "terraform_0_14"];
    "0.14.0" = ["51c28d600a23b58f93940b04757beaef88ef70bb" "terraform_0_14"];
    "0.13.6" = ["810d22fb35287e14125470e3b917b90488ae5ed5" "terraform_0_13"];
    "0.13.5" = ["51d0a416d4c4ab1ad6b050ed8cb1c123ab673dd2" "terraform_0_13"];
    "0.13.4" = ["c79ff8ddca6a18fc04873221ed2544c41993cd2c" "terraform_0_13"];
    "0.13.3" = ["eb6e2ac2c033a86afa6a606753aab0dbde8bddda" "terraform_0_13"];
    "0.13.2" = ["8761381344a56a2e05229e2cbbf8b580d206ceed" "terraform_0_13"];
    "0.13.1" = ["f99908924015bb83df8186b2c473919be35b43f0" "terraform_0_13"];
    "0.13.0" = ["6449c5eee5ef929a8a2f1ac30699a50907e1a2ed" "terraform_0_13"];
    "0.12.30" = ["810d22fb35287e14125470e3b917b90488ae5ed5" "terraform_0_12"];
    "0.12.29" = ["51d0a416d4c4ab1ad6b050ed8cb1c123ab673dd2" "terraform_0_12"];
    "0.12.28" = ["2db12af9b71e8d33969daad7fa238c8b28add854" "terraform_0_12"];
    "0.12.27" = ["05c54bd0e1626193347bb5bb5713103942d18629" "terraform_0_12"];
    "0.12.26" = ["c9e985469f565fd01292571a88c2a8b46d46bb63" "terraform_0_12"];
    "0.12.25" = ["0b72a749ae200b30a1ed0379cca7dc989763c8df" "terraform_0_12"];
    "0.12.24" = ["b5dc07a4b471e6f651af3b13e4bd841b6b3ea6ed" "terraform_0_12"];
    "0.11.14" = ["9b2804b7b3f1efc99036bd5bda6338a680c2f2f1" "terraform_0_11"];
  };

  getByVersion = version :
    let
      p        = builtins.getAttr version revisions;
      revision = builtins.elemAt p 0;
      name     = builtins.elemAt p 1;
    in
      getByRevision revision name;

in path : (getByVersion (trim (builtins.readFile (toString "${toString path}/.terraform-version"))) // loadObject)
