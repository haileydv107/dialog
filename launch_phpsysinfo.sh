sudo apt install apache2 -y &> /dev/null 
echo "Apache2 installed."
sudo apt install php php-xml php-json -y &> /dev/null 
echo "PHP stufffffs are installed now!"
sudo service apache2 restart -y &> /dev/null 
echo "Apache2 has been restarted!"
wget https://github.com/phpsysinfo/phpsysinfo/archive/refs/tags/v3.4.4.zip &> /dev/null 
unzip v3.4.4 &> /dev/null 
#echo "Phpsysinfo files are found and unzipped!"
cd phpsysinfo-3.4.4
cp phpsysinfo.ini.new phpsysinfo.ini
cd ..
sudo mv phpsysinfo-3.4.4/* /var/www/html
#echo "Now you can take a look on our phpsysinfo!"
dialog --title "完成安裝！" --msgbox "現在您可以開始使用更新網站了" 10 50
