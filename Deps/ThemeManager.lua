-- [[ FROM LINORIA! ]] --

local cloneref = cloneref or function(o) return o end
local HttpService = cloneref(game:GetService('HttpService'))
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local getassetfunc = getcustomasset or getsynasset

local ThemeManager = {} do
	ThemeManager.Folder = 'temple software'
	-- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end

	ThemeManager.Library = nil
	ThemeManager.BuiltInThemes = {
		["Default"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"1b1b1b",
				"AccentColor":"63b9ff",
				"BackgroundColor":"1a1a1a",
				"OutlineColor":"252525",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"63b9ff",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Tokyo Night"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"191925",
				"AccentColor":"6956cb",
				"BackgroundColor":"15151e",
				"OutlineColor":"272727",
				"RiskColor":"fb5f5f",

				"ItemType":"Sword",
				"SwordColor":"6956cb",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Nord"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"1c1e20",
				"AccentColor":"9effc8",
				"BackgroundColor":"1c1e20",
				"OutlineColor":"24282d",
				"RiskColor":"ff7a00",

				"ItemType":"Sword",
				"SwordColor":"ffffff",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Skeet"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"131313",
				"AccentColor":"81ff54",
				"BackgroundColor":"151515",
				"OutlineColor":"2a2a2a",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"81ff54",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Fatality"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"181537",
				"AccentColor":"ca0756",
				"BackgroundColor":"201c46",
				"OutlineColor":"39335a",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"ca0756",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Neverlose"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"0c1014",
				"AccentColor":"01a3f1",
				"BackgroundColor":"0c0f14",
				"OutlineColor":"191919",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"01a3f1",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Onetap"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"1e1d22",
				"AccentColor":"faa614",
				"BackgroundColor":"18181c",
				"OutlineColor":"313033",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"faa614",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Imgui"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"151617",
				"AccentColor":"406ba8",
				"BackgroundColor":"151617",
				"OutlineColor":"242424",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"406ba8",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Iniuria"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"1e1d1e",
				"AccentColor":"c41275",
				"BackgroundColor":"1e1d1e",
				"OutlineColor":"33252b",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"c41275",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Primordial"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"181818",
				"AccentColor":"d7a6b0",
				"BackgroundColor":"1f1f1f",
				"OutlineColor":"2a2a2a",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"d7a6b0",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Monolith"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"141115",
				"AccentColor":"c707bd",
				"BackgroundColor":"171417",
				"OutlineColor":"272427",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"c707bd",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Priv9"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"1f4e60",
				"AccentColor":"235f5f",
				"BackgroundColor":"174556",
				"OutlineColor":"245673",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"5fe0bd",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["V3rmillion"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"202020",
				"AccentColor":"cd1818",
				"BackgroundColor":"202020",
				"OutlineColor":"2a2a2a",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"cd1818",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},

		["Dark"] = { 1, HttpService:JSONDecode(
			[[{
				"FontColor":"ffffff",
				"MainColor":"0a0a0a",
				"AccentColor":"5945ff",
				"BackgroundColor":"0a0a0a",
				"OutlineColor":"171717",
				"RiskColor":"e50000",

				"ItemType":"Sword",
				"SwordColor":"5945ff",
				"SwordTransparency":"0",
				"SwordReflectance":"0",
				"SwordSpeed":"0.15",
				"SwordMaterial":"Neon",

				"Contrast":"0",
				"Saturation":"0",
				"Brightness":"0",


				"BackColor":"000000",
				"BlurSize":"15",
				"BackTransparency":"0.7"
			}]]
		)},
	
	}
	
	function ThemeManager:ApplyTheme(theme)
		local customThemeData = self:GetCustomTheme(theme)
		local data = customThemeData or self.BuiltInThemes[theme]

		if not data then return end

		-- custom themes are just regular dictionaries instead of an array with { index, dictionary }
		if self.Library.InnerVideoBackground ~= nil then
			self.Library.InnerVideoBackground.Visible = false
		end
		
		local scheme = data[2]
		for idx, col in next, customThemeData or scheme do
			if idx:find("Color") then
				self.Library[idx] = Color3.fromHex(col)
				
				if getgenv().Temple.Options[idx] then
					getgenv().Temple.Options[idx]:SetValueRGB(Color3.fromHex(col))
				end
			else
				self.Library[idx] = col
				
				if getgenv().Temple.Options[idx] then
					getgenv().Temple.Options[idx]:SetValue(col)
				end
			end
		end

		self:ThemeUpdate()
	end

	function ThemeManager:ThemeUpdate()
		-- This allows us to force apply themes without loading the themes tab :)
		if self.Library.InnerVideoBackground ~= nil then
			self.Library.InnerVideoBackground.Visible = false
		end
		
		local options = {"Contrast", "Saturation", "Brightness", "BlurSize", "FontColor", "RiskColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "SwordColor", "ItemType", "BackTransparency", "BackColor", "SwordTransparency", "SwordReflectance", "SwordMaterial", "SwordSpeed"}
		for i, field in next, options do
			if getgenv().Temple.Options and getgenv().Temple.Options[field] then
				self.Library[field] = getgenv().Temple.Options[field].Value
			end
		end

		self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
		self.Library:UpdateColorsUsingRegistry()
	end

	function ThemeManager:LoadDefault()		
		local theme = 'Default'
		local content = isfile(self.Folder .. '/themes/default.tpl') and readfile(self.Folder .. '/themes/default.tpl')

		local isDefault = true
		if content then
			if self.BuiltInThemes[content] then
				theme = content
			elseif self:GetCustomTheme(content) then
				theme = content
				isDefault = false;
			end
		elseif self.BuiltInThemes[self.DefaultTheme] then
		theme = self.DefaultTheme
		end

		if isDefault then
			getgenv().Temple.Options.ThemeManager_ThemeList:SetValue(theme)
		else
			self:ApplyTheme(theme)
		end
	end

	function ThemeManager:SaveDefault(theme)
		writefile(self.Folder .. '/themes/default.tpl', theme)
	end

	function ThemeManager:Delete(name)
		if (not name) then
			return false, 'no config file is selected'
		end
		
		local file = self.Folder .. '/themes/' .. name .. '.tmpl'
		if not isfile(file) then return false, 'invalid file' end

		local success, decoded = pcall(delfile, file)
		if not success then return false, 'delete file error' end
		
		return true
	end
	
	function ThemeManager:CreateThemeManager(groupbox)
		local GetMaterials = function()
			local Table = {}
			
			for _,v in Enum.Material:GetEnumItems() do
				table.insert(Table, v.Name)
				if v.Name == "ForceField" then
					break
				end
			end
	
			return Table
		end

		groupbox:AddLabel('Main Color')	:AddColorPicker('MainColor', { Default = self.Library.MainColor });
		groupbox:AddLabel('Accent Color'):AddColorPicker('AccentColor', { Default = self.Library.AccentColor });
		groupbox:AddLabel('Background Color'):AddColorPicker('BackgroundColor', { Default = self.Library.BackgroundColor });
		groupbox:AddLabel('Outline Color'):AddColorPicker('OutlineColor', { Default = self.Library.OutlineColor });
		groupbox:AddLabel('Text Color')	:AddColorPicker('FontColor', { Default = self.Library.FontColor });
		groupbox:AddLabel('Risk Text Color'):AddColorPicker('RiskColor', { Default = self.Library.RiskColor });
		groupbox:AddDivider()

		groupbox:AddDropdown('ItemType', {
			Values = {"None", "Sword", "Cross", "Catholic Cross", "Orthodox Cross", "Heart"},
			Default = "Sword",
			Multi = false,
			Text = "Item",
		})

		groupbox:AddLabel('Item Color'):AddColorPicker('SwordColor', { Default = self.Library.SwordColor });
		groupbox:AddSlider('SwordTransparency', { Text = 'Item Transparency', Default = 0, Min = 0, Max = 1, Rounding = 2});
		groupbox:AddSlider('SwordReflectance', { Text = 'Item Reflectance', Default = 0, Min = 0, Max = 1, Rounding = 2});
		groupbox:AddSlider('SwordSpeed', { Text = 'Item Speed', Default = 0.15, Min = 0, Max = 1.5, Rounding = 2});
		groupbox:AddDropdown('SwordMaterial', {
			Values = GetMaterials(),
			Default = "Neon",
			Multi = false,
			Text = "Item Material",
		})

		groupbox:AddDivider()

		groupbox:AddLabel('Back Color'):AddColorPicker('BackColor', { Default = self.Library.SwordColor });
		groupbox:AddSlider('BackTransparency', { Text = 'Back Transparency', Default = 0.7, Min = 0, Max = 1, Rounding = 2});
		groupbox:AddSlider('BlurSize', { Text = 'Back Blur', Default = 15, Min = 0, Max = 20, Rounding = 0});

		groupbox:AddSlider('Contrast', { Text = 'Back Contrast', Default = 0, Min = -20, Max = 20, Rounding = 2});
		groupbox:AddSlider('Saturation', { Text = 'Back Saturation', Default = 0, Min = -10, Max = 10, Rounding = 2});
		groupbox:AddSlider('Brightness', { Text = 'Back Brightness', Default = 0, Min = -1, Max = 1, Rounding = 2});

		local ThemesArray = {}
		for Name, Theme in next, self.BuiltInThemes do
			table.insert(ThemesArray, Name)
		end

		table.sort(ThemesArray, function(a, b) return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1] end)

		groupbox:AddDivider()

		groupbox:AddDropdown('ThemeManager_ThemeList', { Text = 'Theme list', Values = ThemesArray, Default = 1 })
		groupbox:AddButton('Set Default', function()
			self:SaveDefault(getgenv().Temple.Options.ThemeManager_ThemeList.Value)
			self.Library:Notify(string.format('Set default theme to %q', getgenv().Temple.Options.ThemeManager_ThemeList.Value))
		end)

		getgenv().Temple.Options.ThemeManager_ThemeList:OnChanged(function()
			self:ApplyTheme(getgenv().Temple.Options.ThemeManager_ThemeList.Value)
		end)

		groupbox:AddDivider()

		groupbox:AddInput('ThemeManager_CustomThemeName', { Text = 'Custom theme name' })
		groupbox:AddButton('Create theme', function() 
			self:SaveCustomTheme(getgenv().Temple.Options.ThemeManager_CustomThemeName.Value)

			getgenv().Temple.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			getgenv().Temple.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		groupbox:AddDivider()

		groupbox:AddDropdown('ThemeManager_CustomThemeList', { Text = 'Custom themes', Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 })
		groupbox:AddButton('Load theme', function() 
			self:ApplyTheme(getgenv().Temple.Options.ThemeManager_CustomThemeList.Value) 
		end)

		groupbox:AddButton('Overwrite Theme', function()
			self:SaveCustomTheme(getgenv().Temple.Options.ThemeManager_CustomThemeName.Value)
		end):AddButton('Delete Theme', function()
			local name = getgenv().Temple.Options.ThemeManager_CustomThemeName.Value

			local success, err = self:Delete(name)
			if not success then
				return self.Library:Notify('Failed to delete theme: ' .. err)
			end

			self.Library:Notify(string.format('Deleted theme %q', name))
			getgenv().Temple.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			getgenv().Temple.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		groupbox:AddButton('Set Default', function()
			if getgenv().Temple.Options.ThemeManager_CustomThemeList.Value ~= nil and getgenv().Temple.Options.ThemeManager_CustomThemeList.Value ~= '' then
				self:SaveDefault(getgenv().Temple.Options.ThemeManager_CustomThemeList.Value)
				self.Library:Notify(string.format('Set default theme to %q', getgenv().Temple.Options.ThemeManager_CustomThemeList.Value))
			end
		end):AddButton('Reset Default', function()
			local success = pcall(delfile, self.Folder .. '/themes/default.tpl')
			if not success then 
				return self.Library:Notify('Failed to reset default: delete file error')
			end
				
			self.Library:Notify('Set default theme to nothing')
			getgenv().Temple.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			getgenv().Temple.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		groupbox:AddButton('Refresh', function()
			getgenv().Temple.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			getgenv().Temple.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		ThemeManager:LoadDefault()

		local function UpdateTheme()
			self:ThemeUpdate()
		end

		getgenv().Temple.Options.BackgroundColor:OnChanged(UpdateTheme)
		getgenv().Temple.Options.MainColor:OnChanged(UpdateTheme)
		getgenv().Temple.Options.AccentColor:OnChanged(UpdateTheme)
		getgenv().Temple.Options.OutlineColor:OnChanged(UpdateTheme)
		getgenv().Temple.Options.FontColor:OnChanged(UpdateTheme)
		getgenv().Temple.Options.RiskColor:OnChanged(UpdateTheme)

		getgenv().Temple.Options.ItemType:OnChanged(UpdateTheme)
		getgenv().Temple.Options.SwordColor:OnChanged(UpdateTheme)
		getgenv().Temple.Options.SwordTransparency:OnChanged(UpdateTheme)
		getgenv().Temple.Options.SwordReflectance:OnChanged(UpdateTheme)
		getgenv().Temple.Options.SwordSpeed:OnChanged(UpdateTheme)
		getgenv().Temple.Options.SwordMaterial:OnChanged(UpdateTheme)

		getgenv().Temple.Options.BlurSize:OnChanged(UpdateTheme)
		getgenv().Temple.Options.Contrast:OnChanged(UpdateTheme)
		getgenv().Temple.Options.Saturation:OnChanged(UpdateTheme)
		getgenv().Temple.Options.Brightness:OnChanged(UpdateTheme)

		getgenv().Temple.Options.BackColor:OnChanged(UpdateTheme)
		getgenv().Temple.Options.BackTransparency:OnChanged(UpdateTheme)
	end

	function ThemeManager:GetCustomTheme(file)
		local path = self.Folder .. '/themes/' .. file
		if not isfile(path) then
			return nil
		end

		local data = readfile(path)
		local success, decoded = pcall(HttpService.JSONDecode, HttpService, data)
		
		if not success then
			return nil
		end

		return decoded
	end

	function ThemeManager:SaveCustomTheme(file)
		if file:gsub(' ', '') == '' then
			return self.Library:Notify('Invalid file name for theme (empty)', 3)
		end

		local theme = {}
		local fields = {"Contrast", "Saturation", "Brightness", "BlurSize", "FontColor", "RiskColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "ItemType", "SwordColor", "BackTransparency", "BackColor", "SwordTransparency", "SwordReflectance", "SwordMaterial", "SwordSpeed"}

		for _, field in next, fields do
			if not field:find("Color") then
				theme[field] = getgenv().Temple.Options[field].Value
			else
				theme[field] = getgenv().Temple.Options[field].Value:ToHex()
			end
		end

		writefile(self.Folder .. '/themes/' .. file .. '.tmpl', HttpService:JSONEncode(theme))
	end

	function ThemeManager:ReloadCustomThemes()
		local list = listfiles(self.Folder .. '/themes')

		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == '.tmpl' then
				-- i hate this but it has to be done ...

				local pos = file:find('.tmpl', 1, true)
				local char = file:sub(pos, pos)

				while char ~= '/' and char ~= '\\' and char ~= '' do
					pos = pos - 1
					char = file:sub(pos, pos)
				end

				if char == '/' or char == '\\' then
					table.insert(out, file:sub(pos + 1))
				end
			end
		end

		return out
	end

	function ThemeManager:SetLibrary(lib)
		self.Library = lib
	end

	function ThemeManager:BuildFolderTree()
		local paths = {}

		-- build the entire tree if a path is like some-hub/phantom-forces
		-- makefolder builds the entire tree on Synapse X but not other exploits

		local parts = self.Folder:split('/')
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, '/', 1, idx)
		end

		table.insert(paths, self.Folder .. '/themes')

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function ThemeManager:SetFolder(folder)
		self.Folder = folder
		self:BuildFolderTree()
	end

	function ThemeManager:CreateGroupBox(tab)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		return tab:AddLeftGroupbox('Themes')
	end

	function ThemeManager:ApplyToTab(tab)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		local groupbox = self:CreateGroupBox(tab)
		self:CreateThemeManager(groupbox)
	end

	function ThemeManager:ApplyToGroupbox(groupbox)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		self:CreateThemeManager(groupbox)
	end

	ThemeManager:BuildFolderTree()
end

return ThemeManager
