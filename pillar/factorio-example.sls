factorio_release: https://www.factorio.com/get-download/stable/headless/linux64
factorio_tmp: /tmp/factorio_headless.tar.xz
factorio_dir: /opt/factorio
factorio_savefile: {{ pillar['factorio_dir'] }}/saves/latest.zip
factorio_server_settings: {{ pillar['factorio_dir'] }}/data/server-settings.json

factorio_rcon_password: your-rcon-password 
factorio_rcon_port: 27015 

factorio_game_password: your-game-password 