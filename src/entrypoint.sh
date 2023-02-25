#!/bin/bash -e

clone_repos() {
  REPO_FILE=/git/git_server_repos
  [[ ! -f ${REPO_FILE} ]] && echo "repo file missing: ${REPO_FILE}" && exit 1
  echo "clone repositories"
  (
    cd /git/repos
    while IFS= read -r line; do
      if [[ "${line}" != "" ]]; then
        echo "Cloning repository: '${line}'"
        if [[ -d $(basename ${line}) ]]; then
          echo "repo already exists: '${line}'"
        else
          git clone --bare --recurse-submodules -j 4 ${line}
        fi
      fi
    done <${REPO_FILE}
  )
  echo "git server is seeded with the core projects"
}

init_git_server() {
  echo "initializing git server"
  [[ ! -d /git/.ssh ]] && mkdir /git/.ssh
  [[ ! -d /git/repos ]] && mkdir /git/repos

  rm -rf /git/git-shell-commands
  mv /root/git-shell-commands /git/
  chmod +x -R /git/git-shell-commands/*
    mv /root/git_server_repos /git/
  mv /root/gitconfig /git/.gitconfig
  mv /root/authorized_keys /git/.ssh/authorized_keys
  chown -R git:www-data /git
  clone_repos
  date >/git/ready
  echo "git server is initialized"
}

run_ssh_server() {
  service ssh start
}

start_nginx() {
  /usr/sbin/nginx
}

main(){
  init_git_server &
  run_ssh_server
  sleep 1
  echo "running..."
  start_nginx
}

main