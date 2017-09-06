#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/env.conf
rm -rf ${basepath}/tomcat/emm/*
mkdir -p ${basepath}/logs
chmod -R 777 ${basepath}/logs

function install_emmweb()
{
	if [[ ${EMM_WEB_SERVER} == 1 ]]; then
		#mkdir -vp ${basepath}/tomcat/emm/{baas,emm,mam,mcm,mdm,mem,mum,pcstore,publish,sso}
		if [ -f ${basepath}/resource/baas-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/baas
			cd ${basepath}/tomcat/emm/baas
			jar -xf ${basepath}/resource/baas-*.war
		fi

		if [ -f ${basepath}/resource/emm-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/emm
			cd ${basepath}/tomcat/emm/emm
			jar -xf ${basepath}/resource/emm-*.war
		fi

		if [ -f ${basepath}/resource/mam-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/mam
			cd ${basepath}/tomcat/emm/mam
			jar -xf ${basepath}/resource/mam-*.war
		fi
		
		if [ -f ${basepath}/resource/mcm-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/mcm
			cd ${basepath}/tomcat/emm/mcm
			jar -xf ${basepath}/resource/mcm-*.war
		fi
		
		if [ -f ${basepath}/resource/mdm-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/mdm
			cd ${basepath}/tomcat/emm/mdm
			jar -xf ${basepath}/resource/mdm-*.war
		fi
		
		if [ -f ${basepath}/resource/mem-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/mem
			cd ${basepath}/tomcat/emm/mem
			jar -xf ${basepath}/resource/mem-*.war
		fi
		
		if [ -f ${basepath}/resource/mum-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/mum
			cd ${basepath}/tomcat/emm/mum
			jar -xf ${basepath}/resource/mum-*.war
		fi
		
		if [ -f ${basepath}/resource/pcstore-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/pcstore
			cd ${basepath}/tomcat/emm/pcstore
			jar -xf ${basepath}/resource/pcstore-*.war
		fi
		
		if [ -f ${basepath}/resource/publish-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/publish
			cd ${basepath}/tomcat/emm/publish
			jar -xf ${basepath}/resource/publish*.war
		fi
		
		if [ -f ${basepath}/resource/*sso*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/sso
			cd ${basepath}/tomcat/emm/sso
			jar -xf ${basepath}/resource/*sso*.war
		fi
	fi
}

function install_emmin()
{
	if [[ ${EMM_IN_SERVER} == 1 ]]; then
		#mkdir -vp ${basepath}/tomcat/emm/{appIn,im,mcmIn,mdmIn,memIn,mumIn,storeIn,v4}
		if [ -f ${basepath}/resource/appIn-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/appIn
			cd ${basepath}/tomcat/emm/appIn
			jar -xf ${basepath}/resource/appIn-*.war
		fi
		
		if [ -f ${basepath}/resource/tigase-im*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/im
			cd ${basepath}/tomcat/emm/im
			jar -xf ${basepath}/resource/tigase-im*.war
		fi
		
		if [ -f ${basepath}/resource/mcmIn-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/mcmIn
			cd ${basepath}/tomcat/emm/mcmIn
			jar -xf ${basepath}/resource/mcmIn-*.war
		fi
		
		if [ -f ${basepath}/resource/mdmIn-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/mdmIn
			cd ${basepath}/tomcat/emm/mdmIn
			jar -xf ${basepath}/resource/mdmIn-*.war
		fi
		
		if [ -f ${basepath}/resource/memIn-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/memIn
			cd ${basepath}/tomcat/emm/memIn
			jar -xf ${basepath}/resource/memIn-*.war
		fi
		
		if [ -f ${basepath}/resource/mumIn-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/mumIn
			cd ${basepath}/tomcat/emm/mumIn
			jar -xf ${basepath}/resource/mumIn-*.war
		fi
		
		if [ -f ${basepath}/resource/storeIn-*.war ]; then
			mkdir -vp ${basepath}/tomcat/emm/storeIn
			cd ${basepath}/tomcat/emm/storeIn
			jar -xf ${basepath}/resource/storeIn-*.war
		fi
		
		if [ -f ${basepath}/resource/v4-*.war ]; then	
			mkdir -vp ${basepath}/tomcat/emm/v4	
			cd ${basepath}/tomcat/emm/v4
			jar -xf ${basepath}/resource/v4-*.war
		fi
	fi
}

function install_analyWeb()
{
	if [[ ${EMM_ANALYWEB_SERVER} == 1 ]]; then
		mkdir -vp ${basepath}/tomcat/emm/{analy,analyServer}

		cd ${basepath}/tomcat/emm/analy
		jar -xf ${basepath}/resource/analyWeb*.war

		cd ${basepath}/tomcat/emm/analyServer
		jar -xf ${basepath}/resource/analyServer*.war
	fi
}

function install_analyIn()
{
	if [[ ${EMM_ANALYIN_SERVER} == 1 ]]; then
		mkdir -vp ${basepath}/tomcat/emm/analyIn

		cd ${basepath}/tomcat/emm/analyIn
		jar -xf ${basepath}/resource/analyIn*.war
		if [ -f ${basepath}/resource/GeoLite2-City.mmdb ]; then
			\cp ${basepath}/resource/GeoLite2-City.mmdb ${basepath}/tomcat/emm/analyIn/WEB-INF/classes  
		fi
	fi
}

install_emmweb
install_emmin
install_analyWeb
install_analyIn
		
find ${basepath}/tomcat/emm/* -name mem.properties -exec rm {} \;
find ${basepath}/tomcat/emm/* -name mdm.properties -exec rm {} \;
find ${basepath}/tomcat/emm/* -name mcm.properties -exec rm {} \;
# ${basepath}/updatemam.sh
