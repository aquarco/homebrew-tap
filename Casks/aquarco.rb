# frozen_string_literal: true

# Homebrew cask for Aquarco CLI
#
# Installs the aquarco CLI tool for managing Aquarco VMs.
# VirtualBox and Vagrant are installed automatically as cask dependencies.

cask "aquarco" do
  version "1.0.0rc1"
  sha256 "6aa97a69e8733e7eecac6f43763c558eef5d62383ff51a3596363a72a1ca7f11"

  url "https://github.com/aquarco/aquarco/releases/download/vrc-1.0.0/aquarco-macos-arm64.tar.gz"
  name "Aquarco"
  desc "CLI for managing Aquarco autonomous agent VMs"
  homepage "https://github.com/aquarco/aquarco"

  depends_on cask: "virtualbox"
  depends_on cask: "vagrant"

  binary "aquarco"

  postflight do
    # Strip Gatekeeper quarantine so macOS doesn't block the unsigned binary
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", staged_path.to_s]
  end
end
