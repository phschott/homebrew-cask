cask "silentknight" do
  on_mojave :or_older do
    version "1.21,2022.06"
    sha256 "c1cbb734f620e073f1c08c473edaa036c2b5ccdca02baa99ca117f86c10ad505"

    livecheck do
      skip "Legacy version"
    end
  end
  on_catalina :or_newer do
    version "2.11,2024.09"
    sha256 "083fe1d6afe5aa9700cc113f03e7d2f219397cf5da2a1906c1f56ea60062a6e2"

    livecheck do
      url "https://raw.githubusercontent.com/hoakleyelc/updates/master/eclecticapps.plist"
      regex(%r{/(\d+)/(\d+)/[^/]+?$}i)
      strategy :xml do |xml, regex|
        item = xml.elements["//dict[key[text()='AppName']/following-sibling::*[1][text()='SilentKnight#{version.major}']]"]
        next unless item

        version = item.elements["key[text()='Version']"]&.next_element&.text
        url = item.elements["key[text()='URL']"]&.next_element&.text
        match = url.strip.match(regex) if url
        next if version.blank? || match.blank?

        "#{version.strip},#{match[1]}.#{match[2]}"
      end
    end
  end

  # Upstream zero-pads the minor version in the no-dot filename version to two
  # digits (e.g. 2.9 is 209). We only need this workaround while the minor
  # version is less than two digits, so we should be able to switch back to
  # `version.csv.first.no_dots` in the filename with version 2.10+.`
  no_dot_version = version.csv.first.split(".").each_with_index.map do |n, i|
    (i < 1 || n.length > 1) ? n : n.rjust(2, "0")
  end.join

  url "https://eclecticlight.co/wp-content/uploads/#{version.csv.second.major}/#{version.csv.second.minor}/silentknight#{no_dot_version}.zip"
  name "SilentKnight"
  desc "Automatically checks computer's security"
  homepage "https://eclecticlight.co/lockrattler-systhist/"

  no_autobump! because: :requires_manual_review

  app "silentknight#{no_dot_version}/SilentKnight.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/co.eclecticlight.silentknight.sfl*",
    "~/Library/Caches/co.eclecticlight.SilentKnight",
    "~/Library/HTTPStorages/co.eclecticlight.SilentKnight",
    "~/Library/Preferences/co.eclecticlight.SilentKnight.plist",
    "~/Library/Saved Application State/co.eclecticlight.SilentKnight.savedState",
  ]
end
