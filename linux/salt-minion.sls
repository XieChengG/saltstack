repository file:
  file.managed:
    - name: /etc/yum.repos.d/salt-py3-latest.repo
    - source: salt://files/salt/salt-py3-latest.repo
    - user: root
    - group: root
    - mode: 644
    - backup: minion

install salt-minion:
  pkg.installed:
    - name: salt-minion
    - refresh: True
    - require:
      - file: repository file

configure minion:
  file.append:
    - name: /etc/salt/minion
    - text: |
        master: 10.0.0.10
    - require:
      - pkg: install salt-minion

start salt-minion:
  service.running:
    - name: salt-minion
    - enable: True
    - require:
      - pkg: install salt-minion
      - file: configure minion
