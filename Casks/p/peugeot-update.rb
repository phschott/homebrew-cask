cask "peugeot-update" do
  version "1.5.2"
  sha256 "aaef7dc64eab2c29e6c1746f8f92c51279d9123b6857724ac6c4c425b083b0e0"

  # url "https://fr.ndp.awsmpsa.com/majesticinstaller/peugeot_update.dmg"
  url "https://d1tik0o5ahgjm.cloudfront.net/peugeot/peugeot_update.dmg"
  name "Peugeot Update"
  desc "Update Peugeot ystem"
  homepage "https://www.peugeot.fr/"
  
  livecheck do
    skip "No version information available"
  end

  auto_updates true

  app "Peugeot Update.app"

  zap trash: [
    "~/Library/Application Support/Peugeot Update",
    "~/Library/Preferences/com.peugeot.update.plist"
  ]
end
