#!/bin/bash
export PATH=$PATH:/opt/docker_bin/
cd `dirname $0`
/opt/docker_bin/docker -H unix:///opt/docker_bin/run/docker.sock info >/dev/nul 2>&1
if [ "$?" != "0" ]
then
  docker info >/dev/nul 2>&1 
  if [ "$?" != "0" ]
  then
    echo "you must install docker and start it"
    exit 0
  else
    if [ `docker version |grep Version |head -1|awk '{print $2}'|sed "s/\.*//g"` -ge 19038 ]
    then
      echo "Environment detection succeeded"
    else
      echo "WARN: Your docker is below 19.03.8. It may cause deployment failure. It is recommended to upgrade to 19.03.8 and later"
    fi
  fi
fi

case "$1" in
    -h|--help|?)
    echo "Usage: 1st arg:config name, for example:hosts"
    echo "Usage: $0 hosts"
    exit 0
;;
esac

if [ ! -n "$1" ]; then
    echo "pls input 1st arg"
    echo "Usage: $0 -h|--help|?"
    exit
fi

case "$2" in
    -h|--help|?)
    echo "Usage: 1st arg:config name, for example:hosts"
    echo "Usage: 2st arg:install,delete,change"
    echo "Usage: $0 hosts install"
    exit 0
    ;;
    install)
    echo "start installation"
    ;;
    change)
    read -p "You will chage config and restart service , please confirm (yes) again: " input
    if [ $input == "yes" ];then
      echo "start change config and restart service"
    fi
    ;;
    delete)
    read -p "You will clear all data , please confirm (yes) again: " input
    if [ $input != "yes" ];then
      echo "error input,if you want clean all k8s data,pls input yes" && exit 1
    fi
    ;;
    *)
    echo "Usage: 1st arg:config name, for example:hosts"
    echo "Usage: 2st arg:install,delete,change"
    echo "Usage: $0 hosts install"
    exit 0
    ;;
esac

cd `dirname $0`

tty >/dev/nul
if [ "$?" -eq "0" ]
then
tty=t
else
tty=
fi

docker_basedir=`grep "docker_basedir" $1|awk -F = '{print $2}'`

docker run --network host --name ansible_${RANDOM} -e ANSIBLE_SSH_CONTROL_PATH=/dev/shm/ssh_ctl_%%h_%%p_%%r --rm -v /root/.ssh:/root/.ssh -v `pwd`:$docker_basedir -w $docker_basedir -i$tty congcong126/ansible:2.9.18 ansible-playbook -f 10 --ssh-common-args="$ANSIBLE_SSH_COMMON_ARGS" -i $1 app_install/test.yml --extra-vars "ins=$2"
