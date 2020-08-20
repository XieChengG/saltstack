{% set os_release = 'CentOS' %}

transmit file to minion:
  file.managed:
    - names:
      - /opt/nginx/conf/nginx.conf:
        - source: salt://files/nginx/nginx.conf
      - /opt/nginx/html/index.html:
        - source: salt://files/nginx/index.html
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - dir_mode: 766
    - template: jinja
    - defaults:
        os_release: {{ os_release }} 
{% if grains['os'] == 'Ubuntu' %}
    - context:
        os_release: 'Ubuntu'
{% endif %}

