
n installJava(){
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
}
function uninstallJava(){
sudo apt-get update
apt-cache search java | awk '{print($1)}' | grep -E -e '^(ia32-)?(sun|oracle)-java' -e'^(ia64-)?(sun|oracle)-java' -e '^openjdk-' -e '^icedtea' -e '^(default|gcj)-j(re|dk)' -e '^gcj-(.*)-j(re|dk)' -e 'java-common' | xargs sudo apt-get -y remove
sudo apt-get -y autoremove
dpkg -l | grep ^rc | awk '{print($2)}' | xargs sudo apt-get -y purge
sudo bash -c 'ls -d /home/*/.java' | xargs sudo rm -rf
sudo rm -rf /usr/lib/jvm/*
for g in ControlPanel java java_vm javaws jcontrol jexec keytool mozilla-javaplugin.so orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200 appletviewer apt extcheck HtmlConverter idlj jar jarsigner javac javadoc javah javap jconsole jdb jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd native2ascii rmic schemagen serialver wsgen wsimport xjc xulrunner-1.9-javaplugin.so; do sudo update-alternatives --remove-all $g; done	
}
function setupAction(){
echo "Promote to reinstall latest version of Java"	
echo "Do you wish to uninstall/Reinstall this program?"
read -p "Yes, No, Reinstall : " yn
case $yn in
Yes ) read -p "Press [Enter] key to start Uninstall..."
uninstallJava ;;	
No ) echo "Unistallation exit";;	
Reinstall )read -p "Press [Enter] key to start Reinstallation..."
uninstallJava
installJava ;;
esac
}
if type -p java; then
echo found java executable in PATH
_java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]]; then
echo found java executable in JAVA_HOME
_java="$JAVA_HOME/bin/java"
else
echo "No java"
fi
if [[ "$_java" ]]; then
version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
echo version "$version"
if [[ "$version" > "1.6" ]]; then
echo version is more than 1.6
else
echo version is less than 1.6
java -version
setupAction
fi
else
echo "Java Not Found"
echo "Java will installed from repository"
read -p "Do you wish to install this program? Yes No: " yn
case $yn in
Yes ) read -p "Press [Enter] key to start Installation..."
installJava ;;	
No ) echo "Installation exit";;
esac
fi

    Status
    API
    Training
    Shop
    Blog
    About


