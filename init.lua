local current_mod_name = minetest.get_current_modname()
local current_mod_path = minetest.get_modpath(current_mod_name)

local lanapixel_path = current_mod_path .. "/fonts/LanaPixel.ttf"
local monogram_path = current_mod_path .. "/fonts/Monogram.ttf"

minetest.register_on_player_receive_fields(function(player, formname, fields)
  if formname ~= "pixel_fonts" then return end
  local player_name = player:get_player_name()
  local settings = minetest.settings
  if fields.install then
    settings:set("font_path", lanapixel_path)
    settings:set("font_size", 22)
    settings:set("mono_font_path", monogram_path)
    settings:set("chat_font_size", 32)
  elseif fields.uninstall then
    settings:remove "font_path"
    settings:remove "font_size"
    settings:remove "mono_font_path"
    settings:remove "chat_font_size"
  end
  settings:write()
  minetest.chat_send_player(
    player_name,
    "Please exit the game and disable this mod.\n"
      .. "Exiting is necessary for the fonts to be fully applied,\n"
      .. "and there's no need to keep the mod enabled."
  )
  minetest.close_formspec(player_name, "pixel_fonts")
end)

local function open_font_formspec(player_name)
  local formspec = [[
    size[4,3]
    button[0.5,0.5;3,1;install;Install fonts]
    button[0.5,1.5;3,1;uninstall;Uninstall fonts]
  ]]
  minetest.show_formspec(player_name, "pixel_fonts", formspec)
end

minetest.register_on_joinplayer(
  function(player) open_font_formspec(player:get_player_name()) end
)
