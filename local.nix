scope: with scope;
let
  # updated from https://github.com/prisma/prisma/issues/3026#issuecomment-862817292
  prisma-engines = pkgs.rustPlatform.buildRustPackage rec {
    pname = "prisma-engines";
    version = "cdba6ec525e0213cce26f8e4bb23cf556d1479bb";
    # https://github.com/sfackler/rust-openssl/blob/master/openssl/src/lib.rs#L55-L62
    OPENSSL_NO_VENDOR = "1";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    # https://github.com/danburkert/prost/blob/32ad5a2e1036a9c9425f0a84f032ba9f343b133e/prost-build/build.rs#L1-L15
    PROTOC = "${pkgs.protobuf}/bin/protoc";
    PROTOC_INCLUDE = "${pkgs.protobuf}/include";
    src = pkgs.fetchFromGitHub {
      owner = "prisma";
      repo = pname;
      rev = version;
      sha256 = "dtkLt1NPboTsvdXM/kcArUrjhVqIohZrr+plwy5gpdk=";
    };
    buildInputs = with pkgs; [ protobuf zlib.dev ] ++ lib.optionals stdenv.isDarwin
      (with darwin.apple_sdk.frameworks; [ CoreFoundation libiconv Security System ]);
    doCheck = false; # would otherwise need to start actual postgresql server on installation
    cargoSha256 = "5pckCjRfBH8QVXxnZ8f6TxALG7C9ZrAd0Y6j+bl+BYY=";
  };
in
[
  nodejs_latest
  (yarn.override { nodejs = nodejs_latest; })
  postgresql
  prisma-engines
  (writeBashBin "prisma" ''
    [[ ! -e ${source}/node_modules/.bin/prisma ]] && yarn
    exec ${source}/node_modules/.bin/prisma "$@"
  '')
]
