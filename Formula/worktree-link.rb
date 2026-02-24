class WorktreeLink < Formula
  desc "Automatically create symlinks from a main worktree to a new worktree based on .worktreelinks patterns"
  homepage "https://github.com/km-tr/worktree-link"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.0/worktree-link-aarch64-apple-darwin.tar.xz"
      sha256 "533154c60ad65af3302c22cbb09f7c2c2d4cc686503eb376b07e7ba3ac53df16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.0/worktree-link-x86_64-apple-darwin.tar.xz"
      sha256 "fa1c6e1f9745e5679b94b915e21429726caa881a419239b378c57fa48236ca35"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.0/worktree-link-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c695bcc0ded41365d25d0fe683382f15ade634e848e2087621b77c6b5ff3e158"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.0/worktree-link-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4448ef4611af34c4e7a87ff7dff588067c338ca2e33b1fb8cd4d230259502d04"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {
      "worktree-link": [
        "wtl",
      ],
    },
    "aarch64-unknown-linux-gnu": {
      "worktree-link": [
        "wtl",
      ],
    },
    "x86_64-apple-darwin":       {
      "worktree-link": [
        "wtl",
      ],
    },
    "x86_64-unknown-linux-gnu":  {
      "worktree-link": [
        "wtl",
      ],
    },
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "worktree-link" if OS.mac? && Hardware::CPU.arm?
    bin.install "worktree-link" if OS.mac? && Hardware::CPU.intel?
    bin.install "worktree-link" if OS.linux? && Hardware::CPU.arm?
    bin.install "worktree-link" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
