class WorktreeLink < Formula
  desc "Automatically create symlinks from a main worktree to a new worktree based on .worktreelinks patterns"
  homepage "https://github.com/km-tr/worktree-link"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.3/worktree-link-aarch64-apple-darwin.tar.xz"
      sha256 "cdb30451f9cf720780caedfe8fb61f68017ca87007ed8371b6ba123db374e8bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.3/worktree-link-x86_64-apple-darwin.tar.xz"
      sha256 "ec4dc39a6377772320ccc27285425ef18afd8f96eaba04f746a8a8d6a70d20ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.3/worktree-link-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a140869987f44cdd8ec462e226982804769093c74960884fb69681c63cbc5535"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.3/worktree-link-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d8da314aaac0163d232a5f0a05eb3f8fc6c61ce4c6707487daadf1228ab24147"
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
