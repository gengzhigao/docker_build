#!/bin/bash
function lvm_create_test()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要创建测试LVM，如果能正常创建，则证明磁盘没问题*"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要为创建测试LVM:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			read -p "请输入需要创建LVM的磁盘或者分区名称(默认为/dev/sdb):" input
			if [ "$input" == "" ]; then
				input="/dev/sdb"
			fi
			
			# create VG
			diskpath=${input}
			A=`pvcreate ${diskpath}`
			if [ "${A}" == "" ]; then
				echo "${diskpath}该磁盘(分区)不存在，请使用fdisk -l命令检查后，重新输入："
				continue
			else
				# create VG
				vgcreate vg-test ${diskpath}

				# create LV
				read -p "请输入需要 dockerdata 逻辑卷的大小，输入的时候需要包含单位G(默认为1G):" input
				if [ "$input" == "" ]; then
					input=1G
				elif [[ ! $input =~ "g" ]] || [[ ! $input =~ "G" ]]; then
					input=${input}G;
				fi
				lvcreate -L ${input} -n testdata vg-test

				echo -e "\n\n********************LVM信息如下********************:"
				lsblk
				break
			fi
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break        
		fi
	done
}

function lvm_remove_test()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要删除测试LVM*"
	echo -e "**************************************************"
	while :
	do
		echo -e "********************现有LVM信息如下********************:"
		lsblk
		read -p "是否需要为删除测试LVM:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			read -p "请输入需要创建LVM的磁盘或者分区名称(默认为/dev/sdb):" input
			if [ "$input" == "" ]; then
				input="/dev/sdb"
			fi
			
			# create VG
			diskpath=${input}
			count=`pvs |grep ${diskpath} |wc -l`
			if [ ${count} -eq 0 ]; then
				echo "${diskpath} 该磁盘(分区)不存在，请使用fdisk -l命令检查后，重新输入："
				continue
			else
				# drop LV
				lvremove testdata

				# drop VG
				vgremove vg-test

				# drop PV
				pvremove ${diskpath}

				echo -e "\n\n********************清理之后LVM信息如下********************:"
				lsblk
				break
			fi
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break        
		fi
	done

}

lvm_create_test
lvm_remove_test