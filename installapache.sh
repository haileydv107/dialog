sudo apt install apache2 -y &> /dev/null 
echo "Apache2 installed." 
wget https://www.free-css.com/assets/files/free-css-templates/download/page294/shapel.zip  -y &> /dev/null
unzip shapel.zip  -y &> /dev/null
sudo mv shapel-html/* /var/www/html  -y &> /dev/null 
#echo "Now you can visite our website!"
dialog --title "完成安裝！" --msgbox "現在您可以開始使用更新網站了" 10 50
