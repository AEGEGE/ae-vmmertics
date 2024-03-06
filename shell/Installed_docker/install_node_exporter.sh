#!/bin/bash
cd `dirname $0`
docker info >/dev/nul 2>&1
if [ "$?" != "0" ]
then
  echo -e "you must install docker and start it,\033[32m Usage: bash ./initialize_docker.sh hosts \033[0m"
  exit 0
else
  if [ `docker version |grep Version |head -1|awk '{print $2}'|sed "s/\.*//g"` -ge 19038 ]
  then
    echo "Environment detection succeeded"
  else
    echo "WARN: Your docker is below 19.03.8. It may cause deployment failure. It is recommended to upgrade to 19.03.8 and later"
  fi
fi

case "$1" in
    -h|--help|?)
    echo "Usage: 1st arg:vars_files name, for example:hosts"
    echo -e "if you want install, \033[32m Usage: $0 hosts \033[0m"
    echo -e "if you want delete, \033[31m Usage: $0 hosts delete \033[0m"
    exit 0
;;
esac

if [ ! -n "$1" ]; then
    echo "pls input 1st arg"
    echo "Usage: $0 -h|--help|?"
    exit 0
fi

tty >/dev/nul
if [ "$?" == "0" ]
then
tty=t
else
tty=
fi

docker run --network host --name ansible -e ANSIBLE_SSH_CONTROL_PATH=/dev/shm/ssh_ctl_%%h_%%p_%%r --rm -v /root/.ssh:/root/.ssh -v `pwd`:/bmsk -w /bmsk -i$tty ansible ansible-playbook -f 30 --ssh-common-args="$ANSIBLE_SSH_COMMON_ARGS" -i $1 app_install/node_exporter.yml --extra-vars "ins=$2"
