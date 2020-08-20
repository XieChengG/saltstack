docker-ce.repo:
  pkgrepo.managed:
    - name: docker-ce
    - humanname: Docker CE Stable - $basearch
    - baseurl: https://download.docker.com/linux/centos/7/$basearch/stable
    - enabled: 1
    - gpgcheck: 0

remove before install:
  pkg.removed:
    - pkgs:
      - docker
      - docker-client
      - docker-client-latest
      - docker-common
      - docker-latest
      - docker-latest-logrotate
      - docker-logrotate
      - docker-selinux
      - docker-engine-selinux
      - docker-engine

install docker-ce:
  pkg.installed:
    - pkgs:
      - yum-utils 
      - device-mapper-persistent-data 
      - lvm2
      - docker-ce
    - refresh: True
    - require:
      - pkgrepo: docker-ce.repo
      - pkg: remove before install

create config file:
  file.managed:
    - name: /etc/docker/daemon.json
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - creates: /etc/docker/daemon.json

configure daemon.json:
  file.append:
    - name: /etc/docker/daemon.json
    - text: |
        {
          "registry-mirrors": ["https://jkje2ckb.mirror.aliyuncs.com"]
        }
    - require:
      - pkg: install docker-ce

start docker:
  cmd.run:
    - name: systemctl daemon-reload
    - cwd: /root
    - require:
      - file: configure daemon.json

  service.running:
    - name: docker
    - enable: True
    - require:
      - file: configure daemon.json
