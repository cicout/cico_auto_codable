cd "`dirname \"$0\"`"
cd ../
pod lib lint --allow-warnings --verbose
