class Lingua < Formula
  desc "Unified localization management tool for iOS & Android via Google Sheets"
  homepage "https://github.com/poviolabs/Lingua"
  url "https://github.com/poviolabs/Lingua/archive/0.2.0.tar.gz"
  sha256 "cf0b2a3577fe5dbe16431e00c961b768765576ffce2367e6969e558f193144cd"

  depends_on :macos
  depends_on :xcode => ["14.1", :build]

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--disable-automatic-resolution"
    bin.install '.build/release/Lingua'
  end

  test do
    system "#{bin}/Lingua", "--version"
  end
end

