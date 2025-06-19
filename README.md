# kubectl

Packaging for the `kubectl` Kubernetes client
(<https://github.com/kubernetes/kubernetes/tree/master/cmd/kubectl>).

## Installation

### Debian-like distributions

1. Update the `apt` package index and install packages needed to use the
   `kubectl` `apt` repository. The following steps assume that your `apt`
   package version is `2.3.10` or greater.

   ```shell
   sudo apt-get update
   sudo apt-get install --assume-yes "ca-certificates"
   ```

2. Install the `sources.list(5)` file for the `kubectl` `apt` repository.

   ```shell
   cat << _EOF_ | sudo tee "/etc/apt/sources.list.d/kubectl.sources"
   Types: deb
   URIs: https://cavcrosby.github.io/kubectl/deb
   Suites: all
   Components: main
   Architectures-Remove: i386
   Signed-By:
    -----BEGIN PGP PUBLIC KEY BLOCK-----
    .
    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
    ryw+FcyscJolz1vDJThu6gxJ
    =ueIN
    -----END PGP PUBLIC KEY BLOCK-----
   ```

3. Update the `apt` package index, then install `kubectl`.

   ```shell
   sudo apt-get update
   sudo apt-get install --assume-yes "kubectl"
   ```

## License

See LICENSE.
