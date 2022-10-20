-- Aes
function token_aes()
  os.execute("node /home/skoiv/scripts/cyber/auth/index.js --tokenUrl http://localhost:8087/aes/official --envPath /home/skoiv/projects/aes/aes-ui/.env")
  os.execute("pm2 restart aes")
end

function translate_aes()
  os.execute("lua /home/skoiv/scripts/cyber/translate.lua /home/skoiv/projects/aes/translations/translations.ui.json | jq -S | xclip -sel clip")
end

-- Impulss
function token_impulss()
  os.execute("node /home/skoiv/scripts/cyber/auth/index.js --tokenUrl http://localhost:8080/impulss/official --envPath /home/skoiv/projects/impulss/reactui/ui/.env")
  os.execute("pm2 restart impulss")
end

function translate_impulss()
  os.execute("lua /home/skoiv/scripts/cyber/translate.lua /home/skoiv/projects/impulss/translations/translations.json | jq -S | xclip -sel clip")
end

-- Ncts
function token_nctsp5()
  os.execute("node /home/skoiv/scripts/cyber/auth/index.js --tokenUrl http://localhost:8081/nctsp5/official/departure --envPath /home/skoiv/projects/nctsp5/nctsp5-ui/.env")
  os.execute("pm2 restart nctsp5")
end

function translate_nctsp5()
  os.execute("lua /home/skoiv/scripts/cyber/translate.lua /home/skoiv/projects/nctsp5/translations/translations.ui.json | jq -S | xclip -sel clip")
end

function get_project_name()
  output = io.popen("git config --local remote.origin.url|sed -n 's#.*/\\([^.]*\\)\\.git#\\1#p'")
  project_name = output:read()
  output:close()
  return project_name
end

function translate_according_to_project()
  project_name = get_project_name()
  if project_name == 'aes'
  then
    translate_aes()
  elseif project_name == 'nctsp5' then
    translate_nctsp5()
  elseif project_name == 'impulss' then
    translate_impulss()
  else
    error("Translate: not supported for '" .. project_name .. "'")
  end
end

function token_according_to_project()
  project_name = get_project_name()
  if project_name == 'aes'
  then
    token_aes()
  elseif project_name == 'nctsp5' then
    token_nctsp5()
  elseif project_name == 'impulss' then
    token_impulss()
  else
    error("Token: not supported for '" .. project_name .. "'")
  end
end


vim.api.nvim_create_user_command('Token', token_according_to_project, {})
vim.api.nvim_create_user_command('Translate', translate_according_to_project, {})
