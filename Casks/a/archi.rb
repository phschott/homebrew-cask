cask "archi" do
  arch arm: "Silicon-"

  version "5.2.0"
  sha256 arm:   "260fad97dd363964a6e061f117b4176d15399f15f8ff9aba2d31ae6c7590d3c1",
         intel: "188f5a200630bbad117633746373bde2c54ccc9475fa75f8b7155cbea9f5af9f"

  url "https://www.archimatetool.com/downloads/archi_5.php?/#{version}/Archi-Mac-#{arch}#{version}.dmg"
  name "Archimate modeling"
  desc "Toolkit for the ArchiMate modelling language"
  homepage "https://www.archimatetool.com/"

  livecheck do
    url "https://www.archimatetool.com/download"
    strategy :page_match
    regex(%r{href=.*?/Archi-Mac[._-]?(\d+(?:\.\d+)*)\.dmg}i)
  end

  auto_updates true
  depends_on macos: ">= :big_sur"

  app "Archi.app"

  def caveats
    <<~EOS
      To remove application from quarantine execute the following command
        xattr -r -d com.apple.quarantine #{appdir}/Archi.app
      Or install cask using --no-quarantine option
    EOS
  end

  zap trash: "~/Library/Application Support/Archi"
end
