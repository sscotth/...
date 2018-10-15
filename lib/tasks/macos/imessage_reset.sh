# NOT READY

# https://www.tonymacx86.com/threads/an-idiots-guide-to-imessage.196827/

# Open Safari and log in to iCloud.com
# Click on Find iPhone
# Click the down arrow next to All Devices
# If there are spurious devices in the list from previous failed attempts click each one and Remove from Account.
# You should also remove any unwanted devices from your Apple ID through the link on the iCloud page,
# or by directly logging in to your Apple ID page.
# Sign Out of iCloud.com
# Close Safari

# Open System Preferences - iCloud : Click Sign Out
# Disconnect from the network then Restart

rm -rf ~/Library/Caches/com.apple.iCloudHelper
rm -rf ~/Library/Caches/com.apple.imfoundation.IMRemoteURLConnectionAgent
rm -rf ~/Library/Caches/com.apple.Message

rm -rf ~/Library/Preferences/com.apple.iChat.*
rm -rf ~/Library/Preferences/com.apple.icloud.*
rm -rf ~/Library/Preferences/com.apple.ids.service*
rm -rf ~/Library/Preferences/com.apple.imagent.*
rm -rf ~/Library/Preferences/com.apple.imessage.*
rm -rf ~/Library/Preferences/com.apple.imservice.*
