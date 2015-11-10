#!/bin/sh
# sudo service apache2 restart
echo "What is your name (for git)?"
read NAME
git config --global user.name "$NAME"
echo "What is your email (for git)?"
read EMAIL
git config --global user.email "$EMAIL"
ssh-keygen -t rsa -b 4096 -C "$EMAIL"


echo "/*";
echo "*";
echo "Copy the following public key and add it to your SSH keys in github, write 'done' when you're ready"
echo "*";
echo "*/";
cat ~/.ssh/id_rsa.pub
read DONE
echo "let's see if you did it correctly"
ssh -T git@github.com


	echo "Write names for the projects you'll be working on separated by spaces (up to 5, no special characters ): "
	read -a arr

	for i in ${arr[@]}
	do
		echo "Paste the url of the repository for $i" 
		read REPO
        echo "Enter ENV variable for virtual host for $i"
		read ENV
		

		git clone "$REPO" "/var/www/$i" # or do whatever with individual element of the array
        sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$i.conf
        sudo sed -i "/ServerAdmin/aSetEnv ENV $ENV" /etc/apache2/sites-available/$i.conf
        sudo sed -i -e "s/public/$i/g" /etc/apache2/sites-available/$i.conf
        sudo rm /etc/apache2/sites-enabled/*; sudo a2ensite $i.conf; sudo service apache2 restart;

	done



cat /dev/null > /home/vagrant/post_setup.sh
echo "echo 'Remove ~/post_setup.sh and its entry from .bashrc'" >> /home/vagrant/post_setup.sh
