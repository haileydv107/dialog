#php undeploy
if ls php* 1> /dev/null 2>&1; then
    rm -rf php*
    rm v3.*
fi

sudo rm -rf /var/www 
#echo "Remove index contents successfully" 
sudo apt remove apache2 -y &> /dev/null 
sudo apt remove php php-xml php-json -y &> /dev/null
rm -rf /var/www 
#echo "Apache2 installed successfully"
