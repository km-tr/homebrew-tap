class WorktreeLink < Formula
  desc "Automatically create symlinks from a main worktree to a new worktree based on .worktreelinks patterns"
  homepage "https://github.com/km-tr/worktree-link"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.6/worktree-link-aarch64-apple-darwin.tar.xz"
      sha256 "8b7547e67adbe7c37b393534fe46748cecacb02c748c279529d9bab05256e177"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.6/worktree-link-x86_64-apple-darwin.tar.xz"
      sha256 "762f46b8d5161a9911b6c388a307a1e5904b2462b9c21cd8cc91f8810993865e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.6/worktree-link-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2c9ede5433c05799fb827db82b773c6713ed0276552a8ac58219d8dad1968b33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.6/worktree-link-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "259fbd38b7273e40fdc1f6e0f613937a2c45fb53eb35b5da609d9f53089bc6d0"
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
