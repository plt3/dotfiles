local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dapui = require("dapui")
local nmap = require("pault.utils").normalMap
local nrepmap = require("pault.utils").normalRepeatableMap
local jdtls = require("jdtls")

mason_dap.setup({
	ensure_installed = { "python", "codelldb", "delve", "javadbg" },
	automatic_setup = true,
	handlers = {
		function(source_name)
			-- all sources with no handler get passed here
			-- Keep original functionality of `automatic_setup = true`
			require("mason-nvim-dap.automatic_setup")(source_name)
		end,
		python = function(source_name)
			dap.adapters.python = function(callback, config)
				-- this basically returns the correct adapter config based on if
				-- we're trying to launch or attach
				if config.request == "launch" then
					callback({
						type = "executable",
						command = "debugpy-adapter",
					})
				else
					local userPort = vim.fn.input("Port: ", "5678")
					callback({
						type = "server",
						port = userPort,
						host = "127.0.0.1",
					})
				end
			end

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch Python file",
					program = "${file}", -- This configuration will launch the current file if used.
					args = function()
						local argument_string = vim.fn.input("Program arguments: ")
						return vim.fn.split(argument_string, " ", true)
					end,
				},
				{
					-- for this, run python3 -m debugpy --listen localhost:5678 --wait-for-client file.py
					type = "python",
					request = "attach",
					name = "Attach to Python file",
				},
			}
		end,
		codelldb = function(source_name)
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.cpp = { -- compile with g++ -g file.cpp
				{
					type = "codelldb",
					request = "launch",
					name = "Launch C++ file",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = function()
						local argument_string = vim.fn.input("Program arguments: ")
						return vim.fn.split(argument_string, " ", true)
					end,
				},
				{
					type = "codelldb",
					request = "attach",
					name = "Attach to C++ process",
					pid = require("dap.utils").pick_process,
				},
			}
		end,
	},
})

dapui.setup()

-- open dap-ui when starting debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

-- debugging remaps
nmap("<leader>d<space>", dap.continue)
-- must run this before debugging a java file
nmap("<leader>dd", function()
	jdtls.setup_dap()
	require("jdtls.dap").setup_dap_main_class_configs()
	print("Java DAP initialization complete")
end)
nrepmap("<leader>db", dap.toggle_breakpoint)
nrepmap("<leader>dj", dap.step_over)
nmap("<leader>dk", dap.step_out)
nmap("<leader>dl", dap.step_into)
nrepmap("<leader>dc", dap.run_to_cursor)
nmap("<leader>di", require("dap.ui.widgets").hover)
nmap("<leader>d_", dap.run_last) -- restart debugging
nmap("<leader>de", function()
	dap.terminate()
	dapui.close()
end)
