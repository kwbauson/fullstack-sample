scope: with scope;
let
  mkPrisma = { name, sha256 }: stdenv.mkDerivation rec {
    pname = name;
    version = "cdba6ec525e0213cce26f8e4bb23cf556d1479bb";
    src = fetchurl {
      url = "https://binaries.prisma.sh/all_commits/${version}/linux-musl/${name}.gz";
      inherit sha256;
    };
    dontUnpack = true;
    nativeBuildInputs = [ gzip ];
    buildInputs = [ openssl ];
    installPhase = ''
      mkdir -p $out/share/prisma
      cd $out/share/prisma
      cp $src ${name}-linux-nixos.gz
      gunzip *
      chmod +x *
    '';
  };
in
[
  nodejs
  yarn
  postgresql
  (mkPrisma { name = "query-engine"; sha256 = "087rzx1gzzzmbsbcq0dczwipm2jwrnfyj9qjbh2s3cdd8111dxna"; })
  (mkPrisma { name = "migration-engine"; sha256 = "00ssvz0g1cba75c46z388k99763qzkm477vk8swwb2qijpw7sdy3"; })
  (mkPrisma { name = "prisma-fmt"; sha256 = "1z4pmly8lyb8m273cxkv6f74zx5pwqi2ycgn194nqh9lscmmxkq3"; })
  (mkPrisma { name = "introspection-engine"; sha256 = "1jkk1pgx659125m519c42dqrvmvlbs7lw47v64yacfd9v4n7jb7n"; })
  (writeBashBin "prisma" ''
    engines=${source}/node_modules/@prisma/engines
    if [[ ! -e $engines/prisma-fmt-linux-nixos ]];then
      yarn
      ln -sf $(${source}/nle-pinned.sh result)/share/prisma/* "$engines"
    fi
    ./node_modules/.bin/prisma "$@"
  '')
  (appimageTools.wrapType2 {
    name = "prisma-studio";
    src = fetchurl {
      url = "https://github.com/prisma/studio/releases/download/v0.415.0/Prisma-Studio.AppImage";
      sha256 = "151pcd0aw6vlb42bw3myfr7xdd5m35wahii5zsvngrz1ydzf84w8";
    };
  })
]
