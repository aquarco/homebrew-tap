# frozen_string_literal: true

# Homebrew cask for Aquarco CLI
#
# Installs the aquarco CLI tool for managing Aquarco VMs.
# VirtualBox and Vagrant are installed automatically as cask dependencies.

cask "aquarco" do
  version "1.0.0rc1"
  sha256 "a0b93d523ce088be7e6f39cb407e7152256374558edf01639e5eb90b822b239d"

  url "https://github.com/aquarco/aquarco/releases/download/vrc-1.0.0/aquarco-macos-arm64.tar.gz"
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
  end
end
