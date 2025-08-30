##########################
## sharing (unencrypted):# (e.g.: cp xxx ~/Library/Mobile\ Documents/com~apple~CloudDocs/ish-shared)
#########################
# cp ~/.ssh ~/Library/Mobile\ Documents/com~apple~CloudDocs/ish-shared

# alternative, to keep it up-to-date without running ./share-macos.sh  (unencrypted!!)
# ln -s ~/.ssh ~/Library/Mobile\ Documents/com~apple~CloudDocs/ish-shared

########################
## sharing (encrypted):#
########################
mkdir ~/ish-shared-temp

cp -R ~/.ssh ~/ish-shared-temp

# encrypt tar file, send to icloud/ish-shared as encrypted.tar.gz
export GPG_TTY=$(tty)
tar -czf - -C ~/ ish-shared-temp | gpg -c > ~/Library/Mobile\ Documents/com~apple~CloudDocs/ish-shared/encrypted.tar.gz.gpg
rm -rf ~/ish-shared-temp # clean up
