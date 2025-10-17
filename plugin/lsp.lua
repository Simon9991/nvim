vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	float = {
		style = "minimal",
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
})
-- put early in lsp.lua
local orig = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	opts.max_width = opts.max_width or 80
	opts.max_height = opts.max_height or 24
	opts.wrap = opts.wrap ~= false
	return orig(contents, syntax, opts, ...)
end

-- 4) Per-buffer behavior on LSP attach (keymaps, auto-format, completion)
-- See :help LspAttach for the recommended pattern
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		local buf = args.buf
		local map = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf })
		end

		-- Keymaps (use builtin LSP buffer functions)
		map("n", "K", vim.lsp.buf.hover)
		map("n", "gd", vim.lsp.buf.definition)
		map("n", "gD", vim.lsp.buf.declaration)
		map("n", "gi", vim.lsp.buf.implementation)
		map("n", "go", vim.lsp.buf.type_definition)
		map("n", "gr", vim.lsp.buf.references)
		map("n", "gs", vim.lsp.buf.signature_help)
		map("n", "gl", vim.diagnostic.open_float)
		map("n", "<F2>", vim.lsp.buf.rename)
		map({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end)
		map("n", "<F4>", vim.lsp.buf.code_action)
		map("n", "<leader>gs", vim.lsp.buf.code_action)
		local conform_ft = {
			javascript = true,
			javascriptreact = true,
			typescript = true,
			typescriptreact = true,
			json = true,
			jsonc = true,
			cs = true,
		}

		local excluded_filetypes = { php = true }

		if
			not conform_ft[vim.bo[buf].filetype]
			and not excluded_filetypes[vim.bo[buf].filetype]
			and client:supports_method("textDocument/formatting")
			and not client:supports_method("textDocument/willSaveWaitUntil")
		then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("my.lsp.format", { clear = false }),
				buffer = buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 2000 })
				end,
			})
		end
	end,
})

-- 5) Define the Lua language server config (no mason/lspconfig)
-- See :help lsp-new-config and :help vim.lsp.config()
local caps = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	capabilities = caps,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.config["cssls"] = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	capabilities = caps,
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}

-- Rust --
vim.lsp.config["rust-analyzer"] = {
	capabilities = caps,
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
	single_file_support = true,
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = true,
			},
		},
	},
	before_init = function(init_params, config)
		-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
		if config.settings and config.settings["rust-analyzer"] then
			init_params.initializationOptions = config.settings["rust-analyzer"]
		end
	end,
}

-- Nix LSP (nil)
vim.lsp.config["nil_ls"] = {
	cmd = { "nil" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "default.nix", ".git" },
	capabilities = caps,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixpkgs-fmt" }, -- or "alejandra" if you prefer
			},
		},
	},
}

-- Svelte --
vim.lsp.config["svelte"] = {
	cmd = { "svelteserver", "--stdio" }, -- Nix binary name
	filetypes = { "svelte" },
	-- Keep a sane root detection; you set a repo-wide default of '.git' above,
	-- but Svelte projects usually have one of these:
	root_markers = {
		"svelte.config.js",
		"svelte.config.cjs",
		"svelte.config.ts",
		"package.json",
		".git",
	},
	capabilities = caps,
	-- Optional: if your project vendors TS, help the LS find it
	-- init_options = {
	--   typescript = { tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib' }
	-- },
}

-- ts_ls
vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	capabilities = caps,
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}

-- Golang
vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	capabilities = caps,
	settings = {
		gopls = {
			-- completions/UX
			usePlaceholders = true,
			completeUnimported = true,
			-- static analysis
			staticcheck = true,
			analyses = {
				unusedparams = true,
				unusedwrite = true,
				nilness = true,
				shadow = true,
			},
			-- formatting (gopls formats + organizes imports)
			gofumpt = true, -- stricter formatting style
			-- Optional: hint overlays
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
	on_attach = function(client, _)
		-- Keep LSP formatting enabled for Go so your existing BufWritePre
		-- autocmd will call `vim.lsp.buf.format(...)`.
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
	end,
}

-- OmniSharp setup --
-- Using FileType autocmd + vim.lsp.start() because C# projects need custom
-- root detection logic (.sln/.csproj matching) that doesn't work reliably
-- with vim.lsp.config's root_markers approach
local function enable_semantic_tokens(client)
	local p = client.server_capabilities
	if p and p.semanticTokensProvider and not p.semanticTokensProvider.full then
		p.semanticTokensProvider.full = true
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function(args)
		-- Don't start if OmniSharp is already attached
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "omnisharp" then
				return
			end
		end

		-- Find .sln or .csproj to determine project root
		local function root(buf)
			local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(buf))
			local hit = vim.fs.find(function(n)
				return n:match("%.sln$") or n:match("%.csproj$")
			end, { upward = true, path = dir })[1]
			return (hit and vim.fs.dirname(hit)) or vim.fs.root(buf, { ".git" }) or vim.loop.cwd()
		end

		vim.lsp.start({
			name = "omnisharp",
			cmd = { "OmniSharp", "-lsp" },
			root_dir = root(args.buf),
			capabilities = caps,
			init_options = {
				FormattingOptions = {
					EnableEditorConfigSupport = false,
					OrganizeImports = false,
				},
				RoslynExtensionsOptions = {
					EnableAnalyzersSupport = true,
					EnableDecompilationSupport = true,
					InlayHintsOptions = {
						EnableForParameters = true,
						ForLiteralParameters = true,
						ForIndexerParameters = true,
						ForOtherParameters = true,
						SuppressForParametersThatDifferOnlyBySuffix = false,
						SuppressForParametersThatMatchMethodIntent = false,
						SuppressForParametersThatMatchArgumentName = false,
					},
				},
				MarkdownOptions = {
					SupportGitHubStyle = true,
				},
				MsBuild = {
					UseModernNet = true,
					LoadProjectsOnDemand = true,
				},
			},
			on_attach = function(client, bufnr)
				enable_semantic_tokens(client)

				-- CSharpier (conform.nvim) handles formatting
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				-- Organize imports on save
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("csharp.organize_imports", { clear = false }),
					buffer = bufnr,
					callback = function()
						pcall(vim.lsp.buf.execute_command, {
							command = "omnisharp/runCodeAction",
							arguments = {
								{ Identifier = "usingdirective_sort", WantsTextChanges = true, ApplyChanges = true },
							},
						})
					end,
				})
			end,
		})
	end,
})

-- Ruff (Python linter & formatter)
vim.lsp.config["ruff"] = {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
	capabilities = caps,
	init_options = {
		settings = {
			-- Ruff language server settings
			lineLength = 88,
			lint = {
				select = { "E", "F", "I" }, -- Enable pycodestyle, pyflakes, isort
			},
		},
	},
}

-- BasedPyright (Python type checker)
vim.lsp.config["basedpyright"] = {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	capabilities = caps,
	single_file_support = true,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard", -- off, basic, standard, strict, all
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				autoImportCompletions = true,
				diagnosticsMode = "openFilesOnly", -- workspace or openFilesOnly
			},
		},
	},
}

-- Tailwindcss
vim.lsp.config["tailwindcss"] = {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
	},
	root_markers = {
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"tailwind.config.ts",
		"postcss.config.js",
		"postcss.config.cjs",
		"postcss.config.mjs",
		"postcss.config.ts",
		"package.json",
		".git",
	},
	capabilities = caps,
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "classList", "ngClass" },
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			validate = true,
		},
	},
}

vim.lsp.enable("luals")
vim.lsp.enable("cssls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("rust-analyzer")
vim.lsp.enable("svelte")
vim.lsp.enable("gopls")
vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")
vim.lsp.enable("tailwindcss")
