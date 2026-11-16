class WorktreeLink < Formula
  desc "Automatically create symlinks from a main worktree to a new worktree based on .worktreelinks patterns"
  homepage "https://github.com/km-tr/worktree-link"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.4/worktree-link-aarch64-apple-darwin.tar.xz"
      sha256 "15f5193ecd4895c9a9220f9f3b8459c3e3abbc12b3bc4d62df5daf8d47146975"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.4/worktree-link-x86_64-apple-darwin.tar.xz"
      sha256 "69e06e459e1c647bda47a66d08311c2d83788be6392d22864771ea0c6fd4adba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.4/worktree-link-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "114d1754da0e44532896eb22410c5f2f17f0f55d1d828b7ce8b7f0da4c321b4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.4/worktree-link-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3c83a64e199402a7684a90743cc518489ff6ee37716224d0717167b5c34c065e"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "worktree-link"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "worktree-link"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "worktree-link"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "worktree-link"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
