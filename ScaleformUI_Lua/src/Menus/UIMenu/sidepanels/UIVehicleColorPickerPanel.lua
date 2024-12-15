UIVehicleColorPickerPanel = setmetatable({}, UIVehicleColorPickerPanel)
UIVehicleColorPickerPanel.__index = UIVehicleColorPickerPanel
UIVehicleColorPickerPanel.__call = function() return "UIVehicleColorPickerPanel", "UIVehicleColorPickerPanel" end

function UIVehicleColorPickerPanel.New(side, title, color)
    local _titleColor
    if color ~= SColor.HUD_None then
        _titleColor = color
    else
        _titleColor = SColor.HUD_None
    end

    _UIVehicleColorPickerPanel = {
        PanelSide = side,
        Title = title,
        TitleColor = _titleColor,
        TitleType = 0,
        Value = 1,
        ParentItem = nil,
        Color = SColor.HUD_None,
        PickerSelect = function(menu, item, newindex, color)
        end,
        PickerHovered = function(menu, item, index, color)
        end
    }
    return setmetatable(_UIVehicleColorPickerPanel, UIVehicleColorPickerPanel)
end

function UIVehicleColorPickerPanel:SetParentItem(Item) -- required
    print(Item())
    if Item() ~= nil then
        self.ParentItem = Item
    else
        return self.ParentItem
    end
end

function UIVehicleColorPickerPanel:UpdatePanelTitle(title)
    self.Title = title
    if self.ParentItem ~= nil and self.ParentItem:SetParentMenu() ~= nil and self.ParentItem:SetParentMenu():Visible() then
        local item = IndexOf(self.ParentItem.Base.ParentMenu.Items, self.ParentItem) - 1
        ScaleformUI.Scaleforms._ui:CallFunction("UPDATE_SIDE_PANEL_TITLE", item, title)
    end
end

function UIVehicleColorPickerPanel:_PickerSelect(color)
    self.Color = color
    self.PickerSelect(self.ParentItem.ParentMenu, self.ParentItem, self.Value, self.Color)
end

function UIVehicleColorPickerPanel:_PickerHovered(colorId, color)

    self.PickerHovered(self:SetParentItem():SetParentMenu(), colorId, color)
end

function UIVehicleColorPickerPanel:_PickerRollout()
    self.PickerHovered(self:SetParentItem():SetParentMenu(), self.ParentItem, self.Value, self.Color)
end
