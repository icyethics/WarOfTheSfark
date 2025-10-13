SMODS.Atlas {
  key = "war_jokers", 
  atlas_table = "ASSET_ATLAS", 
  path = "war_jokers.png", 
  px = 71, 
  py = 95  
}

local files = NFS.getDirectoryItems(SMODS.current_mod.path .. "items/jokers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/jokers/" .. file))()
end
