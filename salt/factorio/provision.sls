user factorio:
    user.present:
        - name: factorio
        - createhome: false
        - groups:
            - factorio 

retrieve factorio:
    cmd.run:
        - name: wget -q -O {{ pillar['factorio_tmp'] }} {{ pillar['factorio_release'] }}
        - creates: {{ pillar['factorio_tmp'] }}

install factorio:
    cmd.run:
        - name: tar -xf {{ pillar['factorio_tmp'] }} -C /opt
        - creates: /opt/factorio

/opt/factorio:
  file.directory:
    - user: factorio 
    - group: factorio 

copy server settings:
  file.managed:
    - name: {{ pillar['factorio_server_settings'] }}
    - source: salt://factorio/server-settings.json
    - user: factorio 
    - group: factorio
    - template: jinja