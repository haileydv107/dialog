#removeapache2
if ls sha* 1> /dev/null 2>&1; then
  rm -rf sha* 
sudo rm -rf /var/www 
echo "Remove index contents successfully" 
sudo apt remove apache2 -y &> /dev/null 
rm -rf /var/www 
#echo "Apache2 installed successfully"
#dialog --title "系統提示" --msgbox "Html template is now removed successfully!" 10 30
