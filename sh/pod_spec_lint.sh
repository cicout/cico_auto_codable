cd "`dirname \"$0\"`"
cd ../
pod spec lint --allow-warnings --verbose
