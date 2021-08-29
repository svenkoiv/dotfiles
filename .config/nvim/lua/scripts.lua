function _G.token_aes()
  os.execute("node /home/skoiv/cyber/impulss/auth/index.js --tokenUrl http://localhost:8087/aes/official --envPath /home/skoiv/projects/aes/aes-ui/.env")
  os.execute("pm2 restart aes")
  return true
end

function _G.translate_aes()
  os.execute("lua /home/skoiv/cyber/impulss/translate.lua /home/skoiv/projects/impulss/translations/translations-ui.json | jq | xclip -sel clip")
  return true
end

function _G.token_impulss()
  os.execute("node /home/skoiv/cyber/impulss/auth/index.js --tokenUrl http://localhost:8080/impulss/official --envPath /home/skoiv/projects/impulss/reactui/ui/.env")
  os.execute("pm2 restart impulss")
  return true
end

function _G.translate_impulss()
  os.execute("lua /home/skoiv/cyber/impulss/translate.lua /home/skoiv/projects/impulss/translations/translations.json | jq | xclip -sel clip")
  return true
end
