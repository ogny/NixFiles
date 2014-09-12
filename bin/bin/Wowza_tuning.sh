#/bin/bash
######################################################
#
#	      MediaCP Software Installation
#			www.cast-control.net
#
######################################################
#
# Notes:
#   Installs all software prerequisites for MediaCP including the MediaCP itself.
#	
#	CentOS 5.7 may require "libxml2-devel"
#
#
#
#
# Installation Usage:
#   setup.sh
#     -unattended	Do not stop or prompt. Will still prompt for MCP installdir. Also uses "-default"
#	  -custom		Choose each item to install
#	  -default		Install Standard Options (no license key request)
#     -edge			Download Latest MediaCP Edge Release
#	  -installrrdtool Install RRDTools in 
#	  -installwowza	Install Wowza Media Server (will also auto -configwowza)
#	  -configwowza	Configure Wowza Media Server
#	  -tunewowza	Tune Wowza Media Server Automatically
#	  -upgradewowza Upgrade Wowza Media Server to latest version
#	  -upgradeonlywowza Upgrade Wowza Media Server to latest version and do nothing else
#	  -stv3			Also Install Stream Transcoder V3
#	  -icecastkh	Install IcecastKH
#	  -noicecast	Do not install Icecast 2
#	  -noices		Do not install Ices 0.4 or Ices 2.0
#	  -nomediacp	Do not install MediaCP
#	  -noprereq		Skip Installation of Pre Requisites
#	  -mcpmain		Download MediaCP_latest.zip from www.cast-control.net instead of faster seal.cast-control.net
#
# System Tools
#	  -installjson	Install PHP JSON support for CENTOS
#	  -resetmysql	Reset MySQL root password
#
# Upgrade Usage: use -upgrade
#	  -upgrade		Upgrade MediaCP **MUST INCLUDE FOR UPGRADE**
#	  -backup		Create Duplicate of MediaCP files & database
#     -unattended	Do not stop or prompt. Will still prompt for MCP installdir. Also uses "-default"
#	  -custom		Choose each item to install
#     -edge			Download Latest MediaCP Edge Release
#	  -mcpmain		Download MediaCP_latest.zip from www.cast-control.net instead of faster seal.cast-control.net

######################################################
SETUPVERSION="2.5"


echo "=========================================================="
echo "Cast-Control MediaCP Software Setup" 
echo "=========================================================="
echo "Initializing..."
echo "Checking Software Versions..."
echo "=========================================================="

# Default OS Detection (With Failsafe)
	Debian=$(egrep -w "Debian|Ubuntu" /proc/version)
	if [ -z "$Debian" ]; then
		Debian=$(uname -a | egrep -w "Debian|Ubuntu")
	fi
	
	Centos=$(egrep -w "Centos|centos|Red Hat" /proc/version)
	if [ -z "$Centos" ]; then
		Centos=$(uname -a | egrep -w "centos|Centos|CentOS|Red Hat")
	fi
	if [ -z "$Centos" ]; then
		Centos=$(cat /etc/redhat-release | egrep -w "centos|Centos|CentOS|Red Hat")
	fi
	
	Suse=$(grep -i "SUSE" /proc/version)   
	if [ -z "$Suse" ]; then
		Suse=$(uname -a | grep -i "SUSE")  
	fi
	 
# Which OS?
	if [ -n "$Centos" ]; then
		echo "Determined OS as CentOS";
		Debian=""
		Suse=""
	fi
	if [ -n "$Debian" ]; then
		echo "Determined OS as CentOS";
		Centos=""
		Suse=""
	fi
	if [ -n "$Suse" ]; then
		echo "Determined OS as CentOS";
		Debian=""
		Suse=""
	fi

# Determine OS
OSType=$(getconf LONG_BIT)   
x86=86   
x64=64

echo "=========================================================="

PHPBINARY=`which php`;if [ "$PHPBINARY" == "" ]; then PHPBINARY="php"; fi
PHPCONF=`$PHPBINARY -r 'if (function_exists("php_ini_loaded_file")){ echo php_ini_loaded_file();}elseif(is_file("/etc/php.ini")){echo "/etc/php.ini";}'`
PHPVERSION=`$PHPBINARY -r 'if (function_exists("phpversion"))echo substr(phpversion(),0,3);'`
PHPEXTDIR=`php -r 'echo ini_get("extension_dir");'`

JAVABINARY=`which java`; if [ "$JAVABINARY" == "" ]; then IsJavaInstalled=""; else IsJavaInstalled=$(java -version | grep -i "java"); fi;

IsWowzaInstalled=$(ls /usr/local/ | grep -i "WowzaMediaServer")
WowzaMediaLatestA="3-6-2"
WowzaMediaLatestB="3.6.2"
WowzaMediaLicense=""
WowzaMediaAdminPass=""
WowzaMediaIPAddress="*"

echo "======================================================="
echo "COMPLETED."
echo ""

LicenseReq="y"
InstallPreReq="y"
InstallIcecast="y"
InstallIcecastKH="y"
InstallIces="y"
InstallSTV3="n"
InstallWowza="n"
InstallFFMPEG="n"
InstallIoncube="n"
InstallMCP="y"
UpgradeMCP="n"
UpgradeMCPBackup="y"
UpgradeMCPCheckCron="n"
UninstallMCP="n"

ConfigWowza="n"
UpgrWowza="n"
WowzaTune="n"

MediaCPRelease="stable"
MediaCPLocation="main"
MediaCPURL="http://[your-domain]/"
Unattended="false"
MediaCPLicense=""
# change to the root folder (due to some system 
# permissions this folder always has the permissions 
# to do installations


#
# Functions
#
function pause()
{
	if [ "$Unattended" == "false" ]; then
		read -p “$*”
	fi
}


function CheckDirectory()
{
	if [ ! -d /root/CastControlTMP  ]; then
		mkdir -p /root/CastControlTMP 
		mkdir -p /root/CastControlTMP/logs
	fi
	
	if [ -d /root/CastControlTMP  ]; then 
		cd /root/CastControlTMP
	fi
}

function Cleanup()
{
	rm /root/CastControlTMP -Rf >/dev/null 2>&1
}


function DetermineProductType(){

	echo "Please enter your MediaCP License Key:"
	read MediaCPLicense
	
	MCPSTD=$(echo "$MediaCPLicense" | grep -i 'MP-ST')
	MCPWMS=$(echo "$MediaCPLicense" | grep -i 'MP-WMS')
	MCPWOWZA=$(echo "$MediaCPLicense" | grep -i 'MP-WOWZA')
	MCPALL=$(echo "$MediaCPLicense" | grep -i 'MP-ALL')

	if [ -n "$MCPSTD" ]; then
		InstallPreReq="y"
		InstallIcecast="y"
		InstallIcecastKH="y"
		InstallIces="y"
		InstallWowza="n"
	elif [ -n "$MCPWMS" ]; then
		echo "This is a windows license key. exiting..."
		exit
	elif [ -n "$MCPWOWZA" -o -n "$MCPALL" ]; then
		InstallPreReq="y"
		InstallIcecast="y"
		InstallIcecastKH="y"
		InstallIces="y"
		InstallWowza="y"
		ConfigWowza="y"
		
		echo "Please enter your Wowza Media Server License to continue";
		read WowzaMediaLicense
			
		echo "Please enter a new password for Wowza Media Server Administration";
		read WowzaMediaAdminPass
		
				
	#	echo "Please enter a dedicated IP address for Wowza Media Server"
	#	echo "Leave blank and press Enter to bind on all addresses"
	#	echo ""
	#	echo "** This MUST be the same IP address as configured in MediaCP."
	#	read WowzaMediaIPAddress
	else
		echo "The provided MCP license key is invalid. exiting..."
		echo "Please contact sales@cast-control.net for more information."
		exit
	fi
}

function SrcFix()
{
    if [ ! -d /usr/src/redhat ]; then
        mkdir -p /usr/src/redhat/
    fi
}

	function CheckSystemRequirements(){
		clear
		################################
		#  SYSTEM REQUIREMENTS CHECK   #
		################################
		
		#PHPBINARY=`which php`;if [ "$PHPBINARY" == "" ]; then PHPBINARY="php"; fi
		
		PHPMYSQL=`$PHPBINARY -r 'if (function_exists("mysql_connect")){ echo "MYSQL_SUPPORT"; }else{ echo "UNSUPPORTED"; }'`
		PHPJSON=`$PHPBINARY -r 'if (function_exists("json_decode")){ echo "JSON_SUPPORT"; }else{ echo "UNSUPPORTED"; }'`
		clear
		
		echo "Checking System Requirements...";
		sleep 1
		# PHP Version
		
		# PHP MySQL
		echo "Checking for PHP MySQL support...";
		if [ "${PHPMYSQL}" == "MYSQL_SUPPORT" ]; then
			echo "OK."
			echo ""
		else
			echo "FAILED"
			echo ""
			echo ""
			echo "================================================================================="
			echo "PHP MySQL Extension is not installed on your system. Script cannot continue without MySQL."
			echo "As of PHP 5.2.0, the JSON extension is bundled and compiled into PHP by default."
			echo ""
			echo "Installation Instructions: http://www.php.net/manual/en/mysql.installation.php"
			echo ""
			exit;
		fi
		sleep 1
		
		# PHP JSON
		echo "Checking for PHP JSON support...";
		if [ "${PHPJSON}" == "JSON_SUPPORT" ]; then
			echo "OK."
			echo ""
		else
			echo "FAILED"
			echo ""
			echo ""
			echo "================================================================================="
			echo "PHP Json Extension is not installed on your system. Script cannot continue without JSON."
			echo "As of PHP 5.2.0, the JSON extension is bundled and compiled into PHP by default."
			echo ""
			echo "Installation Instructions: http://www.php.net/manual/en/json.installation.php"
			echo ""
			exit;
		fi
		sleep 1
		
		echo "COMPLETED OK."
		sleep 1
		clear
	}

	
function InstFFMPEG()
{

	# Check FFMPEG Installed
	FFMPEG=`which ffmpeg`;
	if [ "$FFMPEG" != "" ]; then
		echo "FFMPEG is already installed."
		return;
	fi

	echo "Installing FFMPEG..."

	# Perform Install
	if [ -n "$Centos" ]; then
	
		# CentOS 5.8 requires $ARCH,
	
		if [ ! -f /etc/yum.repos.d/dag.repo ]; then
			echo "Installing DAG Repo..."
			echo "[dag]" >> /etc/yum.repos.d/dag.repo
			echo "name=Dag RPM Repository for Red Hat Enterprise Linux" >> /etc/yum.repos.d/dag.repo
			echo "baseurl=http://apt.sw.be/redhat/el\$releasever/en/\$basearch/dag" >> /etc/yum.repos.d/dag.repo
			echo "gpgcheck=0" >> /etc/yum.repos.d/dag.repo
			echo "enabled=1" >> /etc/yum.repos.d/dag.repo
			echo "Complete."
		fi
		
		echo "Updating YUM packages..."
		yum update -y -d 0 -e 0
		echo "Installing FFMPEG..."
		yum install ffmpeg -y -d 0 -e 0
		echo "Complete"
		
		
		return;
		
		# MANUAL/OLD METHOD BELOW
		
		yum install gcc;
		yum install subversion;
		cd /usr/local/src/;
		wget http://www.tortall.net/projects/yasm/releases/yasm-1.0.1.tar.gz;
		tar zfvx yasm-1.0.1.tar.gz
		cd yasm-1.0.1;
		./configure;
		make && make install;
		
		
		# Install GIT
		yum install gettext-devel expat-devel curl-devel zlib-devel openssl-devel;
		wget http://kernel.org/pub/software/scm/git/git-1.6.1.tar.gz;
		tar xvfz git-1.6.1.tar.gz;
		cd git-1.6.1.tar.gz;
		make prefix=/usr/local all;
		make prefix=/usr/local install;


		#sudo yum build-dep git;
		#wget http://kernel.org/pub/software/scm/git/<latest-git-source>.tar.gz;
		#tar -xvjf <latest-git>.tar.gz;
		#cd <git>;
		#make (possibly a ./configure before this);
		#sudo make install;
		
		git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg;
		cd ffmpeg;
		./configure --enable-shared;
		make;
		make install;
		
		# Check /usr/local/lib
		#export LD_LIBRARY_PATH=/usr/local/lib/
		
		# Lib AV Issue
		echo "" >> /etc/ld.so.conf
		echo "/usr/local/lib/" >> /etc/ld.so.conf;
		ldconfig;

	fi
	
	if [ -n "$Debian" ]; then
	
		# Add REPO
		#deb http://www.deb-multimedia.org squeeze main non-free
		#deb http://www.deb-multimedia.org squeeze-backports main
	
		echo ""
		echo "Checking deb-multimedia repo support.."
		
		#deb http://www.deb-multimedia.org squeeze main
		REPOEXIST=`cat /etc/apt/sources.list | grep -v '^#' | grep -c 'deb http://www.deb-multimedia.org squeeze main'`
		[ $REPOEXIST -eq 0 ] && echo "# Cast-Control FFMPEG Support" >> /etc/apt/sources.list
		[ $REPOEXIST -eq 0 ] && echo "deb http://www.deb-multimedia.org squeeze main non-free" >> /etc/apt/sources.list
		
		#deb http://www.deb-multimedia.org squeeze-backports main
		REPOEXIST=`cat /etc/apt/sources.list | grep -v '^#' | grep -c 'deb http://www.deb-multimedia.org squeeze-backports main'`
		[ $REPOEXIST -eq 0 ] && echo "deb http://www.deb-multimedia.org squeeze-backports main" >> /etc/apt/sources.list
		
		echo "Complete."
		
		
		echo "Installing ffmpeg (apt-get install ffmpeg)..."
		apt-get install ffmpeg -V -y --force-yes  > /dev/null 2>&1
		#apt-get install ffprobe -V -y --force-yes   >/dev/null
	fi

	# Check install success
	echo "Installation Complete"
	echo "Testing FFMPEG"
	echo "======================================="
	ffmpeg
	echo "======================================="
    echo "Press any key to continue."
	pause ""
}

function ResetMySQLPassword(){
	CheckDirectory
	
	echo "Please enter a new root password:";
	read NewRootPassword;
	
	if [ -n "$Centos" -o -n "$Debian" ]; then
		echo ""
		echo "Resetting MySQL Root Password."
		echo "-------------------------"
		/etc/init.d/mysqld stop
		mysqld_safe --skip-grant-tables &
		rm -f mysql.root.pwd;
		echo "use mysql;update user set password=PASSWORD('${NewRootPassword}') where User='root';flush privileges;" > mysql.root.pwd
		mysql -u root < mysql.root.pwd;
		rm -f mysql.root.pwd;
		/etc/init.d/mysqld restart
		echo "-------------------------"
		echo "Completed."
	fi
	
	
	# Set to NULL
	
	NewRootPassword="";
}

function InstallPHPJSON()
{

	if [ -n "$Centos" ]; then

		yum install php-json;
		PHPJSON=`$PHPBINARY -r 'if (function_exists("json_decode")){ echo "JSON_SUPPORT"; }else{ echo "UNSUPPORTED"; }'`
		
		if [ "${PHPJSON}" == "JSON_SUPPORT" ]; then
			echo "JSON INSTALLED SUCCESSFULLY."
			echo ""
		else
			CheckDirectory
			yum install php-pear gcc
			/usr/bin/pecl install json
			cd /etc/php.d
			rm -f json.ini
			echo "extension=json.so" >> json.ini
			
			/etc/init.d/httpd restart
			
			CheckDirectory
			/usr/bin/pecl download json
			tar -zxf json-*.tgz
			cd json-1.*
			phpize
			./configure
			make
			make install
			echo ""
			echo "=================================="
			echo "JSON INSTALL FINISHED. PLEASE ENSURE NO ERRORS ABOVE."
			echo "Press Return to continue..."
			read CONFIRM
			echo "Testing PHP JSON..."
			PHPJSON=`$PHPBINARY -r 'if (function_exists("json_decode")){ echo "JSON_SUPPORT"; }else{ echo "UNSUPPORTED"; }'`
				clear;
				echo ""
				echo "Checking for PHP JSON support...";
				sleep 1
				echo "."
				sleep 1
				echo ""
				if [ "${PHPJSON}" == "JSON_SUPPORT" ]; then
					echo "OK."
					echo ""
				else
					echo "FAILED"
					echo ""
					echo ""
					echo "================================================================================="
					echo "PHP Json Extension is not installed on your system. Script cannot continue without JSON."
					echo "As of PHP 5.2.0, the JSON extension is bundled and compiled into PHP by default."
					echo ""
					echo "Installation Instructions: http://www.php.net/manual/en/json.installation.php"
					echo ""
					exit;
				fi
		fi
		echo "Press Return to continue..."
		read CONFIRM
		exit;
	else
		echo "Operating System Not supported."
		echo "Only CENTOS is supported, please consult server administrator."
		echo ""
		echo "Press return to continue";
		read CONFIRM
		exit;
	fi
}
	
function InstMediaCP()
{
	CheckDirectory
	
	CheckSystemRequirements
	
	
	
	echo ""
	echo ""
	echo ""
	echo ""
	
	echo "MediaCP Installation..."
	echo "---------------------------------------------------------"
	echo "Setup needs to know the full URL at which you will be using the MediaCP."
	echo "This is where your users will login to manage their media services on the web."
	echo ""
	echo "For example, you might enter: http://www.yourdomain.com/mediacp/"
	echo "Or for a subdomain, you might enter: http://mediacp.yourdomain.com/"
	echo ""
	echo "Please ensure that the website is configured BEFORE proceeding with setup."
	echo ""
	echo "Enter the URL for MediaCP:"
	read MCPInstallURL
	MCPInstallURL=${MCPInstallURL%/}
	
	echo ""
	echo ""
	echo ""
	echo ""
	echo "---------------------------------------------------------"
	echo "Setup must now determine where to install the MediaCP application".
	echo "MediaCP will be installed to [Your-Input]"
	echo "For example, if you enter '/var/www/html/' - the control panel will install to '/var/www/html/'"
	echo "---------------------------------------------------------"
	echo "Where do you wish to install MCP?:"
	read MCPInstallDir
	MCPInstallDir=${MCPInstallDir%/}
	
	if [ -d "${MCPInstallDir}" ]; then
		echo ""
		echo "WARNING! ${MCPInstallDir}/ already exists!"
		echo "Are you sure you wish to install here? (y/n)"
		read MCPInstallAreYouSure
		if [ "$MCPInstallAreYouSure" == "y" ]; then
			echo "Continuing Setup....."
			echo ""
		else
			echo "Where do you wish to install MCP?:"
			read MCPInstallDir
			MCPInstallDir=${MCPInstallDir%/}
			if [ -d "${MCPInstallDir}/" ]; then
				echo "WARNING! ${MCPInstallDir}/ already exists!"
				echo "EXITING SETUP!".
				exit
			fi
		fi
	fi
	
	# Write license key to file (skips step 1)
	if [ "${MediaCPLicense}" == "" ]; then
		echo ""
	else
		echo "${MediaCPLicense}" > "${MCPInstallDir}/setup/license.key";
	fi
	# Send to ENV for init.sh
	export MCPInstallDir
	export MCPInstallURL
	
	clear
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Installing to [${MCPInstallDir}]/"
	echo "Downloading MediaCP_latest.zip..."
	rm -f MediaCP_latest.zip;
	if [ "$MediaCPRelease" == "stable" ];then
		wget http://mirror.cast-control.net/files/MediaCP_latest.zip
	else
		wget http://mirror.cast-control.net/files/MediaCP_latest_rc.zip
		mv MediaCP_latest_rc.zip MediaCP_latest.zip
	fi
	echo "-> Done"
	echo "Extracting & Moving..."
	unzip MediaCP_latest*.zip >/dev/null 2>&1
	
	if [ -d "${MCPInstallDir}" ]; then
		mv upload_and_rename/* "${MCPInstallDir}/"
	else
		mv upload_and_rename/ "${MCPInstallDir}/"
	fi
	echo "-> Done"
	
	#SC_SERV is now included with MediaCP Package 2157
	#echo "Downloading sc_serv..."
	#cd ${MCPInstallDir}/files/shoutcast198/;
	#wget http://eagle.cast-control.net/sc_serv;
	#chmod 777 sc_serv;
	
	echo "Checking Ownership..."
	MCPInstallChownUser=(`ls -l ${MCPInstallDir} | awk 'NR>1{print $3; exit}'`)
	MCPInstallChownGroup=(`ls -l ${MCPInstallDir} | awk 'NR>1{print $4; exit}'`)
	
	if [ "$MCPInstallChownUser" == "root" ]; then
		#ATTEMPT URL REQUEST
		touch "${MCPInstallDir}/phptest.php"
		echo "<?php echo exec(\"whoami\"); ?>" > "${MCPInstallDir}/phptest.php"
		MCPInstallChownUser=`wget ${MCPInstallURL}/phptest.php -qO-`
		MCPInstallChownGroup=`id -g ${MCPInstallChownUser}`
		rm -f "${MCPInstallDir}/phptest.php"
	fi
	
	if [ "$MCPInstallChownUser" == "root" -o "${MCPInstallChownUser}" == "" -o "${MCPInstallChownGroup}" == "" ]; then
		echo "SETUP cannot reliably determine the appropriate user and group to configure.";
		echo "It is important that these details are correct";
		echo "";
		echo "Permissions are....."
		ls -l "${MCPInstallDir}"
		cd "${MCPInstallDir}";cd ../;ls -l;
		echo "Press any key to continue"
		read CONFIRM
		echo "Apache is running as..."
		ps aux | grep "apache"
		ps aux | grep "httpd"
		echo "Press any key to continue"
		read CONFIRM
				
		echo "chown directory as user:"
		read MCPInstallChownUser
		echo "chown directory as group:"
		read MCPInstallChownGroup
	fi

	
	echo "Updating Permissions..."
	chown -R $MCPInstallChownUser:$MCPInstallChownGroup "${MCPInstallDir}/"
	
	cd ${MCPInstallDir}/
	chmod -R 777 "${MCPInstallDir}/content"
	chmod -R 777 "${MCPInstallDir}/files"
	chmod -R 777 "${MCPInstallDir}/temp"
	chmod -R 777 "${MCPInstallDir}/logs"
	chmod 777 "${MCPInstallDir}/database.php"
	chmod 777 "${MCPInstallDir}/banner.png"
	chmod +r "${MCPInstallDir}/.htaccess"
	#chmod public_html for cpanel
	chmod 755 "${MCPInstallDir}/";
	echo "-> Done";
	
	echo "Installing Cron..."
	CRONJOBEXISTS=`cat /etc/crontab | grep -v '^#' | grep -c '${MCPInstallDir}/scanner/cron.php'`
	[ $CRONJOBEXISTS -eq 0 ] && echo "* * * * * $MCPInstallChownUser $PHPBINARY ${MCPInstallDir}/scanner/cron.php auto=1 >/dev/null 2>&1" >> /etc/crontab
	echo "-> Done"
	
	if [ -f $PHPCONF ]; then
		echo "Reconfiguring php.ini (backup in $PHPCONF.bak)..."
		cp -a $PHPCONF $PHPCONF.bak
		echo "Set safe_mode to Off."
		sed -i 's/safe_mode = On/safe_mode = Off/g' $PHPCONF
		sed -i 's/;safe_mode = Off/safe_mode = Off/g' $PHPCONF
		echo "Set magic_quotes_gpc to Off."
		sed -i 's/magic_quotes_gpc = On/magic_quotes_gpc = Off/g' $PHPCONF
		sed -i 's/;magic_quotes_gpc = Off/magic_quotes_gpc = Off/g' $PHPCONF
		sed -i 's/magic_quotes_runtime = On/magic_quotes_gpc = Off/g' $PHPCONF
		sed -i 's/;magic_quotes_runtime = Off/magic_quotes_gpc = Off/g' $PHPCONF
		echo "Set short_open_tag to On."
		sed -i 's/short_open_tag = Off/short_open_tag = On/g' $PHPCONF
		sed -i 's/;short_open_tag = Off/short_open_tag = On/g' $PHPCONF
		echo "Commenting out disable_functions"
		sed -i 's/disable_functions = /;disable_functions = /g' $PHPCONF
		echo "Checking PHP Upload Limit"
		sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' $PHPCONF
		echo "Setting allow_url_fopen to On"
		sed -i 's/allow_url_fopen = Off/allow_url_fopen = On/g' $PHPCONF
		echo "Setting display_errors to Off"
		sed -i 's/display_errors = On/display_errors = Off/g' $PHPCONF
		echo "Setting post_max_size and upload_max_filesize to 20MB"
		sed -i 's/display_errors = 20M/upload_max_filesize = 20M/g' $PHPCONF
		sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' $PHPCONF
		sed -i 's/upload_max_filesize = 8M/upload_max_filesize = 20M/g' $PHPCONF
		sed -i 's/post_max_size = 8M/post_max_size = 20M/g' $PHPCONF
		sed -i 's/post_max_size = 2M/post_max_size = 20M/g' $PHPCONF
		echo " -> Done."
		
		# DEBIAN APACHE2
		if [ "$PHPCONF" == "/etc/php5/cli/php.ini" ]; then
			PHPCONF="/etc/php5/apache2/php.ini"
			echo "Reconfiguring php.ini (backup in $PHPCONF.bak)..."
			cp -a $PHPCONF $PHPCONF.bak
			echo "Set safe_mode to Off."
			sed -i 's/safe_mode = On/safe_mode = Off/g' $PHPCONF
			sed -i 's/;safe_mode = Off/safe_mode = Off/g' $PHPCONF
			echo "Set magic_quotes_gpc to Off."
			sed -i 's/magic_quotes_gpc = On/magic_quotes_gpc = Off/g' $PHPCONF
			sed -i 's/;magic_quotes_gpc = Off/magic_quotes_gpc = Off/g' $PHPCONF
			sed -i 's/magic_quotes_runtime = On/magic_quotes_gpc = Off/g' $PHPCONF
			sed -i 's/;magic_quotes_runtime = Off/magic_quotes_gpc = Off/g' $PHPCONF
			echo "Set short_open_tag to On."
			sed -i 's/short_open_tag = Off/short_open_tag = On/g' $PHPCONF
			sed -i 's/;short_open_tag = Off/short_open_tag = On/g' $PHPCONF
			echo "Commenting out disable_functions"
			sed -i 's/disable_functions = /;disable_functions = /g' $PHPCONF
			echo "Checking PHP Upload Limit"
			sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' $PHPCONF
			echo "Setting allow_url_fopen to On"
			sed -i 's/allow_url_fopen = Off/allow_url_fopen = On/g' $PHPCONF
			echo "Setting display_errors to Off"
			sed -i 's/display_errors = On/display_errors = Off/g' $PHPCONF
			echo " -> Done."
		fi
		
	fi
	
	# Update .htaccess REWRITE Path
	
	wget -q http://www.cast-control.net/files/htwrite.php.txt -O ${MCPInstallDir}/system/htwrite.php
	REWRITEPATH=`$PHPBINARY ${MCPInstallDir}/system/htwrite.php $MCPInstallURL`
	sed -i "s/RewriteBase \/mediacp\//RewriteBase $REWRITEPATH/g" ${MCPInstallDir}/.htaccess
	rm -f ${MCPInstallDir}/system/htwrite.php
	
	#Restart Webservice
		echo "Attempting to restart Web Service..."
		if [ -n "$Centos" ]; then
			service httpd restart
		else
			apache2ctl restart
		fi
		echo " -> Done."
	
	# Lets tell the system that MediaCP is installed
	echo "${MCPInstallURL}" >> /root/mcp.instances
		
	
	#if [ -f /etc/init.d/proftpd ]; then
	#	echo ""
	#	echo "We see that ProFTPd is installed on your system."
	#	echo "Would you like to configure ProFTPd for integration with MediaCP? (y/n)"
	#	read CONFIRM
	#	if [ "$CONFIRM" == "Y" -o "$CONFIRM" == "y" ]; then
	#		
	#		MCPProFTPDID=`id -u $MCPInstallChownUser`
	#		MCPProFTPGID=`id -g $MCPInstallChownGroup`
	#		
	#		
	#	
	#	fi
	#	echo ""
	#	echo ""
	#fi
		
		
	
	echo ""
	echo "Installation is now completed. Please open the software in your browser to begin GUI Setup."
	echo "URL: $MCPInstallURL"
	pause "pause"
	
}

function InstallMCPUpgrade(){
	CheckDirectory
	
	CheckSystemRequirements
	
	echo ""
	echo ""
	echo ""
	echo ""
	echo "MediaCP Upgrade..."
	echo "---------------------------------------------------------"
	echo "Setup must now determine where your software is installed."
	echo "Please enter the FULL path to the MediaCP root directory."
	echo "Unlike the initial install, we require the absolute full path without an ending slash."
	echo ""
	echo " For example: /var/www/html/mediacp        (notice no ending slash)"
	echo ""
	echo "---------------------------------------------------------"
	echo ""
	echo "Please enter your MediaCP install directory:"
	read MCPInstallDir
	
	# Remove trailing slash if exists
	MCPInstallDir=`echo "${MCPInstallDir}" | sed -e "s/\/*$//" `;
	
		
	### Get Current Versions  ###
		cd ${MCPInstallDir};
		CURRENTVERSION=`php -r ' include("./system/version.php"); echo build;'`;
		CURRENTVERSIONBASIC=`php -r ' include("./system/version.php"); echo str_replace(".","",build);'`;
		MediaCPURL=`php -r ' include("./database.php"); echo $setting["panel_url"];'`;
		CheckDirectory
		
		
		# Get Latest Version
		if [ "$MediaCPRelease" == "stable" ]; then
			SETUPVERSION=`wget http://www.cast-control.net/mcp-updates/latest.php -qO-`;
		else
			SETUPVERSION=`wget http://www.cast-control.net/mcp-updates/latest.php?beta=true - -qO-`;
		fi
	#############################
	
	if [ "$UpgradeMCPBackup" == "y" ]; then
		echo ""
		echo "======================================================="
		echo "BACKUP MEDIA CONTROL PANEL"
		echo ""
		echo "Please note that the ./content/ directory may contain many files and be rather large."
		echo "You should choose a backup location with enough space or the backup may fail."
		echo "======================================================="
		echo ""
	
		echo "Backup MCP to where? (eg /root/MCPBACKUP)"
		read MCPBACKUPLOCATION
		if [ "${MCPBACKUPLOCATION}" == "" ]; then
			rm -rf /root/MCPBACKUP
			MCPBACKUPLOCATION=/root/MCPBACKUP
		fi
		if [ -d "${MCPBACKUPLOCATION}" ]; then
			echo ""
			echo "WARNING!"
			echo "Directory $MCPBACKUPLOCATION exists."
			echo ""
			echo "Would you like to delete ${MCPBACKUPLOCATION}? (y/n)"
			read CONFIRM
			if [ "$CONFIRM" == "y" ]; then
				echo "Removing ${MCPBACKUPLOCATION}..."
				rm -rf $MCPBACKUPLOCATION;
				echo "->Done."
				echo ""
			else
				echo "Setup cannot continue, please move or delete /root/MCPBACKUP and run the init.sh again."
				echo ""
				echo ""
				exit;
			fi
			
		fi
		echo "Creating MCP Backup to $MCPBACKUPLOCATION ..."
		cp -a "${MCPInstallDir}" "${MCPBACKUPLOCATION}"
		echo "-> Done. "
		echo ""
		echo ""
		
		echo "Setup will now attempt to upgrade your MediaCP from ${CURRENTVERSION} to  ${SETUPVERSION}."
		echo "Press any key to continue or CTRL + C to abort"
		read CONFIRM
	fi
	
		
    TEMPLATECHANGES=`wget "http://www.cast-control.net/mcp-updates/templatechanges.php?c=${CURRENTVERSION}&v=${SETUPVERSION}" -qO-`;
    if [ "${TEMPLATECHANGES}" == "" ]; then
        echo "";
    else
        clear
		echo "=================================================================="
		echo "Template Upgrades - From ${CURRENTVERSION} to ${SETUPVERSION}."
		echo "=================================================================="
		echo ""
        echo "Setup has detected the following template changes."
		echo "Have you made modifications to the MediaCP templates? (y/n)"
		read CONFIRM
		if [ "$CONFIRM" == "y" ]; then
			echo ""
			echo "You will need to apply the following changes in order to be"
			echo "compatible with the latest upgrade."
			echo ""
			echo "You can view all available template changes here:"
			echo "http://www.cast-control.net/mcp-updates/templatechanges.php?c=${CURRENTVERSION}&v=${SETUPVERSION}&web=true";
			echo ""
			echo "Press any key to display template changes onscreen or 'skip' to skip."
			read CONFIRM
			if [ "${CONFIRM}" == "skip" ]; then
				echo ""
			else
				echo ""
				echo "${TEMPLATECHANGES}" | more;
				echo ""
				echo "Press RETURN to continue."
				read CONFIRM
			fi
		else
			echo ""
		fi
    fi

	
	echo ""
	echo ""
	
	if [ "$MediaCPRelease" == "stable" ];then
	echo "Downloading MediaCP_latest.zip..."
		wget http://mirror.cast-control.net/files/MediaCP_latest.zip
	else
		echo "Downloading MediaCP_latest_rc.zip..."
		wget http://mirror.cast-control.net/files/MediaCP_latest_rc.zip
	fi
	echo "-> Done"
	
	echo "Compiling Upgraded Software..."

	unzip MediaCP_latest*.zip >/dev/null
	rm -rf ${MCPInstallDir}.tmp/
	mv ${MCPInstallDir} ${MCPInstallDir}.tmp/
	mv upload_and_rename/ ${MCPInstallDir}/
	echo "."
	
	rm -rf ${MCPInstallDir}/content
	rm -rf ${MCPInstallDir}/setup
	rm -rf ${MCPInstallDir}/other
	rm -f ${MCPInstallDir}/temp/templates_c/*.tpl.php
	
	
	rm -f banner.png
	
	echo "."
	
	
	# Preserve Current MediaCP Theme
	cp -a "${MCPInstallDir}.tmp/system/theme/MediaPanel/" "${MCPInstallDir}/system/theme/MediaPanel_${CURRENTVERSIONBASIC}/"
	if [ -d ${MCPInstallDir}.tmp/system/theme/Experiance/ ]; then
		cp -a "${MCPInstallDir}.tmp/system/theme/Experience/" "${MCPInstallDir}/system/theme/Experience_${CURRENTVERSIONBASIC}/"
	fi
	
	
	# Preserve Other Custom Themes
	cd "${MCPInstallDir}.tmp/system/theme/";
	
	# Find and copy all directories EXCEPT Experience
	cp -a `ls |grep -e '[^Experience/$][^./$]'` "${MCPInstallDir}/system/theme/"
	rm -rf "${MCPInstallDir}/system/theme/Experience_preserved/"
	CheckDirectory
	echo "."
	
	# Update Content
	rm -rf ${MCPInstallDir}/content/
	mv "${MCPInstallDir}.tmp/content/" "${MCPInstallDir}/content/"
	
	echo "."

	cp -a ${MCPInstallDir}.tmp/database.php ${MCPInstallDir}/database.php
	#cp -a ${MCPInstallDir}.tmp/files/shoutcast198/sc_serv ${MCPInstallDir}/files/shoutcast198/sc_serv
	echo "."
	
	
	MCPInstallChownUser=(`ls -l ${MCPInstallDir}.tmp | grep system | awk '{print $3}'`)
	MCPInstallChownGroup=(`ls -l ${MCPInstallDir}.tmp | grep system | awk '{print $4}'`)

	chown -R $MCPInstallChownUser:$MCPInstallChownGroup "${MCPInstallDir}/"
	chmod -R 777 "${MCPInstallDir}/files"
	chmod -R 777 "${MCPInstallDir}/temp"
	chmod -R 777 "${MCPInstallDir}/logs"
	chmod 755 "${MCPInstallDir}/database.php"
	chmod 777 "${MCPInstallDir}/banner.png"
	chmod +r "${MCPInstallDir}/.htaccess"
	#chmod public_html for cpanel
	chmod 755 "${MCPInstallDir}/";
	echo "-> Done"
	
	
	if [ "$UpgradeMCPCheckCron" == "y" ]; then
		echo "Checking Cron..."
		CRONJOBEXISTS=`cat /etc/crontab | grep -v '^#' | grep -c '${MCPInstallDir}/scanner/cron.php'`
		[ $CRONJOBEXISTS -eq 0 ] && echo "* * * * * $MCPInstallChownUser $PHPBINARY ${MCPInstallDir}/scanner/cron.php auto=1 >/dev/null 2>&1" >> /etc/crontab
		echo "-> Done"
	fi
	
	if [ -f $PHPCONF ]; then
		echo "Reconfiguring php.ini (backup in $PHPCONF.bak)..."
		cp -a $PHPCONF $PHPCONF.bak
		echo "Set safe_mode to Off."
		sed -i 's/safe_mode = On/safe_mode = Off/g' $PHPCONF
		sed -i 's/;safe_mode = Off/safe_mode = Off/g' $PHPCONF
		echo "Set magic_quotes_gpc to Off."
		sed -i 's/magic_quotes_gpc = On/magic_quotes_gpc = Off/g' $PHPCONF
		sed -i 's/;magic_quotes_gpc = Off/magic_quotes_gpc = Off/g' $PHPCONF
		sed -i 's/magic_quotes_runtime = On/magic_quotes_gpc = Off/g' $PHPCONF
		sed -i 's/;magic_quotes_runtime = Off/magic_quotes_gpc = Off/g' $PHPCONF
		echo "Set short_open_tag to On."
		sed -i 's/short_open_tag = Off/short_open_tag = On/g' $PHPCONF
		sed -i 's/;short_open_tag = Off/short_open_tag = On/g' $PHPCONF
		echo "Commenting out disable_functions"
		sed -i 's/disable_functions = /;disable_functions = /g' $PHPCONF
		echo "Checking PHP Upload Limit"
		sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' $PHPCONF
		echo "Setting allow_url_fopen to On"
		sed -i 's/allow_url_fopen = Off/allow_url_fopen = On/g' $PHPCONF
		echo "Setting display_errors to Off"
		sed -i 's/display_errors = On/display_errors = Off/g' $PHPCONF
		echo "Setting post_max_size and upload_max_filesize to 20MB"
		sed -i 's/display_errors = 20M/upload_max_filesize = 20M/g' $PHPCONF
		sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' $PHPCONF
		sed -i 's/upload_max_filesize = 8M/upload_max_filesize = 20M/g' $PHPCONF
		sed -i 's/post_max_size = 8M/post_max_size = 20M/g' $PHPCONF
		sed -i 's/post_max_size = 2M/post_max_size = 20M/g' $PHPCONF
		echo " -> Done."
	fi
	
	if [ -f /usr/local/WowzaMediaServer/conf/Server.xml ]; then
		echo "Enabling Wowza Media Server Remote Access (LOCALHOST)."
		#Server.xml Remote JMX Config
		sed -i 's/<Enable>false<\/Enable>/<Enable>true<\/Enable>/g' /usr/local/WowzaMediaServer/conf/Server.xml
	fi
	
	# Obtain MediaCPURL from database.php
	$PHPBINARY -r "include('${MCPInstallDir}/database.php');echo \$setting['panel_url'];" > ${MCPInstallDir}/temp/mcpurl
	MediaCPURL=`cat ${MCPInstallDir}/temp/mcpurl`
	
	# Update .htaccess REWRITE Path
	wget -q http://www.cast-control.net/files/htwrite.php.txt -O ${MCPInstallDir}/system/htwrite.php
	REWRITEPATH=`$PHPBINARY ${MCPInstallDir}/system/htwrite.php $MediaCPURL`
	sed -i "s/RewriteBase \/mediacp\//RewriteBase $REWRITEPATH/g" ${MCPInstallDir}/.htaccess
	
	# Cleanup
	rm -f ${MCPInstallDir}/system/htwrite.php
	rm -f ${MCPInstallDir}/temp/mcpurl
	
	# 2160 FTP Database.php Upgrade
	if [ "$SETUPVERSION" == "2160 STABLE" -o "$SETUPVERSION" == "2160 BETA" ]; then
		chmod 777 "${MCPInstallDir}/database.php"
	fi

	chmod 777 "${MCPInstallDir}/banner.png"
	
	
	
	echo ""
	echo ""
	echo "Completing..."
	sleep 1
	echo ""
	sleep 1
	
	clear
	echo "======================================================================="
	echo "======================================================================="
	echo ""
	echo ""
	echo ""
	echo "#######################        IMPORTANT        #######################"
	echo ""
	echo "Please open the following URL from your browser to apply mysql upgrade:"
	echo "${MediaCPURL}system/upgrade.php"
	echo ""
	echo "#######################        IMPORTANT        #######################"
	echo ""
	echo ""
	echo ""
	echo "Press enter to complete your upgrade."
	read CONFIRM
	clear
	echo ""
}

UninstMCP(){
	CheckDirectory
	
	echo ""
	echo ""
	echo ""
	echo ""
	echo "MediaCP Removal / Uninstall"
	echo "---------------------------------------------------------"
	echo "We must now determine where your software is installed."
	echo "Please enter the FULL path to the MediaCP root directory."
	echo "Unlike the initial install, we require the absolute full path without an ending slash."
	echo ""
	echo " For example: /var/www/html/mediacp        (notice no ending slash)"
	echo ""
	echo "---------------------------------------------------------"
	echo ""
	echo "Please enter your MediaCP install directory:"
	read MCPInstallDir
	
	# Remove trailing slash if exists
	MCPInstallDir=`echo "${MCPInstallDir}" | sed -e "s/\/*$//" `;

	clear
	echo ""
	echo ""
	echo "You have specified your installation directory as the following:"
	echo "${MCPInstallDir}"
	echo "Would you like to delete this whole directory or only cast-control related files? (y/n)"
	echo "y = delete entire directory and all contents"
	echo "n = delete only cast-control related files"
	
	read CONFIRM
	
	if [ "$CONFIRM" == "y" ]; then
		DELETEALL="y"
	else
		DELETEALL="n"
	fi
	
	MCPInstallChownUser=(`ls -l ${MCPInstallDir} | grep database.php | awk 'NR>1{print $3; exit}'`)
	MCPInstallChownGroup=(`ls -l ${MCPInstallDir} | grep database.php | awk 'NR>1{print $4; exit}'`)
	CRONJOBEXISTS=`cat /etc/crontab | grep -v '^#' | grep -c '${MCPInstallDir}/scanner/cron.php'`
	
	#DISABLE CRON JOB
	if [ $CRONJOBEXISTS -eq 1 ]; then
		sed -i 's/* * * * * $MCPInstallChownUser $PHPBINARY/#* * * * * $MCPInstallChownUser $PHPBINARY/g' /etc/crontab
	fi
	
	#EMPTY DATABASE
	#TBC
	
	#DELETE FILES
	if [ "$DELETEALL" == "y" ]; then
		rm -rf ${MCPInstallDir}
	else
		rm -f ${MCPInstallDir}/.htaccess
		rm -f ${MCPInstallDir}/index.php
		rm -f ${MCPInstallDir}/database.php
		rm -rf ${MCPInstallDir}/content/
		rm -rf ${MCPInstallDir}/files/
		rm -rf ${MCPInstallDir}/logs/
		rm -rf ${MCPInstallDir}/temp/
		rm -rf ${MCPInstallDir}/station/
		rm -rf ${MCPInstallDir}/system/
		rm -rf ${MCPInstallDir}/user/
		rm -rf ${MCPInstallDir}/map/
	fi
	
	echo ""
	echo ""
	echo ""
	echo "=================================================="
	echo "Cast-Control MediaCP has now been uninstalled."
	echo ""
	echo "To finish the removal please perform the following:"
	echo "  > Open /etc/crontab and delete reference to MediaCP Cron"
	echo "  > Delete the MySQL Database"
	echo "=================================================="
	echo ""
	echo ""
	echo ""
	read CONFIRM
	
}

function InstallProFTPdIntegration(){
	#Check if cPanel server
	# if [ -d /usr/local/cpanel/ ]; then
	
	#Check ProFTPd already installed
	# 
	#Check FTP Service already installed, if so - ask to continue
	#
	
	wget ftp://ftp1.at.proftpd.org/ProFTPD/distrib/source/proftpd-1.3.3e.tar.gz
	tar xvzf proftpd-1.3.3e.tar.gz
	cd proftpd-1.3.3e
	./configure
	make
	make install
	
	if [ "${MCPInstallDir}" == "" ]; then
		echo "---------------------------------------------------------"
		echo "Setup must now determine where your software is installed."
		echo "Please enter the FULL path to the MediaCP root directory."
		echo "Unlike the initial install, we require the absolute full path without an ending slash."
		echo ""
		echo " For example: /var/www/html        (notice no ending slash)"
		echo ""
		echo "---------------------------------------------------------"
		echo "MediaCP Install Path:"
		read MCPInstallDir
		echo "Setup will use ${MCPInstallDir} for ProFTPd integration"
		echo ""
	fi
	
	echo "Please enter the hostname for FTP Connections:"
	read PROFTPDHOSTNAME
	
	echo "Preparing for search..."
	updatedb
	echo "Please enter the location of the ProFTPd config file"
	echo "---------------------------------------------------------"
	locate proftpd.conf
	echo "---------------------------------------------------------"
	read MPCPROFTPDConfig
	
	MCPInstallChownUser=(`ls -l ${MCPInstallDir} | grep system | awk '{print $3}'`)
	MCPInstallChownGroup=(`ls -l ${MCPInstallDir} | grep system | awk '{print $4}'`)
	MCPPROFTPDUser=(`id -u $MCPInstallChownUser`)
	MCPPROFTPDGroup=(`id -g $MCPInstallChownGroup`)

	cp -a ${MCPInstallDir}/database.php ${MCPInstallDir}/database.php.bak
	sed -i "s/\$setting['ftpserver_integration'] = 'disabled';/$setting['ftpserver_integration'] = 'enabled';/g" ${MCPInstallDir}/database.php
	sed -i "s/\$setting['ftpserver_host'] = 'disabled';/$setting['ftpserver_integration'] = '$PROFTPDHOSTNAME';/g" ${MCPInstallDir}/database.php
	sed -i "s/\$setting['uid'] = 'disabled';/\$setting['ftpserver_integration'] = '$MCPPROFTPDUser';/g" ${MCPInstallDir}/database.php
	sed -i "s/\$setting['gid'] = 'disabled';/\$setting['ftpserver_integration'] = '$MCPPROFTPDGroup';/g" ${MCPInstallDir}/database.php

	touch /etc/cc_passwd
	touch /etc/cc_group

	chown $MCPInstallChownUser:$MCPInstallChownGroup /etc/cc_passwd
	chown $MCPInstallChownUser:$MCPInstallChownGroup /etc/cc_group

	echo "AuthUserFile /etc/cc_passwd" >> $MPCPROFTPDConfig
	echo "AuthGroupFile /etc/cc_group" >> $MPCPROFTPDConfig
	echo "RequireValidShell off" >> $MPCPROFTPDConfig
	echo "ServerName \"CastControl FTP Service\"" >> $MPCPROFTPDConfig
	echo "IdentLookups off" >> $MPCPROFTPDConfig
	echo "DefaultRoot ~" >> $MPCPROFTPDConfig
	
	/etc/init.d/proftpd restart
	chkconfig proftpd on
}

function CheckIoncube(){
	CheckDirectory

	#Check Ioncube
	IoncubeInstalled=$($PHPBINARY -q ${MCPInstallDir}/system/rpc.php | grep "requires the ionCube PHP Loader")
	if [ -n "$IoncubeInstalled" ]; then
		#Ioncube is not installed
		if [ -n "$Centos" -o -n "$Debian" ]; then
			if [ "$OSType" -eq "$x86"  ]; then
				IoncubeDL=http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_lin_x86.zip
			else
				IoncubeDL=http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip
			fi
			echo "Ioncube Loaders are not installed or not working."
			echo "Attempting to Install Ioncube Loaders."
			echo "Downloading Ioncube {$OSType}..."
			wget $IoncubeDL -nv
			echo " -> Done"
			
			echo "Applying loader to $PHPCONF... (backup exists at $PHPCONF.bak)..."
			unzip ioncube_loaders_lin_x86*zip >/dev/null
			mv ioncube/ $PHPEXTDIR/
			cp -a $PHPCONF $PHPCONF.bak
			'zend_extension = $PHPEXTDIR/ioncube/ioncube_loader_lin_$PHPVERSION.so' >> $PHPCONF
			echo " -> done."
			
			#Restart Webservice
			echo "Attempting to restart Web Service..."
			if [ -n "$Centos" ]; then
				service httpd restart
			else
				apache2ctl restart
			fi
			echo " -> Done."
			echo "Ioncube Loader Installation Complete"
		fi
		
	else
		echo "Ioncube is installed and working on PHP CLI";
	fi;
}

function InstJavaJRE()
{
	CheckDirectory
	#Check Java JRE Installed
	if [ -z "$IsJavaInstalled" ]; then
		echo "Installing Java JDK..."
		
		if [ -n "$Debian" ]; then
			#sudo apt-get install sun-java6-jdk >/dev/null
			IsJavaInstalled=$(java -version | grep -i "java")
			if [ -z "$IsJavaInstalled" ]; then
				echo "We have detected that JAVA JDK is either not installed or unavailable."
				echo "Setup will now download and attempt to install JAVA. Please wait..."
				if [ "$OSType" -eq "$x86"  ]; then
					wget http://mirror.cast-control.net/files/MCPSetup/jdk-6u31-linux-i586.bin -nv
					mv jdk-6u31-linux-i586.bin* jdk-6u31-linux-i586.bin
					sh jdk-6u31-linux-i586.bin
					mv jdk1.6.0_31/ /usr/local/jdk1.6.0_31
					
					if [ -f /usr/local/jdk1.6.0_31/bin/java ]; then
						ln -sf /usr/local/jdk1.6.0_31/bin/java /usr/bin/java
					else
						echo "Could not install Java JDK 1.6.0_26 on your system."
						echo "Please install Java JDK manually and re-attempt installation."
						exit;
					fi;
				fi
				
				if [ "$OSType" -eq "$x64"  ]; then
					wget http://cast-control.net/files/MCPSetup/jdk-6u31-linux-x64.bin -nv
					mv jdk-6u31-linux-x64.bin*  jdk-6u31-linux-x64.bin
					sh jdk-6u31-linux-x64.bin
					mv jdk1.6.0_31/ /usr/local/jdk1.6.0_31
					
					if [ -f /usr/local/jdk1.6.0_31/bin/java ]; then
						ln -sf /usr/local/jdk1.6.0_31/bin/java /usr/bin/java
					else
						echo "Could not install Java JDK 1.6.0_26 on your system."
						echo "Please install Java JDK manually and re-attempt installation."
						exit;
					fi;
				fi
			
			fi
			
		fi;
		
		if [ -n "$Centos" ]; then
			yum -y install java-jdk* >/dev/null 2>&1
			yum -y install java-1.6.0-openjdk java-1.6.0-openjdk-devel >/dev/null 2>&1
		fi
		echo " -> Completed. JAVA should now be installed on your system."
		echo "---------------------------------------------------------"
		java -version
		echo "---------------------------------------------------------"
		echo "Press enter to continue."
		read CONFIRM
	else
		echo "Java is installed"
		echo "---------------------------------------------------------"
		java -version
		echo "---------------------------------------------------------"
	fi
}

function InstWowza()
{
	CheckDirectory
	InstJavaJRE
	
	#Check is installed
	if [ ! -d /usr/local/WowzaMediaServer ]; then
		echo "Downloading Wowza Media Server..."
		wget http://www.wowzamedia.com/downloads/WowzaMediaServer-$WowzaMediaLatestA/WowzaMediaServer-$WowzaMediaLatestB.tar.bin -nv
		echo " -> Done."
			
		echo "Installing Wowza Media Server..."
		chmod +x WowzaMediaServer-*.bin
		./WowzaMediaServer-*.bin
		echo " -> Done."
			
		# Configure License Key
		echo "$WowzaMediaLicense" >> /usr/local/WowzaMediaServer/conf/Server.license
		
		echo "Starting Wowza Media Server..."
		/etc/init.d/WowzaMediaServer start
		echo " -> Done."
		
		echo "Set WowzaMediaServer to start on system boot..."
		chkconfig WowzaMediaServer on
		echo " -> Done."
	else
		echo "Wowza Media Server is already installed."
		/etc/init.d/WowzaMediaServer status
	fi
	
	IsWowzaInstalled=$(ls /usr/local/ | grep -i "WowzaMediaServer")
}

function UpgradeWowza()
{
	CheckDirectory
	
	#Save License
	WowzaMediaLicense=`more /usr/local/WowzaMediaServer-*/conf/Server.license`
	
	#Admin Passwords
	WowzaMediaPasswordFile=`more /usr/local/WowzaMediaServer-*/vhosts/default/conf/admin.password`
	
	#Backup
	rm -rf /root/WowzaBackup
	mkdir /root/WowzaBackup
	cd /usr/local/WowzaMediaServer-*/
	cp -a vhosts /root/WowzaBackup/vhosts
	cp -a conf /root/WowzaBackup/conf
	cp -a lib /root/WowzaBackup/lib
	cp -a content /root/WowzaBackup/content

	
	#Remove Current
	rm -rf /usr/local/WowzaMediaServer
	rm -rf /usr/local/WowzaMediaServer/
	rm -rf /usr/local/WowzaMediaServer-*/
	
	#Stop Wowza
	/etc/init.d/WowzaMediaServer stop
	
	#Install New
	InstWowza
	ConfWowza
	
	#Restore Services
	cp -a /root/WowzaBackup/conf/admin.password /usr/local/WowzaMediaServer/conf/admin.password
	cp -a /root/WowzaBackup/vhosts/default/conf/*/ /usr/local/WowzaMediaServer/vhosts/default/conf/
	cp -a /root/WowzaBackup/vhosts/default/applications/*/ /usr/local/WowzaMediaServer/vhosts/default/applications/
	
	# Restart Wowza Media Server
	cd /usr/local/WowzaMediaServer/bin/;
	/etc/init.d/WowzaMediaServer stop;
	sleep 2;
	/etc/init.d/WowzaMediaServer start;
	
	# Is Wowza Started?
	ISWowzaStarted=`ps aux | grep 'wowza' | grep -c 'wowza'`;
	if [ "$ISWowzaStarted" -gt 1 ]; then
		echo "Wowza Media Server has started successfully."
	fi
	
	IsWowzaInstalled=$(ls /usr/local/ | grep -i "WowzaMediaServer")
}

function ConfWowza(){
	CheckDirectory
	
	if [ -n "$IsWowzaInstalled" ]; then
		echo "Backing up configuration to /usr/local/Wowza.bak/conf/..."
		rm -rf /usr/local/Wowza.bak/;
		mkdir /usr/local/Wowza.bak/;
		cp -a /usr/local/WowzaMediaServer/conf/ /usr/local/Wowza.bak/conf/
		echo " -> Done."
		
		echo "Installing Security Libraries..."
			wget http://mirror.cast-control.net/files/MCPSetup/WowzaLibs2164.zip -nv
			unzip WowzaLibs2164.zip >/dev/null
			mv *.jar /usr/local/WowzaMediaServer/lib/
		echo " -> Done."
	
		echo "Configuring Wowza Media Server Integration for MediaCP..."
		
		# DEDICATED IP ADDRESS
		if [ "x$WowzaMediaIPAddress" == "x" ]; then
			echo ""
		else
			sed -i "s/<IpAddress>*</<IpAddress>$WowzaMediaIPAddress</g" /usr/local/WowzaMediaServer/conf/VHost.xml
		fi
		
		# StreamManager Password
		if [ "${WowzaMediaPasswordFile}" != "" ]; then
			echo "${WowzaMediaPasswordFile}" > /usr/local/WowzaMediaServer/conf/admin.password
		else
			echo "admin $WowzaMediaAdminPass" > /usr/local/WowzaMediaServer/conf/admin.password
		fi
		
		#Vhost.xml
		sed -i 's/<Port>1935</<Port>1935,554</g' /usr/local/WowzaMediaServer/conf/VHost.xml
		
		#Vhosts.xml
		sed -i 's/_defaultVHost_/default/g' /usr/local/WowzaMediaServer/conf/VHosts.xml
		sed -i 's/>\${com.wowza.wms.ConfigHome}/>\${com.wowza.wms.ConfigHome}\/vhosts\/default/g' /usr/local/WowzaMediaServer/conf/VHosts.xml
		
		#Authentication.xml
		sed -i 's/\/publish.password/\/\${com.wowza.wms.context.Application}\/publish.password/g' /usr/local/WowzaMediaServer/conf/Authentication.xml
		#Application.xml
		sed -i 's/<\/Modules>/<Module>\n\t<Name>ModuleLimitPublishedStreamBandwidth<\/Name>\n\t<Description>Module Limit to Published Stream Bandwidth<\/Description>\n\t<Class>com.wowza.wms.plugin.collection.module.ModuleLimitPublishedStreamBandwidth<\/Class>\n\t<\/Module>\n\t<Module>\n\t<Name>ModuleLimitConnectionsToApplication<\/Name>\n\t<Description>Limit connnections to an application<\/Description>\n\t<Class>com.wowza.wms.plugin.collection.module.ModuleLimitConnectionsToApplication<\/Class>\n\t<\/Module>\n\t<Module>\n\t<Name>ModuleRTMPAuthenticate<\/Name>\n\t<Description>ModuleRTMPAuthenticate<\/Description>\n\t<Class>com.wowza.wms.plugin.security.ModuleRTMPAuthenticate<\/Class>\n\t<\/Module>\n\t\t<\/Modules>/g' /usr/local/WowzaMediaServer/conf/Application.xml
		
		#Server.xml Remote JMX Config
		sed -i 's/<Enable>false<\/Enable>/<Enable>true<\/Enable>/g' /usr/local/WowzaMediaServer/conf/Server.xml

		
		mkdir /usr/local/WowzaMediaServer/vhosts/
		mkdir /usr/local/WowzaMediaServer/vhosts/default/
		
		cp -a /usr/local/WowzaMediaServer/applications /usr/local/WowzaMediaServer/vhosts/default/applications/
		cp -a /usr/local/WowzaMediaServer/content /usr/local/WowzaMediaServer/vhosts/default/content
		cp -a /usr/local/WowzaMediaServer/conf /usr/local/WowzaMediaServer/vhosts/default/conf
		cp -a /usr/local/WowzaMediaServer/keys /usr/local/WowzaMediaServer/vhosts/default/keys
		cp -a /usr/local/WowzaMediaServer/logs /usr/local/WowzaMediaServer/vhosts/default/logs
		
		# Apply Permissions to allow web user to modify
		chown nobody -R /usr/local/WowzaMediaServer/vhosts
		chown nobody -R /usr/local/WowzaMediaServer/vhosts
		if [ -n "$Centos" -o -n "$Debian" ]; then
			chown apache -R /usr/local/WowzaMediaServer/vhosts >/dev/null 2>&1
			chown apache -R /usr/local/WowzaMediaServer/content >/dev/null 2>&1
		else
			chown www-data -R /usr/local/WowzaMediaServer/vhosts >/dev/null 2>&1
			chown www-data -R /usr/local/WowzaMediaServer/content >/dev/null 2>&1
		fi
		
		chmod -R 777 /usr/local/WowzaMediaServer/content
		chmod -R 777 /usr/local/WowzaMediaServer/vhosts
		
		# Remove Unwanted configurations
		rm -rf /usr/local/WowzaMediaServer/vhosts/default/conf/aac;
		rm -rf /usr/local/WowzaMediaServer/vhosts/default/conf/bwcheck;
		rm -rf /usr/local/WowzaMediaServer/vhosts/default/conf/live;
		rm -rf /usr/local/WowzaMediaServer/vhosts/default/conf/rtplive;
		rm -rf /usr/local/WowzaMediaServer/vhosts/default/conf/shoutcast;
		rm -rf /usr/local/WowzaMediaServer/vhosts/default/conf/textchat;
		rm -rf /usr/local/WowzaMediaServer/vhosts/default/conf/videochat;
		rm -rf /usr/local/WowzaMediaServer/vhosts/default/conf/vod;
		
		echo " -> Done."
		
		# Restart Wowza Media Server
		cd /usr/local/WowzaMediaServer/bin/;
		/etc/init.d/WowzaMediaServer stop;
		sleep 2;
		/etc/init.d/WowzaMediaServer start;
		
		IsWowzaInstalled=$(ls /usr/local/ | grep -i "WowzaMediaServer")
		
	else
		echo ""
		echo "Wowza Media Server is NOT INSTALLED."
		/etc/init.d/WowzaMediaServer status
		echo ""
	fi
}

function TuneWowza()
{
	echo "Tuning Wowza Media Server..."
	
	# 32 or 64 Wowza?
	rm -f /root/mcp.wowza
	java -d64 -version >/root/mcp.wowza 2>&1
	JAVA64MSG=`cat /root/mcp.wowza`
	JAVA64="y";
	if [ "$JAVANO64" == "Running a 64-bit JVM is not supported on this platform." ]; then
		JAVA64="n";
	fi
	
	
	# How Much Memory should we automatically configure
	WowzaTuneMemory=1200;
	WowzaTuneAvailableMemory=(`free -m | awk 'NR>1{print $2; exit}'`);
	let "WowzaTuneMemory=${WowzaTuneMemory}*75/100"
	
	if [ "${WowzaTuneAvailableMemory}" -gt 1900 ]; then
		WowzaTuneMemory=1500;
	fi
	if [ "${WowzaTuneAvailableMemory}" -gt 2900 -a "${JAVA64}" == "y" ]; then
		WowzaTuneMemory=2000;
	fi
	if [ "${WowzaTuneAvailableMemory}" -gt 3500 -a "${JAVA64}" == "y" ]; then
		WowzaTuneMemory=3000;
	fi
	if [ "${WowzaTuneAvailableMemory}" -gt 4500 -a "${JAVA64}" == "y" ]; then
		WowzaTuneMemory=4000;
	fi
	if [ "${WowzaTuneAvailableMemory}" -gt 15900 -a "${JAVA64}" == "y" ]; then
		echo ""
		echo "It appears you have more than 16GB of memory on your server."
		echo "Would you like to configure 8GB for Wowza Media Server? (y/n)"
		read CONFIRM;
		if [ "$CONFIRM" == "y" ]; then		
			WowzaTuneMemory=8000;
		else
			WowzaTuneMemory=4000;
		fi
	fi
	
	# Tune Wowza Memory
	if [ "${WowzaTuneMemory}" -gt 1200 ]; then
		CheckDirectory
		cd /usr/local/WowzaMediaServer/;
		
		cp /usr/local/WowzaMediaServer/bin/setenv.sh /usr/local/WowzaMediaServer/bin/setenv.sh.bak
		
		sed -i "s/-Xmx.*M/-Xmx${WowzaTuneMemory}M/g" /usr/local/WowzaMediaServer/bin/setenv.sh
		echo "Applied Memory tuning of ${WowzaTuneMemory}MB."
	else
		echo "Available memory is too low, ${WowzaTuneAvailableMemory}MB. "
		echo "The default 1200MB setting will be used by Wowza Media Server"
		echo ""
	fi
	
	
	# Get CPU Information
	WowzaTuneCores=(`grep processor /proc/cpuinfo | tail -1 | awk '{print $3; exit}'`);
	let "WowzaTuneCores=$WowzaTuneCores+1"
	let "WowzaTuneCoresDouble=${WowzaTuneCores}*2"
	let "WowzaTuneThreadPool=(${WowzaTuneCores}*300)/5"
	let "WowzaTuneTransportThreadPool=(${WowzaTuneCores}*300)/5"
	
	# Tune CPU
	if [ "${WowzaTuneCores}" -lt 8 ]; then
		echo "Your Processor has only ${WowzaTuneCores} core available."
		echo "The default values will be used by Wowza Media Server"
	else
		CheckDirectory
		cd /usr/local/WowzaMediaServer/;
		
		cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.pretune
		
		if [ "${WowzaTuneCores}" -gt 15 ]; then
			# Update All ProcessorCount
				sed -i "s/<ProcessorCount>4<\/ProcessorCount>/<ProcessorCount>24<\/ProcessorCount>/g" /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
											
			# Unicast Incoming
				cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
				sed -n '1h; 1!H; ${ g; s/<UnicastIncoming>.*<ProcessorCount>.*<\/ProcessorCount>.*<\/UnicastIncoming>/<UnicastIncoming><ProcessorCount>16<\/ProcessorCount><\/UnicastIncoming>/ p }' /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp > /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
			
			# Unicast Outgoing
				cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
				sed -n '1h; 1!H; ${ g; s/<UnicastOutgoing>.*<ProcessorCount>.*<\/ProcessorCount>.*<\/UnicastOutgoing>/<UnicastOutgoing><ProcessorCount>24<\/ProcessorCount><\/UnicastOutgoing>/ p }' /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp > /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml

			# Multicast Incoming
				cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
				sed -n '1h; 1!H; ${ g; s/<MulticastIncoming>.*<ProcessorCount>.*<\/ProcessorCount>.*<\/MulticastIncoming>/<MulticastIncoming><ProcessorCount>16<\/ProcessorCount><\/MulticastIncoming>/ p }' /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp > /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml

			# Multicast Outgoing
				cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
				sed -n '1h; 1!H; ${ g; s/<MulticastOutgoing>.*<ProcessorCount>.*<\/ProcessorCount>.*<\/MulticastOutgoing>/<MulticastOutgoing><ProcessorCount>24<\/ProcessorCount><\/MulticastOutgoing>/ p }' /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp > /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
				
			# Poolsize
				if [ "${WowzaTuneThreadPool}" -gt 480 ]; then WowzaTuneThreadPool=480; fi
				if [ "${WowzaTuneTransportThreadPool}" -gt 320 ]; then WowzaTuneTransportThreadPool=320; fi
			
				sed -i "s/<PoolSize>120<\/PoolSize>/<PoolSize>${WowzaTuneThreadPool}<\/PoolSize>/g" /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
				sed -i "s/<PoolSize>80<\/PoolSize>/<PoolSize>${WowzaTuneTransportThreadPool}<\/PoolSize>/g" /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
				
				
			echo "Applied CPU Tuning for 16 Cores.";
			
		elif [ "${WowzaTuneCores}" -gt 7 ]; then
		
			# Update All ProcessorCount
				sed -i "s/<ProcessorCount>4<\/ProcessorCount>/<ProcessorCount>16<\/ProcessorCount>/g" /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
						
			# Unicast Incoming
				cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
				sed -n '1h; 1!H; ${ g; s/<UnicastIncoming>.*<ProcessorCount>.*<\/ProcessorCount>.*<\/UnicastIncoming>/<UnicastIncoming><ProcessorCount>8<\/ProcessorCount><\/UnicastIncoming>/ p }' /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp > /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
			
			# Unicast Outgoing
				cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
				sed -n '1h; 1!H; ${ g; s/<UnicastOutgoing>.*<ProcessorCount>.*<\/ProcessorCount>.*<\/UnicastOutgoing>/<UnicastOutgoing><ProcessorCount>16<\/ProcessorCount><\/UnicastOutgoing>/ p }' /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp > /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml

			# Multicast Incoming
				cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
				sed -n '1h; 1!H; ${ g; s/<MulticastIncoming>.*<ProcessorCount>.*<\/ProcessorCount>.*<\/MulticastIncoming>/<MulticastIncoming><ProcessorCount>8<\/ProcessorCount><\/MulticastIncoming>/ p }' /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp > /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml

			# Multicast Outgoing
				cp -a /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
				sed -n '1h; 1!H; ${ g; s/<MulticastOutgoing>.*<ProcessorCount>.*<\/ProcessorCount>.*<\/MulticastOutgoing>/<MulticastOutgoing><ProcessorCount>8<\/ProcessorCount><\/MulticastOutgoing>/ p }' /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp > /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
				
			# Poolsize
				if [ "${WowzaTuneThreadPool}" -gt 480 ]; then WowzaTuneThreadPool=480; fi
				if [ "${WowzaTuneTransportThreadPool}" -gt 320 ]; then WowzaTuneTransportThreadPool=320; fi
			
				sed -i "s/<PoolSize>120<\/PoolSize>/<PoolSize>${WowzaTuneThreadPool}<\/PoolSize>/g" /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
				sed -i "s/<PoolSize>80<\/PoolSize>/<PoolSize>${WowzaTuneTransportThreadPool}<\/PoolSize>/g" /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml
				
				
			echo "Applied CPU Tuning for 8 Cores.";
			
		fi
		
		rm -f /usr/local/WowzaMediaServer/vhosts/default/conf/VHost.xml.tmp
	
	fi
	
	echo ""
	echo "Tuning Complete".;
	echo "Press return to restart Wowza Media Server or CTRL + C to close.";
	read CONFIRM;
	
	# Restart Wowza Media Server
	cd /usr/local/WowzaMediaServer/bin/;
	/etc/init.d/WowzaMediaServer stop;
	sleep 2;
	/etc/init.d/WowzaMediaServer start;

	# Is Wowza Started?
	ISWowzaStarted=`ps aux | grep 'wowza' | grep -c 'wowza'`
	if [ "$ISWowzaStarted" -gt 0 ]; then echo "Wowza Media Server has started successfully."; fi
	
}


function InstIceCastKH()
{
	CheckDirectory
                        
    echo "Icecast KH Installation..."
    if [ ! -f /usr/local/bin/icecastkh ]; then
  
	

            echo "Downloading..."	
                wget http://mirror.cast-control.net/files/MCPSetup/icecast-kh-icecast-2.3.3-kh9.tar.gz -q 
            echo "-> Done"
            
            echo "Exctracting..."
	            tar -xzvf icecast-kh-icecast-2.3.3-kh9.tar.gz     >/dev/null
            echo "-> Done"
            
	        cd icecast-kh-icecast-2.3.3-kh9
            
            echo "Compiling..."  
				mkdir /root/CastControlTMP/icecastkh;
				./configure --prefix=/root/CastControlTMP/icecastkh > /root/CastControlTMP/logs/IcecastConfigure
				
	            StatusIcecast=$(grep -i "warning|error|exit" /root/CastControlTMP/logs/IcecastKHConfigure)
				if [ -n "$StatusIcecast" ]; then
					 echo "Icecast ./configure may have failed. Press Enter to display configure results"
					 pause "paused"
					 more /root/CastControlTMP/logs/IcecastKHConfigure
					 echo "---------------------------------------------------------"
					 echo "Do you wish to continue anyway? (y/n)"
					 read CONTINUE
					 if [[$CONTINUE != "y" && $CONTINUE != "Y"]]; then
						exit
					 fi
				fi
	            make     >/dev/null 2>&1
            echo "-> Done"
            
            echo "Installing..."
				touch /root/CastControlTMP/logs/IcecastKHMakeInstall
	            make install >/root/CastControlTMP/logs/IcecastKHMakeInstall
				
	            StatusIcecast=$(grep -i "warning|error|exit" /root/CastControlTMP/logs/IcecastKHMakeInstall)
				if [ -n "$StatusIcecast" ]; then
					 echo "Icecast KH make install may have failed. Press Enter to display configure results"
					 pause "paused"
					 more /root/CastControlTMP/logs/IcecastKHMakeInstall
					 echo "---------------------------------------------------------"
					 echo "Do you wish to continue anyway? (y/n)"
					 read CONTINUE
					 if [[$CONTINUE != "y" && $CONTINUE != "Y"]]; then
						exit
					 fi
				fi
				
				mv /root/CastControlTMP/icecastkh/share/icecast /usr/local/share/icecastkh;
				mv /root/CastControlTMP/icecastkh/bin/icecast /usr/local/bin/icecastkh;
            echo "-> Done"

    else
        echo "Already Installed..."
        icecast
        echo "Press any key to continue."
		pause ""
    fi
}


function InstIceCast()
{
	CheckDirectory
                        
    echo "Icecast 2.3.3 Installation..."
    if [ ! -f /usr/local/bin/icecast ]; then
    
	
		if [ "$OSType" -eq "$x64" ]; then
			cd /usr/lib;
			
			#Make sure libxml 2.6.26 exists so we dont destroy libxml
			if [ -e /usr/lib/libxml2.so.2.6.26 ]; then
				rm -f libxml2.so;
				rm -f libxml2.so.2;
				ln -s /usr/lib/libxml2.so.2.6.26 /usr/lib/libxml2.so;
				ln -s /usr/lib/libxml2.so.2.6.26 /usr/lib/libxml2.so.2;
			fi

			if [ -e /usr/lib64/libxml2.so.2.6.26 ]; then
				cd /usr/lib64;
				rm -f libxml2.so;
				rm -f libxml2.so.2;
				ln -s /usr/lib64/libxml2.so.2.6.26 /usr/lib64/libxml2.so;
				ln -s /usr/lib64/libxml2.so.2.6.26 /usr/lib64/libxml2.so.2;
			fi
			
			#Return back to TMP dir
			cd /root/CastControlTMP
		else
			if [ -e /usr/lib/libxml2.so.2.6.26 ]; then
				cd /usr/lib;
				rm -f libxml2.so;
				rm -f libxml2.so.2;
				ln -s /usr/lib/libxml2.so.2.6.26 /usr/lib/libxml2.so;
				ln -s /usr/lib/libxml2.so.2.6.26 /usr/lib/libxml2.so.2;
			fi
		fi
	

            echo "Downloading..."	
                wget http://cast-control.net/files/MCPSetup/icecast-2.3.3.tar.gz -q 
            echo "-> Done"
            
            echo "Exctracting..."
	            tar -xzvf icecast-2.3.3.tar.gz     >/dev/null
            echo "-> Done"
            
	        cd icecast-2.3.3
            
            echo "Compiling..."  
				./configure > /root/CastControlTMP/logs/IcecastConfigure
				
	            StatusIcecast=$(grep -i "warning|error|exit" /root/CastControlTMP/logs/IcecastConfigure)
				if [ -n "$StatusIcecast" ]; then
					 echo "Icecast ./configure may have failed. Press Enter to display configure results"
					 pause "paused"
					 more /root/CastControlTMP/logs/IcecastConfigure
					 echo "---------------------------------------------------------"
					 echo "Do you wish to continue anyway? (y/n)"
					 read CONTINUE
					 if [[$CONTINUE != "y" && $CONTINUE != "Y"]]; then
						exit
					 fi
				fi
	            make     >/dev/null 2>&1
            echo "-> Done"
            
            echo "Installing..."
				touch /root/CastControlTMP/logs/IcecastMakeInstall
	            make install >/root/CastControlTMP/logs/IcecastMakeInstall
				
	            StatusIcecast=$(grep -i "warning|error|exit" /root/CastControlTMP/logs/IcecastMakeInstall)
				if [ -n "$StatusIcecast" ]; then
					 echo "Icecast make install may have failed. Press Enter to display configure results"
					 pause "paused"
					 more /root/CastControlTMP/logs/IcecastMakeInstall
					 echo "---------------------------------------------------------"
					 echo "Do you wish to continue anyway? (y/n)"
					 read CONTINUE
					 if [[$CONTINUE != "y" && $CONTINUE != "Y"]]; then
						exit
					 fi
				fi
            echo "-> All Done"

    else
        echo "Already Installed..."
        icecast
        echo "Press any key to continue."
		pause ""
    fi
}

function InstLibShout()
{
    CheckDirectory
    
    echo "LibShout 2.2.2 Installation..."
    
    if [ ! -f /usr/local/lib/libshout.a ]; then
        
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/libshout-2.2.2.tar.gz -q 
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf libshout-2.2.2.tar.gz     >/dev/null
        echo "-> Done"
        
        cd libshout-2.2.2
        
        echo "Compiling..."   
            ./configure   >/dev/null 2>&1
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
                make install  >/dev/null 2>&1
            echo "-> All Done"
    else
        echo "Already Installed... Moving On!"
    fi
}

function InstLame()
{
    CheckDirectory
    
    echo "Lame Installation..."
    
    if [ ! -f /usr/local/lib/libmp3lame.a ]; then   
    
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/lame-398-2.tar.gz -q 
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf lame-398-2.tar.gz >/dev/null 2>&1
        echo "-> Done"
        
        cd lame-398-2 
        
        echo "Compiling..."   
            ./configure   >/dev/null 2>&1
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
            make install  >/dev/null 2>&1
			cp -a /usr/local/lib/libmp3lame.* /usr/lib/ >/dev/null 2>&1
        echo "-> All Done"
    else
        echo "Already Installed..."
        lame
		echo "Press any key to continue."
		pause ""
    fi
}  

function InstLameFix()
{
    if [ -n "$Centos" ]; then 
        
        CheckDirectory
        
        echo "Lame Installation..."
  
            if [ "$OSType" -eq "$x86" ]; then
                rpm -Uh http://cast-control.net/files/MCPSetup/lame-3.98.2-1.el5.rf.i386.rpm 
                rpm -Uh  http://cast-control.net/files/MCPSetup/lame-devel-3.98.2-1.el5.rf.i386.rpm 
            fi
            
            if [ "$OSType" -eq "$x64" ]; then
                rpm -ih http://cast-control.net/files/MCPSetup/lame-3.98.2-1.el5.rf.x86_64.rpm
                rpm -ih http://cast-control.net/files/MCPSetup/lame-devel-3.98.2-1.el5.rf.x86_64.rpm
            fi     
            
                                                            
        echo "-> All Done"
    fi
}


function InstFaac()
{ 
    CheckDirectory
    
    echo "Faac Installation..."
    
    if [ ! -f /usr/bin/faac ]; then
    
        if [ -n "$Centos" ]; then  
            
            if [ "$OSType" -eq "$x86" ]; then
                rpm -Uf http://cast-control.net/files/MCPSetup/faac-1.26-1.el5.rf.i386.rpm 
            fi
            
            if [ "$OSType" -eq "$x64" ]; then
                rpm -Uf http://cast-control.net/files/MCPSetup/faac-1.26-1.el5.rf.x86_64.rpm
            fi
                 
        fi
     
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/faac-1.25.tar.gz -q
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf faac-1.25.tar.gz     >/dev/null
        echo "-> Done"
        
        cd faac

        echo "Appliing bootstrap and pipe patch..."
        wget http://cast-control.net/files/MCPSetup/Faac.bootstrap.patch -q
        wget http://cast-control.net/files/MCPSetup/Faac.pipe.patch -q
        patch -p1 < Faac.bootstrap.patch >/dev/null 2>&1
        patch -p1 < Faac.pipe.patch >/dev/null 2>&1
        autoreconf -vif >/dev/null 2>&1
        echo "-> Done"    
        
        echo "Compiling..."   
            ./configure   >/dev/null 2>&1
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
            make install  >/dev/null 2>&1
        echo "-> All Done"    
    else
        echo "Already Installed..."
        faac
		echo "Press any key to continue."
		pause ""
    fi
}

function InstFaad()
{        
    CheckDirectory
    
    echo "Faad Installation..."
    
    if [ ! -f /usr/local/bin/faad ]; then
    
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/faad2-2.7.tar.gz -q
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf faad2-2.7.tar.gz     >/dev/null
        echo "-> Done"
        
        cd faad2-2.7  
        
        echo "Compiling..."   
            ./configure   >/dev/null 2>&1
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
            make install  >/dev/null 2>&1
        echo "-> All Done"
    else
        echo "Already Installed..."
        faad
		echo "Press any key to continue."
		pause ""
    fi
}

function InstFlac()
{
    CheckDirectory
    
    echo "Flac Installation..."
    
    if [ ! -f /usr/bin/flac ]; then
    
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/flac-1.2.1.tar.gz -q
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf flac-1.2.1.tar.gz >/dev/null
        echo "-> Done"
        
        cd flac-1.2.1 
           
        echo "Applying Memmp Fix"   
            mv ./examples/cpp/encode/file/main.cpp ./examples/cpp/encode/file/main.cpp.tmp  
            mv ./examples/cpp/decode/file/main.cpp ./examples/cpp/decode/file/main.cpp.tmp   
            sed 's/#include <stdlib.h>/#include <stdlib.h>\n#include <cstring>/g' ./examples/cpp/encode/file/main.cpp.tmp > ./examples/cpp/encode/file/main.cpp 
            sed 's/#include <stdlib.h>/#include <stdlib.h>\n#include <cstring>/g' ./examples/cpp/decode/file/main.cpp.tmp > ./examples/cpp/decode/file/main.cpp
        
        echo "Compiling..."     
            ./configure   >/dev/null 2>&1
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
            make install  >/dev/null 2>&1
        echo "-> All Done" 
    else
        echo "Already Installed..."
        flac
		echo "Press any key to continue."
		pause ""
    fi
       
}	


function InstIces04()
{
    CheckDirectory
    
    echo "Ices 0.4 Installation..."
    
    if [ ! -f /usr/local/bin/ices04 ]; then
    
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/ices-0.4.tar.gz  -q
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf ices-0.4.tar.gz      >/dev/null 2>&1
        echo "-> Done"
         
        cd ices-0.4 
        
        echo "Compiling..."   
            ./configure --without-flac   >/dev/null 2>&1
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
            make install  >/dev/null 2>&1
            mv /usr/local/bin/ices /usr/local/bin/ices04
        echo "-> All Done" 
    
    else
        echo "Already Installed..."
        ices04
		echo "Press any key to continue."
		pause ""
    fi   
}

function InstIces2()
{
    CheckDirectory
    
    echo "Ices 2 Installation..."
    
   if [ ! -f /usr/local/bin/ices ]; then 
    
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/ices-2.0.1.tar.gz -q
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf ices-2.0.1.tar.gz    >/dev/null
        echo "-> Done"
        
        cd ices-2.0.1
        
        echo "Compiling..."   
            ./configure   >/dev/null
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
            make install  >/dev/null 2>&1
        echo "-> All Done"
    
    else
        echo "Already Installed..."
        ices   
		echo "Press any key to continue."
		pause ""
    fi     
}

function InstMad()
{
    CheckDirectory
    
    echo "LibMad Installation..."
    
    if [ ! -f /usr/local/lib/libmad.a ]; then   
    
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/mad-0.14.2b.tar.gz -q
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf mad-0.14.2b.tar.gz     >/dev/null
        echo "-> Done"
        
        cd mad-0.14.2b  
        
        echo "Compiling..."   
            ./configure   >/dev/null 2>&1
			mv Makefile Makefile.tmp
            sed 's/-m486/-mtune=i486/g' Makefile.tmp > Makefile
			
        echo "Applying -fforce-mem fix for gcc..."   
            cd libmad 
			mv Makefile Makefile.tmp
            sed 's/-fforce-mem//g' Makefile.tmp > Makefile
			rm Makefile.tmp;mv Makefile Makefile.tmp
            sed 's/-m486/-mtune=i486/g' Makefile.tmp > Makefile
            cd .. 
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
            make install  >/dev/null 2>&1
        echo "-> All Done"
    else
        echo "Already Installed... Moving On!"
    fi         
}

function InstStreamTransCoder()
{
    CheckDirectory
    
    echo "Stream Transcoder Installation..."
    
    echo "Downloading..."    
        wget http://cast-control.net/files/MCPSetup/streamtranscoderv3-3.1.11.tar.gz -q
    echo "-> Done"
    
    echo "Exctracting..."
        tar -xzvf streamtranscoderv3-3.1.11.tar.gz     >/dev/null 
    echo "-> Done"
    
	ldconfig
	
    cd streamtranscoderv3-3.1.11 
    
    if [ -n "$Centos" ]; then      
        wget http://cast-control.net/files/MCPSetup/streamTranscoder-aac.patch -q
        patch -p1 < streamTranscoder-aac.patch >/dev/null 2>&1
        aclocal -I m4/ >/dev/null 2>&1
        autoconf >/dev/null 2>&1
        automake >/dev/null 2>&1
    fi
    
    echo "Compiling..."   
        ./configure   >/dev/null 2>&1
        make     >/dev/null 2>&1
    echo "-> Done"
    
    echo "Installing..."
        make install  >/dev/null 2>&1
    echo "-> All Done"
}  


function InstRRDTools()
{
    CheckDirectory
    
    echo "RRD Tools Installation..."
    
	# Lets Check for RRDTool on the system first
	if [ ! -f "/usr/bin/rrdtool" -a ! -f "/usr/local/cpanel/3rdparty/bin/rrdtool" -a ! -f "/usr/local/rrdtool-1.3.6/bin/rrdtool" ]; then 
    
	
	
        echo "Downloading..."    
            wget http://cast-control.net/files/MCPSetup/rrdtool-1.3.6.tar.gz -q
        echo "-> Done"
        
        echo "Exctracting..."
            tar -xzvf rrdtool-1.3.6.tar.gz     >/dev/null
        echo "-> Done"
        
        cd rrdtool-1.3.6
        
        echo "Compiling..."   
            ./configure   >/dev/null 2>&1
            make     >/dev/null 2>&1
        echo "-> Done"
        
        echo "Installing..."
			make >/dev/null 2>&1
            make install  >/dev/null 2>&1
        echo "-> All Done"
    else
        echo "Already Installed..."
		/usr/local/rrdtool -v
        /usr/local/rrdtool-1.3.6/bin/rrdtool -v
		/usr/local/cpanel/3rdparty/bin/rrdtool -v
		echo "Press any key to continue."
		pause ""
    fi
}    

function InstPreRequisites()
{
	#
	# Cast Control Installation
	#	
	if [ -n "$Debian" -a "$InstallPreReq" == "y" ]; then
	echo "Current installation is for $Debian"
		echo "Aptitude cleaning..."
			apt-get clean > /dev/null 2>&1
		echo "-> Done"
		echo ""
		echo "Aptitude updating..."
			apt-get update > /dev/null 2>&1
		echo "-> Done"
		echo ""
		echo "Aptitude installing essentials for the MediaCP installation..."
			apt-get install rcconf openssl gcc makepasswd build-essential libtemplate-plugin-yaml-perl debianutils libxml-filter-xslt-perl libxslt1-dev libvorbis-dev automake  -V -y --force-yes   >/dev/null
		echo "."
		#no longer run the following due to mysql request: apache2 php5 php5-gd php5-mysql php5-cli mysql-server
			apt-get install libtool gettext wget tar gzip freetype* rrdtool unzip -V -y --force-yes   >/dev/null
			apt-get install php-apc -V -y --force-yes >/dev/null
		echo ".."
			apt-get install texinfo  debhelper cdbs -V -y --force-yes  >/dev/null
		echo "..."
			apt-get install rrdtool -V -y --force-yes  >/dev/null
		echo "...."
			apt-get install libcairo2-dev libpango1.0-dev  lc-dev  liblame-dev -V -y --force-yes >/dev/null
		echo "-> Done"
		echo ""
		echo "Installing automake..."
			CheckDirectory
			apt-get --compile source automake1.7 >/dev/null 2>&1
			dpkg -i  automake1.7_1.7.9-9_all.deb >/dev/null 2>&1
		echo "-> Done"
		echo ""
		
		if [ "$OSType" -eq "$x64" ]; then
			echo "Essentials for x64 installation..."
			apt-get install ia32-libs -V -y --force-yes >/dev/null
		fi
		
	fi

	  

	#
	# Centos Installation
	#	
	if [ -n "$Centos" -a "$InstallPreReq" == "y" ]; then
		echo "Current installation is for $Centos"

		echo "First step is to update yum. Press any key to continue."
		pause ""
		if [ "$Unattended" == "true" ]; then
			yum --exclude=kernal* update -y
		else
			yum --exclude=kernal* update -y
		fi
		echo "---------------------------------------------------------"
		echo "-> Done"
		
		echo "Essentials for the MediaCP installation..."
		yum install libvorbis-devel speex-devel libtheora-devel libxslt-devel curl-devel rpm-build unzip -y -d 0 -e 0
		echo "."
		yum install gcc gcc-c++ automake autoconf libtool libogg libvorbis libxml2 libshout libshout-devel flac-devel flac123 faac-devel -y -d 0 -e 0
		echo ".."
		yum install faac lame libao rpm-devel rpm-libs rpm-build libvorbis-devel libogg-devel curl-devel -y -d 0 -e 0
		echo "..."
		yum install gettext cairo-devel php-gd libpng-devel freetype freetype-devel libart_lgpl-devel libxml2 libxml2-devel pango-devel dejavu-lgc-fonts -y  -d 0 -e 0
		echo "...."
		yum install libxslt-devel libtheora-devel speex-deve gettext pango-devel -y -d 0 -e 0
		echo "....."
		yum install rrdtool -y -d 0 -e 0
		echo "......"
		yum install make -y -d 0 -e 0
		echo "......"
		# Install FIX for CentOS 6 w/ Shoutcast 2 - error while loading shared libraries: libstdc++.so.6
		yum install libstdc++.so.6 -y -d 0 -e 0
		echo "-> Done"
		
		if [ "$OSType" -eq "$x64" ]; then
			echo "Essentials for x64 installation..."
			yum install zlib-devel.x86_64 -y -d 0 -e 0
			yum install ld-linux.so.2 -y -d 0 -e 0
			yum install lib32-glib -y -d 0 -e 0
			
			echo "-> Done"
		fi
		
		echo "Centos Src Fix..."
		SrcFix
		echo "-> Done"
		
		

	fi

	#
	# Suse Installation
	#    
	if [ -n "$Suse" -a "$InstallPreReq" == "y" ]; then
		echo "Current installation is for Suse"

		echo "Yum Updating..."
		yast -update
		echo "-> Done"
		
		echo "Essentials for the MediaCP installation..."
		yast -i libvorbis-devel speex-devel libtheora-devel libxslt-devel curl-devel  >/dev/null
		echo "."
		yast -i gcc gcc-c++ libogg libvorbis libxml2 libshout libshout-devel >/dev/null
		echo ".."
		yast -i libtool libao rpm-devel  libvorbis-devel libogg-devel  >/dev/null
		echo "..."
		yast -i cairo-devel php-gd libpng-devel freetype libart_lgpl-devel libxml2 libxml2-devel pango-devel  >/dev/null
		echo "...."
		yast -i libxslt-devel libtheora-devel make patch autoconf automake pkg-config gettext freetype fontconfig intltool >/dev/null
		echo "-> Done"
		
	fi
}


function FixPHPDisplayErrors(){

	if [ -f $PHPCONF ]; then
		sed -i 's/display_errors = 20M/upload_max_filesize = 20M/g' $PHPCONF
	else
		echo "Unable to fix PHP display_errors";
	fi
}

#
# Normal Installation
#


CheckDirectory


# Retrieve Paramatars
while [ "$1" != "${1##[-+]}" ]; do
	case $1 in
		-default)
			echo "Setup Config: Default Configuration will be used.";
			LicenseReq="n"
			shift
			;;
		-wowzaedge)
			echo "Setup Config: Wowza 3.5 will be installed.";
			WowzaMediaLatestA="3-6-2"
			WowzaMediaLatestB="3.6.2"
			shift
			;;
		
		-displayerrors)
			echo "Setup Config: Fix PHP Display Errors";
			FixPHPDisplayErrors
			
			exit;
			shift
			;;
		-installjson)
			echo "Setup Config: Install PHP JSON";
			InstallPHPJSON
			exit;
			shift
			;;
			
		-resetmysql)
			echo "Setup Config: Reset MySQL root password";
			ResetMySQLPassword
			exit;
			shift
			;;
		
		-stv3)
			echo "Setup Config: STV3 will be installed.";
			InstallSTV3="y"
			shift
			;;
			
			
			
		-installrrdtool)
			echo "Setup Config: RRDTool will be installed.";
			InstallRRDTool="y"
			shift
			;;
			
		-installwowza)
			echo "Setup Config: Install & Configure Wowza Media Server";
			InstallWowza="y"
			ConfigWowza="y"
			#WowzaTune="y"
			
			echo "Please enter your Wowza Media Server License to continue";
			read WowzaMediaLicense
			
			echo "Please enter a new password for Wowza Media Server Administration";
			read WowzaMediaAdminPass
			
				
			echo "Please enter a dedicated IP address for Wowza Media Server"
			echo "Leave blank and press Enter to bind on all addresses"
			echo ""
			echo "** This MUST be the same IP address as configured in MediaCP."
			read WowzaMediaIPAddress
			shift
			;;	
		-configwowza)
			echo "Setup Config: Configure Wowza Media Server";
			ConfigWowza="y"
			WowzaTune="y"
			
			echo "Please enter a new password for Wowza Media Server Administration";
			read WowzaMediaAdminPass
			shift
			;;	
		-upgradewowza)
			if [ -d "/usr/local/WowzaMediaServer/" ]; then
				echo "Setup Config: Upgrade Wowza Media Server";
				UpgrWowza="y"
				#WowzaTune="y"
			fi
			shift
			;;	
		-tunewowza)
			if [ -d "/usr/local/WowzaMediaServer/" ]; then
				echo "Setup Config: Tuning Wowza Media Server";
				WowzaTune="y"
				LicenseReq="n"
				InstallPreReq="n"
				UpgradeMCP="n"
				InstallPreReq="n"
				InstallIcecast="n"
				InstallIcecastKH="n"
				InstallIces="n"
				InstallSTV3="n"
				InstallWowza="n"
				ConfigWowza="n"
				InstallIoncube="n"
				InstallMCP="n"
				LicenseReq="n"	
			fi
			shift
			;;	
		-ioncube)
			echo "Setup Config: Check & Install Ioncube..";
			InstallIoncube="y"
			shift
			;;	
		-ffmpeg)
			echo "Setup Config: Check & Install FFMPEG..";
			InstallFFMPEG="y"
			shift
			;;	
		-noicecast)
			#echo "Setup Config: Icecast will NOT be installed.";
			InstallIcecast="n"
			InstallIcecastKH="n"
			shift
			;;	
		-icecastkh)
			echo "Setup Config: IcecastKH will be installed.";
			InstallIcecastKH="n"
			shift
			;;	
		-noices)
			#echo "Setup Config: Ices will NOT be installed.";
			InstallIces="n"
			shift
			;;	
		-nomediacp)
			#echo "Setup Config: MediaCP will NOT be installed.";
			InstallMCP="n"
			shift
			;;	
		-noprereq)
			#echo "Setup Config: Prerequisites will NOT be installed.";
			InstallPreReq="n"
			shift
			;;	
		-edge)
			echo "Setup Config: The latest edge (unstable) release will be installed..";
			MediaCPRelease="unstable"
			shift
			;;	
		-unattended)
			echo "Setup Config: Unattended intsallation..";
			Unattended="true"
			shift
			;;	
		-mcpmain)
			echo "Setup Config: MCP DL = www.cast-control.net/files/..";
			MediaCPLocation="main"
			shift
			;;
		-upgrade)
			echo "Setup Config: Upgrade MCP..";
			UpgradeMCP="y"
			
			InstallPreReq="n"
			InstallIcecast="n"
			InstallIces="n"
			InstallSTV3="n"
			InstallWowza="n"
			ConfigWowza="n"
			#WowzaTune="y"
			InstallIoncube="n"
			InstallMCP="n"
			LicenseReq="n"
			shift
			;;
		-upgradeonlywowza)
				echo "Setup Config: Upgrade Wowza Media Server";
				UpgrWowza="y"	
				UpgradeMCP="n"
				
				InstallPreReq="n"
				InstallIcecast="n"
				InstallIces="n"
				InstallSTV3="n"
				InstallWowza="n"
				ConfigWowza="n"
				#WowzaTune="y"
				InstallIoncube="n"
				InstallMCP="n"
				LicenseReq="n"				

			shift
			;;	
		-uninstall)
			echo "Setup Config: Uninstall MCP..";
			UninstallMCP="y"
			UninstMCP
			shift
			;;
			
		-nobackup)
			#echo "Setup Config: No Upgrade Backup";
			UpgradeMCPBackup="n"
			shift
			;;
			
		-custom)
			echo "Setup Config: Custom Installation..";
			echo "Please select the items you would like to install."
			echo ""
			echo "Prerequisites? (y/n)"
			read InstallPreReq
			echo "Icecast 2? (y/n)"
			read InstallIcecast
			echo "Icecast 2 KH? (y/n)"
			read InstallIcecastKH
			echo "Ices? (y/n)"
			read InstallIces
			echo "Stream Transcoder V3? (y/n)"
			read InstallSTV3
			echo "Wowza Media Server? (y/n)"
			read InstallWowza
			echo "Configure Wowza Media Server? (y/n)"
			read ConfigWowza

			if [ "$InstallWowza" == "y" -o "$ConfigWowza" == "y" ]; then
				echo "Please enter your Wowza Media Server License to continue";
				read WowzaMediaLicense
				
				echo "Please enter a new password for Wowza Media Server Administration";
				read WowzaMediaAdminPass
				
				echo "Please enter a dedicated IP address for Wowza Media Server"
				echo "Leave blank and press Enter to bind on all addresses"
				echo ""
				echo "** This MUST be the same IP address as configured in MediaCP."
				read WowzaMediaIPAddress
			fi
			
			echo "Upgrade Wowza Media Server? (y/n)"
			read UpgrWowza
			
			echo "Tune Wowza Media Server?"
			read WowzaTune
			
			echo "Install FFMPEG? (y/n)"
			read InstallFFMPEG
			
			echo "Ioncube? (y/n)"
			read InstallIoncube
			echo "RRDTools? (y/n)"
			read InstallRRDTool
			echo "MediaCP? (y/n)"
			read InstallMCP
			
			
			LicenseReq="n"
			Unattended="true"
			shift
			;;	
	esac
done


## Remove TMP directory
rm -rf /root/CastControlTMP;

# Request License Key
if [ "$LicenseReq" == "y" ]; then
	DetermineProductType
fi

if [ "$InstallPreReq" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Installing System Prerequisites"
	echo "---------------------------------------------------------"
	InstPreRequisites
fi

if [ "$InstallIcecast" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Installing Icecast 2"
	echo "---------------------------------------------------------"
	InstIceCast
fi
if [ "$InstallIcecastKH" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Installing Icecast KH"
	echo "---------------------------------------------------------"
	InstIceCastKH
fi

if [ "$InstallIces" == "y" ]; then
	
	echo "---------------------------------------------------------"
	echo "Installing Ices 0.4 and Ices 2.0"
	echo "---------------------------------------------------------"
	InstLibShout
	InstLame
	InstFaac
	InstFaad
	InstFlac
	InstIces04
	InstIces2
fi

if [ "$InstallSTV3" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Installing Stream Transcoder"
	echo "---------------------------------------------------------"
	InstMad
	InstLameFix 
	InstStreamTransCoder
fi

if [ "$InstallWowza" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Installing Wowza Media"
	echo "---------------------------------------------------------"
	InstWowza
fi

if [ "$ConfigWowza" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Configuring Wowza Media"
	echo "---------------------------------------------------------"
	ConfWowza
fi

if [ "$UpgrWowza" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Upgrading Wowza Media"
	echo "---------------------------------------------------------"
	UpgradeWowza
fi

if [ "$WowzaTune" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Tuning Wowza Media"
	echo "---------------------------------------------------------"
	TuneWowza
fi


if [ "$InstallFFMPEG" == "y" ]; then

	echo "---------------------------------------------------------"
	echo "Installing FFMPEG"
	echo "---------------------------------------------------------"
	InstFFMPEG
fi

if [ "$InstallIoncube" == "y" ]; then

	echo "---------------------------------------------------------"
	echo "Installing Ioncube Loaders"
	echo "---------------------------------------------------------"
	CheckIoncube
fi

if [ "$InstallRRDTool" == "y" ]; then

	echo "---------------------------------------------------------"
	echo "Installing RRDTool"
	echo "---------------------------------------------------------"
	InstRRDTools
fi

if [ "$InstallMCP" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Installing MediaCP Software"
	echo "---------------------------------------------------------"
	InstMediaCP
fi
if [ "$UpgradeMCP" == "y" ]; then
	echo "---------------------------------------------------------"
	echo "Upgrading MediaCP Software"
	echo "---------------------------------------------------------"
	InstallMCPUpgrade
fi


# Automatically Fix Bug Created in regards to PHP display_errors = 20M
FixPHPDisplayErrors


echo "Cleaning Up Installation...";
rm -rf /root/CastControlTMP/;
#rm -rf /root/mcp.*.log
#echo "->Done";

#echo "_COMPLETE_" 
echo "Installation is completed."