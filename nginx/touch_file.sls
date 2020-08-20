touch files script:
  cmd.script:
    - name: test_script
    - source: salt://files/linux/test_script.sh
    - cwd: /tmp
    - env:
      - BATCH: 'yes'
