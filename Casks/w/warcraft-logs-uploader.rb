cask "warcraft-logs-uploader" do
  version "8.3.10"
  sha256 "2201c493675a9f2947f81a10620f3b082415d8acfcb50287e1da3cad6e2ca87c"

  url "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v#{version}/warcraftlogs-v#{version}.dmg",
    verified: "github.com/RPGLogs/Uploaders-warcraftlogs/"
  name "Warcraft logs"
  desc "Client to upload warcraft logs"
  homepage "https://classic.warcraftlogs.com"

  livecheck do
    url "https://classic.warcraftlogs.com/client/download"
    strategy :page_match
    regex(%r{.*?/warcraftlogs[._-]v?(\d+(?:\.\d+)*)\.dmg}i)
  end

  auto_updates true
  depends_on macos: ">= :big_sur"

  app "Warcraft Logs Uploader.app"

  zap trash: "~/Library/Application Support/Warcraft Logs Uploader"
end