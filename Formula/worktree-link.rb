class WorktreeLink < Formula
  desc "Automatically create symlinks from a main worktree to a new worktree based on .worktreelinks patterns"
  homepage "https://github.com/km-tr/worktree-link"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.2/worktree-link-aarch64-apple-darwin.tar.xz"
      sha256 "c8a3fb73b6b2db748afb1a7917817e226fad593e3956de2042d2895f29b5f67b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.2/worktree-link-x86_64-apple-darwin.tar.xz"
      sha256 "e0c3cb933db2c15dc2a797ddbfe9da52361c35aa788f03ef0707c388843c71af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.2/worktree-link-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a99b8b6b761ef5f412c0eb620b4252cbc83519f9744c60b776d7baa012466baf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.2/worktree-link-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "77dce80593e74776e15c389dd4cc69f6d8d5460c743b73c1a60e153f93423c26"
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
