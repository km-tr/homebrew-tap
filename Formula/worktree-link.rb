class WorktreeLink < Formula
  desc "Automatically create symlinks from a main worktree to a new worktree based on .worktreelinks patterns"
  homepage "https://github.com/km-tr/worktree-link"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.7/worktree-link-aarch64-apple-darwin.tar.xz"
      sha256 "1fbb308d6a697ad5d5b60bf02492b261dbaa3b5d5ab0dc8b8195151fb453383f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.7/worktree-link-x86_64-apple-darwin.tar.xz"
      sha256 "bc6a8d1ed6a39585e1a0249c79cb26a0cf7ad8333880d2d5400ed9a50f1bc288"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.7/worktree-link-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0dfee7ffc57c261c25b1659de0e75d4c2b24839e59a198674a37b3f62276ed5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.7/worktree-link-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8f2181d674433034b4a19a858a6d2dca4ff70799135b71922e54e7bd02893df5"
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
