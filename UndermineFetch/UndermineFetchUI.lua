local UDMF_UI = {
	frame=nil
}

-- function UDMF_UI_new()
-- 	mf = {}
-- 	setmetatable(mf, self)
-- 	UDMF_UI.__index = self
-- 	UDMF_UI.frame = nil
-- 	return mf
-- end

function UDMF_UI_SetUrl(url, itemLink)
	UDMF_UI.urlTextBox:SetText(url)
	UDMF_UI.urlTextBox:HighlightText()

	UDMF_UI.itemNameText:SetText(itemLink)
end

function UDMF_UI_Show(url, itemLink)
	if not UDMF_UI.frame then
		UDMF_UI_Init()
	end

	PlaySound("igMainMenuOption")

	UDMF_UI_SetUrl(url, itemLink)
	UDMF_UI.frame:Show()
end

function UDMF_UI_Hide()
	PlaySound("igMainMenuOption")
	UDMF_UI.frame:Hide()
end

function UDMF_UI_Init()
	-- print("Init main frame")

	-- UDMF_MinimapButton_Reposition()

	UDMF_UI.frame = CreateFrame("frame", "UDMF_MainFrame")
	UDMF_UI.frame:SetBackdrop({
	      bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
	      edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
	      tile=1, tileSize=32, edgeSize=32, 
	      insets={left=11, right=12, top=12, bottom=11}
	})
	UDMF_UI.frame:SetWidth(300)
	UDMF_UI.frame:SetHeight(100)
	UDMF_UI.frame:SetPoint("CENTER",UIParent)
	UDMF_UI.frame:EnableMouse(true)
	UDMF_UI.frame:SetMovable(true)
	UDMF_UI.frame:RegisterForDrag("LeftButton")
	UDMF_UI.frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	UDMF_UI.frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	UDMF_UI.frame:SetFrameStrata("FULLSCREEN_DIALOG")

	UDMF_UI.urlTextBoxContainer = CreateFrame("frame", "UDMF_UrlTextBoxContainer", UDMF_UI.frame)
	UDMF_UI.urlTextBoxContainer:SetWidth(260)
	UDMF_UI.urlTextBoxContainer:SetHeight(30)
	UDMF_UI.urlTextBoxContainer:SetPoint("CENTER", UDMF_UI.frame, "CENTER", 0, 0)
	UDMF_UI.urlTextBoxContainer:SetBackdrop({
	      bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
	      edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
	      tile=1, tileSize=16, edgeSize=16, 
	      insets={left=1, right=1, top=1, bottom=1}
	})

	UDMF_UI.urlTextBox = CreateFrame("EditBox", "UDMF_UrlTextBox", UDMF_UI.urlTextBoxContainer)
	UDMF_UI.urlTextBox:SetWidth(240)
	UDMF_UI.urlTextBox:SetHeight(24)
	UDMF_UI.urlTextBox:SetMultiLine(false)
	UDMF_UI.urlTextBox:SetAutoFocus(true)
	UDMF_UI.urlTextBox:SetFontObject(GameFontHighlight)
	UDMF_UI.urlTextBox:SetPoint("CENTER", UDMF_UI.urlTextBoxContainer, "CENTER", 0, 0)
	UDMF_UI.urlTextBox:SetScript("OnEscapePressed", UDMF_UI_Hide)

	UDMF_UI.itemNameText = UDMF_UI.frame:CreateFontString("UDMF_ItemNameText", "OVERLAY", "GameFontNormal")
	UDMF_UI.itemNameText:SetPoint("TOP", UDMF_UI.frame, "TOP", 0, -10)
	UDMF_UI.itemNameText:SetHeight(20)
	-- UDMF_UI.itemNameText:SetScript("OnHyperlinkEnter", OnItemLinkEnter)	

	
	UDMF_UI.closeButton = CreateFrame("button", "UDMF_CloseButton", UDMF_UI.frame, "UIPanelButtonTemplate")
	UDMF_UI.closeButton:SetHeight(24)
	UDMF_UI.closeButton:SetWidth(60)
	UDMF_UI.closeButton:SetPoint("BOTTOM", UDMF_UI.frame, "BOTTOM", 0, 10)
	UDMF_UI.closeButton:SetText("Close")
	UDMF_UI.closeButton:SetScript("OnClick", UDMF_UI_Hide)

	-- local mmicon = CreateFrame("button", "UDMF_MinimapIcon", Minimap)
	-- mmicon:SetPoint("BOTTOM")
	-- mmicon:SetHeight(33)
	-- mmicon:SetWidth(33)
end