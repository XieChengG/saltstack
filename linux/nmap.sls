include:
  - nginx.install_pkg

extend:
  nginx:
    pkg:
      - name: nmap
      - installed
