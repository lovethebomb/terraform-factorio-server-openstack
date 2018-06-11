copy service:
  file.managed:
    - name: /etc/systemd/system/factorio.service
    - source: salt://systemd/factorio.service
    - user: root 
    - group: root 
    - template: jinja

factorio:
  service.running: []