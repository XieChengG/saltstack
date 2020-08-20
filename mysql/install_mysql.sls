repository file:
  file.managed:
    - name: /etc/yum.repos.d/mysql-community.repo
    - source: salt://files/mysql/mysql-community.repo
    - user: root
    - group: root
    - mode: 644
    - backup: minion

install mysql:
  pkg.installed:
    - name: mysql-community-server
    - version: 5.7*
    - refresh: True
    - fromrepo: mysql57-community
    - require:
      - file: repository file

start mysql:
  service.running:
    - name: mysqld
    - enable: True
    - reload: True
    - require:
      - pkg: install mysql

modify password and policy:
  cmd.script:
    - name: chg_pwd_mysql
    - source: salt://files/mysql/chg_pwd_mysql.sh
    - cwd: /root
    - env:
      - BATCH: 'yes'
