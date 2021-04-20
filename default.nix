with (import ./helpers.nix);
let
  getByRevision = revision: name: builtins.getAttr name (channelFromRevision revision);
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
    "0.13.6" = ["810d22fb35287e14125470e3b917b90488ae5ed5" "terraform_0_13"];
    "0.13.5" = ["51d0a416d4c4ab1ad6b050ed8cb1c123ab673dd2" "terraform_0_13"];
    "0.12.30" = ["810d22fb35287e14125470e3b917b90488ae5ed5" "terraform_0_12"];
    "0.12.29" = ["51d0a416d4c4ab1ad6b050ed8cb1c123ab673dd2" "terraform_0_12"];
  };
 # 
  getByVersion = version :
    let
      p        = builtins.getAttr version revisions;
      revision = builtins.elemAt p 0;
      name     = builtins.elemAt p 1;
    in
      getByRevision revision name;
in path : getByVersion (trim (builtins.readFile (toString "${toString path}/.terraform-version")))
