class WorktreeLink < Formula
  desc "Automatically create symlinks from a main worktree to a new worktree based on .worktreelinks patterns"
  homepage "https://github.com/km-tr/worktree-link"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.1/worktree-link-aarch64-apple-darwin.tar.xz"
      sha256 "008abcdb3422f3c79232e6e358c20e1666041097d3fb5b5a2dd4f48f7d2b0375"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.1/worktree-link-x86_64-apple-darwin.tar.xz"
      sha256 "a311072cfae0ab9d594e5d7e1caaf9e1649c5506cc45fef2b5e9c547eb9dec9f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.1/worktree-link-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4dc86a64f9554076331a8ed3d316229acb4b4c1f5e678b691d38c1a4b9085fc8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.1/worktree-link-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1f643d54760c7b2b7644ed5665f9c54ff1893fc9a80f07e4a384eeb9a61a92b5"
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
