local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local max_workspaces = 4
local query_workspaces = "aerospace list-workspaces --all --format '%{workspace}%{monitor-id}' --json"
local query_monitor = "aerospace list-monitors --count"
local workspace_monitor = {}

-- Add padding to the left
sbar.add("item", {
	icon = {
		color = colors.white,
		highlight_color = colors.red,
		drawing = false,
	},
	label = {
		color = colors.grey,
		highlight_color = colors.white,
		drawing = false,
	},
	background = {
		color = colors.bg1,
		border_width = 1,
		height = 28,
		border_color = colors.black,
		corner_radius = 9,
		drawing = false,
	},
	padding_left = 6,
	padding_right = 0,
})

local workspaces = {}

local function updateWindows(workspace_index)
	local get_windows =
		string.format("aerospace list-windows --workspace %s --format '%%{app-name}' --json", workspace_index)
	sbar.exec(get_windows, function(open_windows)
		local icon_line = ""
		local no_app = true
		for i, open_window in ipairs(open_windows) do
			no_app = false
			local app = open_window["app-name"]
			local lookup = app_icons[app]
			local icon = ((lookup == nil) and app_icons["default"] or lookup)
			icon_line = icon_line .. " " .. icon
		end
		sbar.animate("tanh", 10, function()
			if no_app then
				workspaces[workspace_index]:set({
					icon = { drawing = false },
					label = { drawing = false },
					background = { drawing = false },
					padding_right = 0,
					padding_left = 0,
				})
				return
			end

			workspaces[workspace_index]:set({
				icon = { drawing = true },
				label = { drawing = true, string = icon_line },
				background = { drawing = true },
				padding_right = 1,
				padding_left = 1,
			})
		end)
	end)
end

local function updateWorkspaceMonitor(workspace_index)
	sbar.exec(query_workspaces, function(workspaces_and_monitors)
		sbar.exec(query_monitor, function(monitor_number)
			local monitor_id_map = {}
			if tonumber(monitor_number) ~= 1 then
				monitor_id_map = { [1] = 2, [2] = 1 } -- sketchybar monitor id is different from aerospace monitor id which is need to map monitor id
			else
				monitor_id_map = { [1] = 1, [2] = 2 }
			end
			for _, entry in ipairs(workspaces_and_monitors) do
				local space_index = tonumber(entry.workspace)
				local monitor_id = math.floor(entry["monitor-id"])
				workspace_monitor[space_index] = monitor_id_map[monitor_id]
			end
			-- workspaces[workspace_index]:set({
			-- 	display = workspace_monitor[workspace_index],
			-- })
			workspaces[tonumber(focused_workspace)]:set({
				icon = { highlight = true },
				label = { highlight = true },
				background = { border_width = 2 },
			})
		end)
	end)
end

for workspace_index = 1, max_workspaces do
	local workspace = sbar.add("item", {
		icon = {
			color = colors.white,
			highlight_color = colors.red,
			drawing = false,
			font = { family = settings.font.numbers },
			string = workspace_index,
			padding_left = 10,
			padding_right = 5,
		},
		label = {
			padding_right = 12,
			color = colors.grey,
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
		},
		padding_right = 2,
		padding_left = 2,
		background = {
			color = colors.bg1,
			border_width = 1,
			height = 28,
			border_color = colors.bg2,
		},
		click_script = "aerospace workspace " .. workspace_index,
	})

	workspaces[workspace_index] = workspace

	workspace:subscribe("aerospace_workspace_change", function(env)
		local focused_workspace = tonumber(env.FOCUSED_WORKSPACE)
		local is_focused = focused_workspace == workspace_index

		sbar.animate("tanh", 10, function()
			workspace:set({
				icon = { highlight = is_focused },
				label = { highlight = is_focused },
				background = {
					border_width = is_focused and 2 or 0,
				},
			})
		end)
	end)

	workspace:subscribe("aerospace_focus_change", function()
		updateWindows(workspace_index)
	end)

	workspace:subscribe("display_change", function()
		updateWindows(workspace_index)
		updateWorkspaceMonitor(workspace_index)
	end)

	-- initial setup
	updateWindows(workspace_index)
	updateWorkspaceMonitor(workspace_index)
	sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
		workspaces[tonumber(focused_workspace)]:set({
			icon = { highlight = true },
			label = { highlight = true },
			background = { border_width = 2 },
		})
	end)
end

-- for i = 1, 10, 1 do
--   local space = sbar.add("space", "space." .. i, {
--     space = i,
--     icon = {
--       drawing = false,
--     },
--     label = {
--       padding_left = 2,
--       padding_right = 0,
--       color = colors.grey,
--       highlight_color = colors.white,
--     },
--     padding_right = 1,
--     padding_left = 1,
--     background = {
--       color = colors.spaces.inactive,
--       border_width = 0,
--       border_color = colors.black,
--     },
--     popup = { background = { border_width = 0, border_color = colors.black } }
--   })
--
--   spaces[i] = space
--
--   -- Single item bracket for space items to achieve double border on highlight
--   local space_bracket = sbar.add("bracket", { space.name }, {
--     background = {
--       color = colors.transparent,
--       border_color = colors.bg2,
--       border_width = 0
--     }
--   })
--
--   -- Padding space
--   sbar.add("space", "space.padding." .. i, {
--     space = i,
--     script = "",
--     width = settings.group_paddings,
--   })
--
--   local space_popup = sbar.add("item", {
--     position = "popup." .. space.name,
--     padding_left = 5,
--     padding_right = 0,
--     background = {
--       drawing = true,
--       image = {
--         corner_radius = 9,
--         scale = 0.2
--       }
--     }
--   })
--
--   space:subscribe("space_change", function(env)
--     local selected = env.SELECTED == "true"
--     space:set({
--       icon = { highlight = selected },
--       label = { highlight = selected },
--       background = {
--         color = selected and colors.spaces.active or colors.spaces.inactive,
--         border_color = selected and colors.red or colors.black
--       },
--       width = selected and 30 or 30
--     })
--     space_bracket:set({
--       background = { color = colors.transparent, border_color = selected and colors.red or colors.bg2 }
--     })
--   end)
--
--   space:subscribe("mouse.clicked", function(env)
--     if env.BUTTON == "other" then
--       space_popup:set({ background = { image = "space." .. env.SID } })
--       space:set({ popup = { drawing = "toggle" } })
--     else
--       local op = (env.BUTTON == "right") and "--destroy" or "--focus"
--       sbar.exec("yabai -m space " .. op .. " " .. env.SID)
--     end
--   end)
--
--   space:subscribe("mouse.entered", function(env)
--     space_popup:set({ background = { image = "space." .. env.SID } })
--     space:set({ popup = { drawing = "toggle" } })
--   end)
--
--   space:subscribe("mouse.exited", function(_)
--     space:set({ popup = { drawing = false } })
--   end)
--
-- end
--
-- local space_window_observer = sbar.add("item", {
--   drawing = false,
--   updates = true,
-- })
