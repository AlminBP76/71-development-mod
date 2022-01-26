--------------------------------
------- Created by Hamza -------
-------------------------------- 

Config = {}

-- Pawn Shop Positions:
Config.PawnZones = {
	PawnShops = {
		Pos = {
			{x = 388.31,  y = -733.18, z = 29.29},
		}
	}
}

-- Pawn Shop Blip Settings:
Config.EnablePawnShopBlip = true
Config.BlipSprite = 501
Config.BlipDisplay = 4
Config.BlipScale = 0.65
Config.BlipColour = 5
Config.BlipName = "Prodaja preradjenih prozivoda"

-- Pawn Shop Marker Settings:
Config.KeyToOpenShop = 38														-- default 38 is E
Config.ShopMarker = 27 															-- marker type
Config.ShopMarkerColor = { r = 255, g = 255, b = 0, a = 100 } 					-- rgba color of the marker
Config.ShopMarkerScale = { x = 1.0, y = 1.0, z = 1.0 }  						-- the scale for the marker on the x, y and z axis
Config.ShopDraw3DText = "Pritisni ~g~[E]~s~ da ~y~Prodas~s~"					-- set your desired text here

-- Pawn Shop Item List:
Config.ItemsInPawnShop = {
	{ itemName = 'drvo', label = 'Drvo', BuyInPawnShop = false, BuyPrice = 1000, SellInPawnShop = true, SellPrice = 32 },
	{ itemName = 'jabuka', label = 'Jabuka', BuyInPawnShop = false, BuyPrice = 2000, SellInPawnShop = true, SellPrice = 35 },
	{ itemName = 'tkanina', label = 'Tkanina', BuyInPawnShop = false, BuyPrice = 500, SellInPawnShop = true, SellPrice = 30 },
}

