
cd /tmp
git clone https://github.com/delph-in/matrix/ matrix
cd matrix

sed -i 's/read username/username=anonymous/g' install

pip3 install requests
pip3 install pydelphin
pip3 install delphin

export CUSTOMIZATIONROOT=/tmp/matrix/gmcs
./install /var/www/matrix

cd /var/www/matrix
mv matrix.cgi matrix.cgi.bkp
awk 'NR == 1 {print "#!/usr/bin/python3"; next} {print}' matrix.cgi.bkp > matrix.cgi
chmod +x matrix.cgi

chown -R www-data:www-data /var/www/matrix/

a2enmod cgi
a2enmod userdir



