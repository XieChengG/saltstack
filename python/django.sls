include:
  - python.python-libs

django:
  pkg.installed:
    - require:
      - pkg: python-dateutil
