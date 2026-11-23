class WorktreeLink < Formula
  desc "Automatically create symlinks from a main worktree to a new worktree based on .worktreelinks patterns"
  homepage "https://github.com/km-tr/worktree-link"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.5/worktree-link-aarch64-apple-darwin.tar.xz"
      sha256 "8d95279ae4858c3a6d5a17925e9a103a5a0e4033a6cf2d57a80bb463e97fd446"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.5/worktree-link-x86_64-apple-darwin.tar.xz"
      sha256 "bc822941a8691b412d303797ee860e8fb624a0b3fb57242b8d9560787e99e828"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.5/worktree-link-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d1fbf989b8e129a62be481e426396bee8f27ef2bbb4417bca9821718ffbdddb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/km-tr/worktree-link/releases/download/v0.1.5/worktree-link-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9c8a62d63e6a26dabd0f684871d6e06ce9cd4305a4c9297bbef2b253500ee756"
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
