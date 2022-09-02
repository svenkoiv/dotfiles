-- Aes
function _G.token_aes()
  os.execute("node /home/skoiv/scripts/cyber/auth/index.js --tokenUrl http://localhost:8087/aes/official --envPath /home/skoiv/projects/aes/aes-ui/.env")
  os.execute("pm2 restart aes")
  return true
end

function _G.translate_aes()
  os.execute("lua /home/skoiv/scripts/cyber/translate.lua /home/skoiv/projects/aes/translations/translations.ui.json | jq -S | xclip -sel clip")
  return true
end

-- Impulss
function _G.token_impulss()
  os.execute("node /home/skoiv/scripts/cyber/auth/index.js --tokenUrl http://localhost:8080/impulss/official --envPath /home/skoiv/projects/impulss/reactui/ui/.env")
  os.execute("pm2 restart impulss")
  return true
end

function _G.translate_impulss()
  os.execute("lua /home/skoiv/scripts/cyber/translate.lua /home/skoiv/projects/impulss/translations/translations.json | jq -S | xclip -sel clip")
  return true
end

-- Ncts
function _G.token_nctsp5()
  os.execute("node /home/skoiv/scripts/cyber/auth/index.js --tokenUrl http://localhost:8081/nctsp5/official/departure --envPath /home/skoiv/projects/nctsp5/nctsp5-ui/.env")
  os.execute("pm2 restart nctsp5")
  return true
end

function _G.translate_nctsp5()
  os.execute("lua /home/skoiv/scripts/cyber/translate.lua /home/skoiv/projects/nctsp5/translations/translations.ui.json | jq -S | xclip -sel clip")
  return true
end
