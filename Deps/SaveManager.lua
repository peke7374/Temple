local cloneref = cloneref or function(o) return o end
local httpService = cloneref(game:GetService('HttpService'))
local isfolder, isfile, listfiles = isfolder, isfile, listfiles

if typeof(copyfunction) == "function" then -- fix for shitsploits
	local isfolder_, isfile_, listfiles_ = copyfunction(isfolder), copyfunction(isfile), copyfunction(listfiles);
	local success_, error_ = pcall(function() return isfolder_(tostring(math.random(9999, 9999999))) end);

	if success_ == false or (tostring(error_):match("not") and tostring(error_):match("found")) then
		isfolder = function(folder)
			local success, data = pcall(isfolder_, folder)
			return (if success then data else false)
		end;
	
		isfile = function(file)
			local success, data = pcall(isfile_, file)
			return (if success then data else false)
		end;
	
		listfiles = function(folder)
			local success, data = pcall(listfiles_, folder)
			return (if success then data else {})
		end;
	end
end

local SaveManager = {} do
	SaveManager.Folder = 'temple software'
	SaveManager.Ignore = {}
	SaveManager.Parser = {
		Toggle = {
			Save = function(idx, object) 
				return { type = 'Toggle', idx = idx, value = object.Value } 
			end,
			Load = function(idx, data)
				if getgenv().Temple.Toggles[idx] then 
					getgenv().Temple.Toggles[idx]:SetValue(data.value)
				end
			end,
		},
		Slider = {
			Save = function(idx, object)
				return { type = 'Slider', idx = idx, value = tostring(object.Value) }
			end,
			Load = function(idx, data)
				if getgenv().Temple.Options[idx] then 
					getgenv().Temple.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Dropdown = {
			Save = function(idx, object)
				return { type = 'Dropdown', idx = idx, value = object.Value, mutli = object.Multi }
			end,
			Load = function(idx, data)
				if getgenv().Temple.Options[idx] then 
					getgenv().Temple.Options[idx]:SetValue(data.value)
				end
			end,
		},
		ColorPicker = {
			Save = function(idx, object)
				return { type = 'ColorPicker', idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
			end,
			Load = function(idx, data)
				if getgenv().Temple.Options[idx] then 
					getgenv().Temple.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
				end
			end,
		},
		KeyPicker = {
			Save = function(idx, object)
				return { type = 'KeyPicker', idx = idx, mode = object.Mode, key = object.Value }
			end,
			Load = function(idx, data)
				if getgenv().Temple.Options[idx] then 
					getgenv().Temple.Options[idx]:SetValue({ data.key, data.mode })
				end
			end,
		},

		Input = {
			Save = function(idx, object)
				return { type = 'Input', idx = idx, text = object.Value }
			end,
			Load = function(idx, data)
				if getgenv().Temple.Options[idx] and type(data.text) == 'string' then
					getgenv().Temple.Options[idx]:SetValue(data.text)
				end
			end,
		},
	}

	function SaveManager:BuildFolderTree()
		local paths = {
			self.Folder,
			self.Folder .. '/themes',
			self.Folder .. '/configs'
		}

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function SaveManager:CheckFolderTree()
		if not isfolder(self.Folder) then
			SaveManager:BuildFolderTree()
			task.wait()
		end
	end
	
	function SaveManager:SetIgnoreIndexes(list)
		for _, key in next, list do
			self.Ignore[key] = true
		end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	function SaveManager:Save(name)
		if (not name) then
			return false, 'no config file is selected'
		end
		SaveManager:CheckFolderTree()
		
		local fullPath = self.Folder .. '/configs/' .. name .. '.tcfg'
		local data = {
			objects = {}
		}

		for idx, toggle in next, getgenv().Temple.Toggles do
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
		end

		for idx, option in next, getgenv().Temple.Options do
			if not self.Parser[option.Type] then continue end
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		end	

		local success, encoded = pcall(httpService.JSONEncode, httpService, data)
		if not success then
			return false, 'failed to encode data'
		end

		writefile(fullPath, encoded)
		return true
	end

	function SaveManager:Load(name)
		if (not name) then
			return false, 'no config file is selected'
		end
		SaveManager:CheckFolderTree()
		
		local file = self.Folder .. '/configs/' .. name .. '.tcfg'
		if not isfile(file) then return false, 'invalid file' end

		local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
		if not success then return false, 'decode error' end

		for _, option in next, decoded.objects do
			if self.Parser[option.type] then
				task.spawn(function() self.Parser[option.type].Load(option.idx, option) end) -- task.spawn() so the config loading wont get stuck.
			end
		end

		return true
	end

	function SaveManager:Delete(name)
		if (not name) then
			return false, 'no config file is selected'
		end
		
		local file = self.Folder .. '/configs/' .. name .. '.tcfg'
		if not isfile(file) then return false, 'invalid file' end

		local success, decoded = pcall(delfile, file)
		if not success then return false, 'delete file error' end
		
		return true
	end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", -- themes
			"ThemeManager_ThemeList", 'ThemeManager_CustomThemeList', 'ThemeManager_CustomThemeName', -- themes
			"VideoLink",
		})
	end

	function SaveManager:RefreshConfigList()
		local success, data = pcall(function()
			SaveManager:CheckFolderTree()
			local list = listfiles(self.Folder .. '/configs')
	
			local out = {}
			for i = 1, #list do
				local file = list[i]
				if file:sub(-5) == '.tcfg' then
					-- i hate this but it has to be done ...
	
					local pos = file:find('.tcfg', 1, true)
					local start = pos
	
					local char = file:sub(pos, pos)
					while char ~= '/' and char ~= '\\' and char ~= '' do
						pos = pos - 1
						char = file:sub(pos, pos)
					end
	
					if char == '/' or char == '\\' then
						table.insert(out, file:sub(pos + 1, start - 1))
					end
				end
			end
			return out
		end)

		if (not success) then
			if self.Library then self.Library:Notify('Failed to load config list: ' .. tostring(data)) end
			return {}
		end
					
		return data
	end

	function SaveManager:SetLibrary(library)
		self.Library = library
	end

	function SaveManager:LoadAutoloadConfig()
		SaveManager:CheckFolderTree()
		
		if isfile(self.Folder .. '/configs/autoload.txt') then
			local name = readfile(self.Folder .. '/configs/autoload.txt')

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify('Failed to load autoload config: ' .. err)
			end

			self.Library:Notify(string.format('Auto loaded config %q', name))
		end
	end

	function SaveManager:BuildConfigSection(tab)
		assert(self.Library, 'Must set SaveManager.Library')

		local section = tab:AddRightGroupbox('Configuration')

		section:AddInput('SaveManager_ConfigName',    { Text = 'Config name' })
		section:AddButton('Create config', function()
			local name = getgenv().Temple.Options.SaveManager_ConfigName.Value

			if name:gsub(' ', '') == '' then 
				return self.Library:Notify('Invalid config name (empty)', 2)
			end

			local success, err = self:Save(name)
			if not success then
				return self.Library:Notify('Failed to create config: ' .. err)
			end

			self.Library:Notify(string.format('Created config %q', name))

			getgenv().Temple.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			getgenv().Temple.Options.SaveManager_ConfigList:SetValue(nil)
		end)

		section:AddDivider()

		section:AddDropdown('SaveManager_ConfigList', { Text = 'Config list', Values = self:RefreshConfigList(), AllowNull = true })
		section:AddButton('Load Config', function()
			local name = getgenv().Temple.Options.SaveManager_ConfigList.Value

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify('Failed to load config: ' .. err)
			end

			self.Library:Notify(string.format('Loaded config %q', name))
		end)
		section:AddButton('Overwrite Config', function()
			local name = getgenv().Temple.Options.SaveManager_ConfigList.Value

			local success, err = self:Save(name)
			if not success then
				return self.Library:Notify('Failed to overwrite config: ' .. err)
			end

			self.Library:Notify(string.format('Overwrote config %q', name))
		end):AddButton('Delete Config', function()
			local name = getgenv().Temple.Options.SaveManager_ConfigList.Value

			local success, err = self:Delete(name)
			if not success then
				return self.Library:Notify('Failed to delete config: ' .. err)
			end

			self.Library:Notify(string.format('Deleted config %q', name))
			getgenv().Temple.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			getgenv().Temple.Options.SaveManager_ConfigList:SetValue(nil)
		end)

		section:AddButton('Set Autoload', function()
			local name = getgenv().Temple.Options.SaveManager_ConfigList.Value
			writefile(self.Folder .. '/configs/autoload.txt', name)
			SaveManager.AutoloadLabel:SetText('Current Auto Config: ' .. name)
			self.Library:Notify(string.format('Set %q to auto load', name))
		end):AddButton('Reset Autoload', function()
			local success = pcall(delfile, self.Folder .. '/configs/autoload.txt')
			if not success then 
				return self.Library:Notify('Failed to reset autoload: delete file error')
			end
				
			self.Library:Notify('Set autoload to none')
			SaveManager.AutoloadLabel:SetText('Current Auto Config: None')
		end)

		section:AddButton('Refresh', function()
			getgenv().Temple.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
			getgenv().Temple.Options.SaveManager_ConfigList:SetValue(nil)
		end)

		SaveManager.AutoloadLabel = section:AddLabel('Current Auto Config: None', true)

		if isfile(self.Folder .. '/configs/autoload.txt') then
			local name = readfile(self.Folder .. '/configs/autoload.txt')
			SaveManager.AutoloadLabel:SetText('Current autoload config: ' .. name)
		end

		SaveManager:SetIgnoreIndexes({ 'SaveManager_ConfigList', 'SaveManager_ConfigName' })
	end

	SaveManager:BuildFolderTree()
end

return SaveManager