class Lingua < Formula
  desc "Unified localization management tool for iOS & Android via Google Sheets"
  homepage "https://github.com/poviolabs/Lingua"
  url "https://github.com/poviolabs/Lingua/archive/0.2.1.tar.gz"
  sha256 "8288b4702a4a42494dbdd5aedb01884a340653f7dcfd99bc4da33d441c14d555"

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

