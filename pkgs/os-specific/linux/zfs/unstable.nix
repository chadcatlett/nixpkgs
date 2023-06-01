{ callPackage
, kernel ? null
, stdenv
, linuxKernel
, ...
} @ args:

let
  stdenv' = if kernel == null then stdenv else kernel.stdenv;
in
callPackage ./generic.nix args {
  # check the release notes for compatible kernels
  # NOTE:
  #   zfs-2.1.9<=x<=2.1.10 is broken with aarch64-linux-6.2
  #   for future releases, please delete this condition.
  kernelCompatible = if stdenv'.isx86_64
    then kernel.kernelOlder "6.4"
    else kernel.kernelOlder "6.2";
  latestCompatibleLinuxPackages = linuxKernel.packages.linux_6_3;

  # this package should point to a version / git revision compatible with the latest kernel release
  # IMPORTANT: Always use a tagged release candidate or commits from the
  # zfs-<version>-staging branch, because this is tested by the OpenZFS
  # maintainers.
  version = "2.1.12-staging-2023-05-30";
  rev = "671b1af1bc4b20ddd939c2ede22748bd027d30be";

  sha256 = "tJLwyqUj1l5F0WKZDeMGrEFa8fc/axKqm31xtN51a5M=";

  isUnstable = true;
}
