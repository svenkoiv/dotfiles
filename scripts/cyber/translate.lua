local cjson = require "cjson"

translationPath = arg[1];

function capture_command_output(cmd)
    local handle = assert(io.popen(cmd, 'r'))
    local output = assert(handle:read('*a'))
    
    handle:close()
   
    output = string.gsub(
        string.gsub(
            string.gsub(output, '^%s+', ''), 
            '%s+$', 
            ''
        ), 
        '[\n\r]+',
        ' '
    )
   
   return output
end

function find_translations()
	local grep_result = capture_command_output("git grep -Porh \"(?<=translate\\(')(\\w\\.?)*(?=')\" .")

	found_translations = {}
	for key,i in grep_result:gmatch("[^%s]+") do
		if (found_translations[key] == nil)
		then
			table.insert(found_translations, key)
		end
	end

	return found_translations
end

function translate()
	found_translations = find_translations()

	file = io.open('/home/skoiv/projects/impulss/translations/translations.json', "r")
	current_translations = cjson.decode(file:read("*all"))
	file:close()

	new_translations = {}
	for i, key in ipairs(found_translations) do
		if(current_translations[key] == nil)
		then
			new_translations[key] = {
				et = "",
				en = " (en)",
				ru = " (ru)"
			}
		end
	end

	print(cjson.encode(new_translations))
end


return translate()
