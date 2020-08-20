Create directory on target system recursivly:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 744
    - file_mode: 600
    - makedirs: True
    - names:
      - /usr/local/src/nginx/conf/conf.d
      - /usr/local/src/mysql/data
      - /usr/local/src/redis/conf
    - recurse:
      - user
      - group
      - mode
