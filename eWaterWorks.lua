-- =============================================================================
--
--       Filename:  eWaterWorks.lua
--
--    Description:  Warns you if you don't have your water elemental out.
--
--        Version:  6.2.1
--
--         Author:  Mathias Jost (mail@mathiasjost.com)
--
-- =============================================================================


-- -----------------------------------------------------------------------------
-- Create the addon frame
-- -----------------------------------------------------------------------------
local eWaterWorks = CreateFrame("Frame", "eWaterWorks", UIParent)

eWaterWorks:SetFrameStrata("BACKGROUND")
eWaterWorks:SetWidth(100)
eWaterWorks:SetHeight(100)
eWaterWorks:SetAlpha(1.0)

-- sets the frames texture
local eWaterWorksTexture = eWaterWorks:CreateTexture(nil,"BACKGROUND")

-- the texture is the spells icon
eWaterWorksTexture:SetTexture(GetSpellTexture(31687))
eWaterWorksTexture:SetAllPoints(eWaterWorks)
eWaterWorks.texture = eWaterWorksTexture

eWaterWorks:SetPoint("CENTER", 0, 200)
eWaterWorks:Hide()


-- -----------------------------------------------------------------------------
-- Register events
-- -----------------------------------------------------------------------------
eWaterWorks:RegisterEvent("UNIT_PET")
eWaterWorks:RegisterEvent("PLAYER_ENTERING_WORLD")
eWaterWorks:RegisterEvent("RAID_INSTANCE_WELCOME")


-- -----------------------------------------------------------------------------
-- Event Handler
-- -----------------------------------------------------------------------------
eWaterWorks:SetScript("OnEvent", function(self, event, ...)
	-- gets the instance type
	local IsInstance, InstanceType = IsInInstance()

	-- check if player is in instance and if the instance is a raid
	if IsInstance and InstanceType == "raid" then
		-- get info on the state of the pet
		isPetOut = HasPetUI()

		-- is the water elemental out?
		if isPetOut == nil then
			-- we show the warning frame because the pet is NOT out
			eWaterWorks:Show()
		else
			-- we hide the warning frame because the pet IS out
			eWaterWorks:Hide()
		end -- if isPetOut == nil then
	else
		-- hide the Warning if you are not in a raid
		eWaterWorks:Hide()
	end -- if IsInstance and InstanceType == "raid" then

end) -- eWaterWorks:SetScript("OnEvent", function()