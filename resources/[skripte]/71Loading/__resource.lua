resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

files {
  'index.html',
  'music.mp3',
  '*.otf',
  '*.js'
}

loadscreen 'index.html'

loadscreen_manual_shutdown "yes"
client_script 'client.lua'