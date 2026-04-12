# frozen_string_literal: true

# Homebrew cask for Aquarco CLI
#
# Installs the aquarco CLI tool for managing Aquarco VMs.
# VirtualBox and Vagrant are installed automatically as cask dependencies.
#
# On first `aquarco init`, the VM is provisioned with production Docker images
# tagged rc-1.0.0 from ghcr.io/borissuska/aquarco.

cask "aquarco" do
  version "1.0.0rc1"
  sha256 "74d6f08273324e712e39faff8d3dbd0d54270b99a7c0812a9afdafae0b05a7ba"

  url "https://github.com/aquarco/aquarco/releases/download/v1.0.0rc2/aquarco-macos-arm64.tar.gz"
  name "Aquarco"
  desc "CLI for managing Aquarco autonomous agent VMs"
  homepage "https://github.com/aquarco/aquarco"

  depends_on cask: "virtualbox"
  depends_on cask: "vagrant"

  # onedir layout: aquarco/aquarco is the PyInstaller entry point
  binary "aquarco/aquarco"

  postflight do
    # Strip Gatekeeper quarantine so macOS doesn't block the unsigned binary
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", staged_path.to_s]
    # Warm up the dyld shared cache so the first user invocation is fast
    system_command "#{staged_path}/aquarco/aquarco", args: ["--help"],
                   print_stdout: false, print_stderr: false
  end
end
