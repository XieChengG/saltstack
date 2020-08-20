include:
  - nginx.install_pkg

extend:
  nginx:
    service.running:
      - require:
        - pkg: nginx

/usr/share/nginx/html/index.html:
  file.managed:
    - source: salt://files/nginx/index.html
    - require:
      - pkg: nginx
