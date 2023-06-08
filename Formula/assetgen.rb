class AssetGen < Formula
  desc "Unified localization management tool for iOS & Android via Google Sheets"
  homepage "https://github.com/poviolabs/AssetGen"
  url "https://github.com/poviolabs/AssetGen/archive/0.1.0.tar.gz"
  sha256 "cf0b2a3577fe5dbe16431e00c961b768765576ffce2367e6969e558f193144cd"

  depends_on :xcode => ["12.0", :build]

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "-Xswiftc", "-static-stdlib"
    bin.install '.build/release/AssetGen'
    bin.install_symlink bin/"AssetGen" => "assetgen"
  end

  test do
    system "#{bin}/AssetGen", "--version"
  end
end

