#!/usr/bin/env bash

# .macos - Inspired by https://github.com/mathiasbynens/dotfiles

# Ask for the admin password
sudo -v

# Disable boot sound effect
sudo nvram SystemAudioVolume=" "

# Increase window resize speed for Cocoa apps
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Remove duplicates in the "Open With" menu (also see lscleanup alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode --bool true

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnable -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Show icons for hard drives, servers, removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
chflags nohidden /Volumes

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Mail: Disable send and reply animations
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Mail: Copy email addresses as "foo@examile.com" instead of "Foo Bar <foo@example.com>"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Mail: Command + Enter shortcut to send email
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# Terminal: Only use UTF-8
defaults write com.apple.terminal StringEncodings -array 4

# Terminal: Use Shadowfacts.terminal theme
oascript <<EOD
tell application "Terminal"
	
	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Shadowfacts"

	set initialOpenedWindows to id of every window

	do shell script "open '$HOME/init/" & themeName & ".terminal'"

	delay 1

	set default settings to settings set themeName

	set allOpenedWindows to id of every window

	repeat with windowID in allOpenedWindows
		
		if initialOpenedWindows does not contain windowID then
			close (every window where id is windowID)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if

	end repeat
end tell
EOD

# Time Machine: Prevent prompting to use new hard drives as backup volumes
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Activity Monitor: Sort results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# App Store: Download newly available updates in the background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# App Store: Install system data files and security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Photos: Don't automatically when devices are connected
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install zsh
brew install zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Change shell
chsh -s /usr/bin/zsh

# Symlink all the things
ln -s .hammerspoon $HOME/.hammerspoon
ln -s .vim $HOME/.vim
ln -s .vimrc $HOME/.vimrc
ln -s .zshrc $HOME/.zshrc
ln -s shadowfacts.zsh-theme $HOME/.oh-my-zsh/themes/shadowfacts.zsh-theme

source $HOME/.zshrc

# Done
echo "Done. Some changes may require logout/restart to take effect."