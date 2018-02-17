PLUGIN.name = "Fallout UI Kit"
PLUGIN.author = "Muse"
PLUGIN.desc = "This adds a development ui kit."

if CLIENT then
	function rgb(r,g,b) // This is so you can copy rgb vectors from websites like flatuicolors.com
		return Color(r/255,g/255,b/255)
	end
	
	surface.CreateFont( "roboto", {
		font = "Roboto Bold", 
		extended = false,
		size = 25,
		weight = 700,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont( "roboton", {
		font = "Roboto", 
		extended = false,
		size = 19,
		weight = 700,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont( "robotoBig", {
		font = "Roboto Bold", 
		extended = false,
		size = 36,
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont( "robotoBig2", {
		font = "Roboto Bold", 
		extended = false,
		size = 150,
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	
	// This HUDPaint function is because I couldn't get the title to render outside of the panel.
	// So, I set a var to the player with the panel object and badabing badaboom.
	// This is probably not a good way to do this, im just a retard with UI.
	hook.Add("HUDPaint", "SomeSuperCoolTitleThink", function()
		local ply = LocalPlayer()
		if IsValid(ply.FormObj) then
			local obj = ply.FormObj
			if !(obj.Title) then obj.Title = "{FORM_TITLE}" end
			local objX,objY = obj:GetPos()
			local objW,objH = obj:GetSize()
			draw.SimpleText(obj.Title, "roboto", objX+45+2,objY-8+2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(obj.Title, "roboto", objX+45,objY-8, Color( 25, 250, 25, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			surface.SetDrawColor( 255, 255, 255, 55 )
		end
	end)
	
	function CreateFalloutCloseButton(obj)
		local fW,fH = obj:GetSize()
		local buttonClose = vgui.Create( "DButton", obj )
		buttonClose:SetText( "X" )
		buttonClose:SetPos( fW-35-5, 5 )
		buttonClose:SetSize( 35, 35 )
		buttonClose:SetFont("robotoBig")
		buttonClose:SetMouseInputEnabled(true)
		buttonClose:SetTextColor(Color( 25, 250, 25, 255 ))
		buttonClose.DoClick = function()
			obj:Remove()
		end
		buttonClose.Paint = function( self, w, h )
			if self:IsHovered() then
				self:SetTextColor(Color( 0, 0, 4, 255 ))
				draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 250, 25, 255 ))
			else
				self:SetTextColor(Color( 25, 250, 25, 255 ))
			end
		end
	end

	function CreateHighlightPanel(obj,w,h,id,f)
		local hlp = vgui.Create("DPanel", obj)
		hlp:SetSize(w,h)
		hlp:SetMouseInputEnabled(true)
		hlp.Paint = function( self, w, h )
			if self:IsHovered() or (f.selected == id) or (self.HoveringTextEntry == true) then
				draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 250, 25, 255 ))
			end
		end
		return hlp
	end


	function SetFalloutTheme(obj)
		obj.Paint = function( self, w, h )
			if !(obj.Title) then obj.Title = "{FORM_TITLE}" end
			surface.SetFont( "roboto" )
			local tW,tH = surface.GetTextSize( obj.Title )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 44, 75, 33, 220 ) )
			draw.RoundedBox( 0, 0, 0+2, 35, 3, Color( 0, 0, 0, 255 ) )
			if tW < w then
				draw.RoundedBox( 0, tW+35+10+10, 0+2, w, 3, Color( 0, 0, 0, 255 ) )
			else
				draw.RoundedBox( 0, 0, 0+2, w, 3, Color( 0, 0, 0, 255 ) )
			end
			draw.RoundedBox( 0, 0, 3+2, 3, 10, Color( 0, 0, 0, 255 ) )
			draw.RoundedBox( 0, w-3, 3+2, 3, 10, Color( 0, 0, 0, 255 ) )
			draw.RoundedBox( 0, 0, 0, 35, 3, Color( 25, 250, 25, 255 ) )
			if tW < w then
				draw.RoundedBox( 0, tW+35+10+10, 0, w, 3, Color( 25, 250, 25, 255 ) )
			else
				draw.RoundedBox( 0, 0, 0, w, 3, Color( 25, 250, 25, 255 ) )
			end
			draw.RoundedBox( 0, 0, 3, 3, 10, Color( 25, 250, 25, 255 ) )
			draw.RoundedBox( 0, w-3, 3, 3, 10, Color( 25, 250, 25, 255 ) )
			draw.RoundedBox( 0, 0, h-3, w, 3, Color( 0, 0, 0, 255 ) )
			draw.RoundedBox( 0, 0, h-13, 3, 10, Color( 0, 0, 0, 255 ) )
			draw.RoundedBox( 0, w-3, h-13, 3, 10, Color( 0, 0, 0, 255 ) )
			draw.RoundedBox( 0, 0, h-3-2, w, 3, Color( 25, 250, 25, 255 ) )
			draw.RoundedBox( 0, 0, h-13-2, 3, 10, Color( 25, 250, 25, 255 ) )
			draw.RoundedBox( 0, w-3, h-13-2, 3, 10, Color( 25, 250, 25, 255 ) )
		end
		obj.Think = function()
			local ply = LocalPlayer()
			ply.FormObj = obj
		end
	end

	function AlfNum(str) // This removes all unsafe characters from strings.
		str = str:gsub('%W','')
		return str
	end

	function AlfNumLow(str) // same as above, but lower case.
		str = str:gsub('%W','')
		return string.lower(str)
	end

	function GenerateView(Panel) // I don't know where I got this, but I know I didn't make it - Thanks mysterious facepunch guy!
		local PrevMins, PrevMaxs = Panel.Entity:GetRenderBounds()
		Panel:SetCamPos(PrevMins:Distance(PrevMaxs)*Vector(0.75, 0.75, 0.5))
		Panel:SetLookAt((PrevMaxs + PrevMins)/2)
	end
	
end
