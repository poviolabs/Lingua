class Lingua < Formula
  desc "Unified localization management tool for iOS & Android via Google Sheets"
  homepage "https://github.com/poviolabs/Lingua"
  url "https://github.com/poviolabs/Lingua/archive/0.2.1.tar.gz"
  sha256 "8ea51c173e5c4edefb520798a616a829c34b6841671f60f636d49f291e72cdd1"

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

